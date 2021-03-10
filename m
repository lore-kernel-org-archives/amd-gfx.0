Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E433AC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 14:09:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A5CC64FE5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 14:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5CC64FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43D2F6EA1F;
	Wed, 10 Mar 2021 14:09:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78B7B6EA1F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 14:09:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3mVdH8F1cli2QtI65xklUX4UhG1aSfHh0JZYMvJPNKZLfkStu91rruDGFEsF5/SWqBqc3G70Jrai2XX3OBc/vugeYajxqW8Oum4Uw462I1xkUYFvY4ZbV3J857DhZTwQl9NN0/K6TX97fWvnceflToSHCcE12P7Bb0NV+4+8D0GJg/OMZl6HoJaDyWS5toFqctJNRyGumPz8kxzldRojg9+txLt8gBeDoIshQ4JM6d6RM/y1kRRNEPUe7w+k0yRyJDgxAHk6rTQ+fx1hMyirPoRc7Wcy7a2QL/M7PXeWlUZUc4162a71RBlJzsmrhlFxIabzDaKPoCirgr+2B6nIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFXnqTZOTmmx4nLoBYSKgNY7Tin84zLnPKCRt3tu4l4=;
 b=OMPeUAicX3IXn8Qd/gBMbkQL+59fmmraOoJuYBT97AwNblBg1f3WKJ5HfGsTHb/QktPXEiDjFmfGK7lHzZbrH8d26E847wlM9PDrs3K1I4RjUULaXhriU6xERz8+QVi0vqOiab0q94hiube0qMPMAE2qA10ev0vT/UWIZuA6bASfhtTBeYTMsuklO1Q/iQec7ehjeKOOW8uF1fnUffzFhFPnXXJ8yiMfTBIX8vcI/wa08rKqIZHxhJ/4A9ME9vbE91UuNXnX+dZlaTdglBGoTxXomy2yvbDpdeVKXrAw0kUJUaS+ZYhCqr5EbBg1QKJNCgpQ81qaveEfvSEN51X/jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFXnqTZOTmmx4nLoBYSKgNY7Tin84zLnPKCRt3tu4l4=;
 b=oE+n73d/TxrHbHPyVa123jlEUOquJirWan7stXj12VohxTz6UkUSxhLQEvJZi2FpdL3WXQeyOB0EL6wyJtcv7hafD5Vo0eNCQ/dISs5Tb2qy23zwG2JPiQeAiN9CsDhcM/JdBdfchNAhcRs8gTQC2hyBavYpa9o0f8dnz3ohJ3U=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.28; Wed, 10 Mar
 2021 14:09:40 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 14:09:39 +0000
Subject: Re: [PATCH v4] drm/amd/amdgpu implement tdr advanced mode
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>
References: <20210310111921.928619-1-Jack.Zhang1@amd.com>
 <70e3aabc-6bb0-b88c-0e97-de42e1e8b8e6@amd.com>
 <DM5PR1201MB02044274BD6BB85B3828074FBB919@DM5PR1201MB0204.namprd12.prod.outlook.com>
 <59f47063-0d33-ff9c-b91e-fdd85baf5eac@amd.com>
 <DM5PR1201MB0204120DC4A44A5A32196901BB919@DM5PR1201MB0204.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1d11677b-f5ac-101c-3635-aaa87b1b65ff@amd.com>
Date: Wed, 10 Mar 2021 15:09:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <DM5PR1201MB0204120DC4A44A5A32196901BB919@DM5PR1201MB0204.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:ab69:e3f0:8e97:e79b]
X-ClientProxiedBy: AM0PR10CA0069.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::22) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:ab69:e3f0:8e97:e79b]
 (2a02:908:1252:fb60:ab69:e3f0:8e97:e79b) by
 AM0PR10CA0069.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 14:09:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a04178f-33dc-4cd6-0369-08d8e3ce24d3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4389:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43895BF2E843DD5A633AC33D83919@MN2PR12MB4389.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /72yVn0IM3wiJdSCMHzsEztpBhnUhrlCYJvbNZQHSRUE9jMzhRjJ9YOt/vG6/N5w1CxsVrpNMohXuoeBogHD7Mt8Qxq4duoU1jYSR2bvAH9UWL18krYow+TIuLTZFM7rhVbhajirHQbQN8pZ2tTRZUGTR3njbvD65tYMTqrkgeUdEmPU5KgVpMUChOHXso8OT1eeak1zPrc60QT898xXLd2e1SV8tAIVkCwMJ6AcWNreTjh5bnxIx3t6qWzq44J6IXWbSGHYAEHzx1dRJTmsoOqbq34j06JnLFD1+O4VYl9IN9yvoVTZ3fNUXu3kRiPdb6txO8qpXRqHnULbNqZ4p1DXR7b1B6JRJ2feylCJF9YPK1fRPOiJgn5ah32HyNOLyxomqWMnQQ9M81W96ePYBv5j7Vnjlq0zrIS9kSXjLrKyGHu/Q1QOTPZOzXW91jK9UbH0xSAJzADX02w5a5HjJcONz6ER+M9mt7k7BPCeaWbfz3yDtqUULiEYhFFyknm0X6udd1Xv/rSHFZ+sF6xUxRhdYzo3xwpV4BC7iItBdaNZL4wwj7TVsts9zYPPcZt87udKjdVgX/nPKPFOOegVmWO7hT+lUlhz9m97SlkNthw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(30864003)(8936002)(36756003)(186003)(66476007)(52116002)(5660300002)(86362001)(31696002)(53546011)(66946007)(316002)(33964004)(16526019)(110136005)(8676002)(66556008)(6666004)(6636002)(2906002)(6486002)(2616005)(31686004)(83380400001)(478600001)(45980500001)(43740500002)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b0VhTERQUXZwbTVIdStQY1VVVTFKZ0JRVFl4SXM4dGtmTmU0L3F4dmc5cS8v?=
 =?utf-8?B?TXRPd0g5azJRYUFkVTV5Sk9qQlcwR3lwbDI1bE0waUhVYUlBT1h3aHZaMUFV?=
 =?utf-8?B?U3pEampGdFN4SGtWTGczTjNNU1NWenRJVWxFWUhtTkR2ZElNYUlIbDFseGNp?=
 =?utf-8?B?aHdBeTV5WjNrTmdRdFE3dmhHOFpvKysvbFdRMjUvZWpwa0dqdFd0TFQwdTRv?=
 =?utf-8?B?TjFWZytrTGRUdDFEckFmSVRKWVQ2NkQwdHNyNmdGTmZzaHR5QUplWWt6V3pq?=
 =?utf-8?B?ZmIxOSt3aHRyRkFnZmJyMWxqMjlHNDlQZzRZSUZ1TEZ5NkNibHZRYU9qaVp3?=
 =?utf-8?B?U3JCVXZEL2hsRUdrc3BHUVpMa3ovaysxbkR6S2pMaExSdHZZNytqa0lNUEpU?=
 =?utf-8?B?YU9rWTN0eUI5RlVMaG5rNUFPdWRNNEZvanRZdDhBdnFTY1N0Qm9sRVAyTHZL?=
 =?utf-8?B?NllFTnBya3ZWZGlhNW53anlZSFVzc05oSmJEVDQ1NzFoK1BTTXc5Y0s1cWRx?=
 =?utf-8?B?NWVtVDc5RVFqeGtNVWZYajcrdjA4Z0tEZGc4bG5lRnd0eEFUODhZV1hLVFFm?=
 =?utf-8?B?ZTFJRnBubmxYMGtwOW8zc28yRTJycE5ISHBuU3phRkxNM0xpTG80cGVYVXBP?=
 =?utf-8?B?YTg2ZDdyb1Z0TzBMSVI4bXpYVFFOTjA1RTBpZlFDYlA1RFlIR1pvV0VnbEpR?=
 =?utf-8?B?NW9qNWY5bkR1QkthTklhanE5TkNaU3F3ZXg0UktEdUhuVi9oakRYSHIrNENy?=
 =?utf-8?B?amxIUXowcjJmNG1KUlpUUldxMVE5VjBBaE5jMStUczc0RUJvUXdXSHlVN0NY?=
 =?utf-8?B?dmJJUGVqREloNHRmNG1PRjN1U3A1dC90TVM5RXU2Q0ZZdTRmZjBsNjRZSW9L?=
 =?utf-8?B?YlhkRjBSM0RzMEpzbTRVNi9EUjlYN0lkdjRNR0tUYUtoQnM1UUkrOGhtQlBv?=
 =?utf-8?B?d3FzUzFkZTh0eG5yL3plWG5DMHcySzZsRDJNRjRXUVE1TExtaGxLdWpFbHNT?=
 =?utf-8?B?QmVPaVc5VFhYdmJSYm5EVUg1Z3JvdzZBMDlDdE1LcDJPZTd5aVNWK3BzeFhm?=
 =?utf-8?B?UXVKRHdyeEIyT2E3WW1mUDlNcjBSR0JEZy80S3FIQzJJNVVHTHNpZ0MyN0hJ?=
 =?utf-8?B?a1RqTUxhdG9mWHdnZGc4NGVHOVBpVEFVNFFhUEJRcEU3MjZ3bkJpcHpSSjZI?=
 =?utf-8?B?OG9SSVpkZUkvTnJlVVpiZVptK0p4RUJYWi9SdVF1S1NvNjVCYmVRUU43Ty9U?=
 =?utf-8?B?a1dObUtQOXFoenE2RFZ5T1NRZCtCWWZNOExOcmoyNzRORWx3UnlFdDYzZ3d3?=
 =?utf-8?B?WnJFTGVFajRPSk1hOVJVV256ZDhabTVFdnowdVRvMlU0aVQ4aE1yQWhXTi9Y?=
 =?utf-8?B?TjE1T2Rpcll4MnFLSTY5Z0JoRHBHNmRNLzJjaTdMZm45RFZBZjY0d1BGLzI2?=
 =?utf-8?B?T01NekVsRTQ5K245NXFoM1V1SWtaMm0xM0JUMkxQWVRUcFIyVk13ZDFNallJ?=
 =?utf-8?B?OG1WSGVTZXhJRktEczZPNDRiNklVL0ZUQ0ZoaURpSmR3MzlBVytvZzY2WThr?=
 =?utf-8?B?eHZMdWdoQnJFb0ZvaEN1NXNYVVBCSExTLzhjTWxNYnBTRzFtTDFqN2Nlcmk1?=
 =?utf-8?B?dFFiYnZuSHd4K3N5NFluMGpkVFhNMzFPNlhBeHo4cVMvODRocCt2NmRDK2xE?=
 =?utf-8?B?VElnNWNsOXoxMk1zOTRhbWJPUkJJOWhDQzBrdEh6cTdSNjJxRno1a1BCTEtJ?=
 =?utf-8?B?d1V6N1FHS3piaEROQW9pdUg3bFlYd0hMcFdtNVQ1OG4ybWFjL0FlZmQxcm1q?=
 =?utf-8?B?Y0VVZ0t1NFZ0RS8vSWVBMmkrOGJNUC84VFJKaDRZVTY0OGVWYVlZTmtPU3Ru?=
 =?utf-8?Q?qEOcPwOaj4Xnw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a04178f-33dc-4cd6-0369-08d8e3ce24d3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 14:09:39.7889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8WYKpMHg/RXPNf6q7vFKxAbFWIv1g8FmDD+6rqSfpDuOyzH+1sVMgaPl0fbxoNa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0255904589=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0255904589==
Content-Type: multipart/alternative;
 boundary="------------6D079B68AE3FDED59AEBA789"
Content-Language: en-US

--------------6D079B68AE3FDED59AEBA789
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Yeah, but wouldn't it be feasible to extend the existing function with 
parameters what to do like Andrey suggested? (It's possible that I just 
missed the response for this).

Christian.

Am 10.03.21 um 15:05 schrieb Zhang, Jack (Jian):
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
>
> As Monk previously explained in another mail session. Because the 
> drm_sched_resubmit_jobs submit all jobs which does not meet our needs.
>
> We need a new APi  drm_sched_resubmit_jobs2()
> to submit the first job of a ring. (also we can leverage the error 
> handling for Null or Error fence inside this function ).
>
> It seems clean to use this jobs2 function than writing the run_job + 
> some error handling in the main logic.
>
>
> Thanks，
> /Jack
>
>
>
>
>
> ------------------------------------------------------------------------
> *发件人:* Koenig, Christian <Christian.Koenig@amd.com>
> *发送时间:* 2021年3月10日星期三 下午9:49
> *收件人:* Zhang, Jack (Jian); amd-gfx@lists.freedesktop.org; Grodzovsky, 
> Andrey; Liu, Monk; Deng, Emily
> *主题:* Re: [PATCH v4] drm/amd/amdgpu implement tdr advanced mode
>
> Andrey needs to review the reste, but essentially I don't see the 
> reason why you need this drm_sched_resubmit_jobs2().
>
> Christian.
>
> Am 10.03.21 um 14:36 schrieb Zhang, Jack (Jian):
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>>
>> Thanks Christian， just did the checkpatch scan.  Please see the V6 patch
>>
>> /Jack
>>
>>
>> ------------------------------------------------------------------------
>> *From:* Koenig, Christian <Christian.Koenig@amd.com>
>> *Sent:* Wednesday, March 10, 2021 8:54:53 PM
>> *To:* Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; 
>> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; 
>> Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Liu, Monk 
>> <Monk.Liu@amd.com>; Deng, Emily <Emily.Deng@amd.com>
>> *Subject:* Re: [PATCH v4] drm/amd/amdgpu implement tdr advanced mode
>> Am 10.03.21 um 12:19 schrieb Jack Zhang:
>> > [Why]
>> > Previous tdr design treats the first job in job_timeout as the bad job.
>> > But sometimes a later bad compute job can block a good gfx job and
>> > cause an unexpected gfx job timeout because gfx and compute ring share
>> > internal GC HW mutually.
>> >
>> > [How]
>> > This patch implements an advanced tdr mode.It involves an additinal
>> > synchronous pre-resubmit step(Step0 Resubmit) before normal resubmit
>> > step in order to find the real bad job.
>> >
>> > 1. At Step0 Resubmit stage, it synchronously submits and pends for the
>> > first job being signaled. If it gets timeout, we identify it as guilty
>> > and do hw reset. After that, we would do the normal resubmit step to
>> > resubmit left jobs.
>> >
>> > 2. Re-insert Bailing job to mirror_list, and leave it to be handled by
>> > the main reset thread.
>> >
>> > 3. For whole gpu reset(vram lost), do resubmit as the old way.
>> >
>> > Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
>> > Change-Id: I408357f10b9034caaa1b83610e19e514c5fbaaf2
>> > ---
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 73 ++++++++++++++++++++-
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
>> >   drivers/gpu/drm/scheduler/sched_main.c | 75 ++++++++++++++++++++++
>> >   include/drm/gpu_scheduler.h |  2 +
>> >   4 files changed, 148 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> > index e247c3a2ec08..02056355a055 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> > @@ -4639,7 +4639,7 @@ int amdgpu_device_gpu_recover(struct 
>> amdgpu_device *adev,
>> >        int i, r = 0;
>> >        bool need_emergency_restart = false;
>> >        bool audio_suspended = false;
>> > -
>> > +     int     tmp_vram_lost_counter;
>>
>> Please keep the empoty line between declaration and code.
>>
>> In general give that patch a pass with checkpath.pl since there are a
>> couple of other place which needs fixing at first glance.
>>
>> Christian.
>>
>>
>> >        /*
>> >         * Special case: RAS triggered and full reset isn't supported
>> >         */
>> > @@ -4689,9 +4689,14 @@ int amdgpu_device_gpu_recover(struct 
>> amdgpu_device *adev,
>> >                dev_info(adev->dev, "Bailing on TDR for s_job:%llx, 
>> as another already in progress",
>> >                                        job ? job->base.id : -1);
>> >
>> > -             /* even we skipped this reset, still need to set the 
>> job to guilty */
>> > -             if (job)
>> > +             if (job) {
>> > +                     /* re-insert node to avoid memory leak */
>> > + spin_lock(&job->base.sched->job_list_lock);
>> > + list_add(&job->base.node, &job->base.sched->pending_list);
>> > + spin_unlock(&job->base.sched->job_list_lock);
>> > +                     /* even we skipped this reset, still need to 
>> set the job to guilty */
>> > drm_sched_increase_karma(&job->base);
>> > +             }
>> >                goto skip_recovery;
>> >        }
>> >
>> > @@ -4788,6 +4793,7 @@ int amdgpu_device_gpu_recover(struct 
>> amdgpu_device *adev,
>> >                }
>> >        }
>> >
>> > +     tmp_vram_lost_counter = 
>> atomic_read(&((adev)->vram_lost_counter));
>> >        /* Actual ASIC resets if needed.*/
>> >        /* TODO Implement XGMI hive reset logic for SRIOV */
>> >        if (amdgpu_sriov_vf(adev)) {
>> > @@ -4805,6 +4811,67 @@ int amdgpu_device_gpu_recover(struct 
>> amdgpu_device *adev,
>> >        /* Post ASIC reset for all devs .*/
>> >        list_for_each_entry(tmp_adev, device_list_handle, 
>> gmc.xgmi.head) {
>> >
>> > +             if (amdgpu_gpu_recovery == 2 &&
>> > +                     !(tmp_vram_lost_counter < 
>> atomic_read(&adev->vram_lost_counter))) {
>> > +
>> > +                     for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>> > +                             struct amdgpu_ring *ring = 
>> tmp_adev->rings[i];
>> > +                             int ret = 0;
>> > +                             struct drm_sched_job *s_job;
>> > +
>> > +                             if (!ring || !ring->sched.thread)
>> > + continue;
>> > +
>> > +                             /* No point to resubmit jobs if we 
>> didn't HW reset*/
>> > +                             if (!tmp_adev->asic_reset_res && 
>> !job_signaled) {
>> > +
>> > +                                     s_job = 
>> list_first_entry_or_null(&ring->sched.pending_list, struct 
>> drm_sched_job, list);
>> > +                                     if (s_job == NULL)
>> > + continue;
>> > +
>> > +                                     /* clear job's guilty and 
>> depend the folowing step to decide the real one */
>> > + drm_sched_reset_karma(s_job);
>> > + drm_sched_resubmit_jobs2(&ring->sched, 1);
>> > +                                     ret = 
>> dma_fence_wait_timeout(s_job->s_fence->parent, false, 
>> ring->sched.timeout);
>> > +
>> > +                                     if (ret == 0) { /* timeout */
>> > + DRM_ERROR("Found the real bad job! ring:%s, job_id:%llx\n", 
>> ring->sched.name, s_job->id);
>> > + /* set guilty */
>> > + drm_sched_increase_karma(s_job);
>> > +
>> > + /* do hw reset */
>> > + if (amdgpu_sriov_vf(adev)) {
>> > + amdgpu_virt_fini_data_exchange(adev);
>> > + r = amdgpu_device_reset_sriov(adev, false);
>> > + if (r)
>> > + adev->asic_reset_res = r;
>> > + } else {
>> > + r  = amdgpu_do_asic_reset(hive, device_list_handle, 
>> &need_full_reset, false);
>> > + if (r && r == -EAGAIN)
>> > + goto retry;
>> > + }
>> > +
>> > + /* add reset counter so that the following resubmitted job could 
>> flush vmid */
>> > + atomic_inc(&tmp_adev->gpu_reset_counter);
>> > + continue;
>> > +                                     }
>> > +
>> > +                                     /* got the hw fence, signal 
>> finished fence */
>> > + atomic_dec(&ring->sched.num_jobs);
>> > + dma_fence_get(&s_job->s_fence->finished);
>> > + dma_fence_signal(&s_job->s_fence->finished);
>> > + dma_fence_put(&s_job->s_fence->finished);
>> > +
>> > +
>> > +                                     /* remove node from list and 
>> free the job */
>> > + spin_lock(&ring->sched.job_list_lock);
>> > + list_del_init(&s_job->node);
>> > + spin_unlock(&ring->sched.job_list_lock);
>> > + ring->sched.ops->free_job(s_job);
>> > +                             }
>> > +                     }
>> > +             }
>> > +
>> >                for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>> >                        struct amdgpu_ring *ring = tmp_adev->rings[i];
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> > index 865f924772b0..9c3f4edb7532 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> > @@ -509,7 +509,7 @@ module_param_named(compute_multipipe, 
>> amdgpu_compute_multipipe, int, 0444);
>> >    * DOC: gpu_recovery (int)
>> >    * Set to enable GPU recovery mechanism (1 = enable, 0 = 
>> disable). The default is -1 (auto, disabled except SRIOV).
>> >    */
>> > -MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 
>> = enable, 0 = disable, -1 = auto)");
>> > +MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (2 
>> = advanced tdr mode, 1 = enable, 0 = disable, -1 = auto)");
>> >   module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
>> >
>> >   /**
>> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c 
>> b/drivers/gpu/drm/scheduler/sched_main.c
>> > index d82a7ebf6099..99a6a8bddd6f 100644
>> > --- a/drivers/gpu/drm/scheduler/sched_main.c
>> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> > @@ -395,6 +395,81 @@ void drm_sched_increase_karma(struct 
>> drm_sched_job *bad)
>> >   }
>> >   EXPORT_SYMBOL(drm_sched_increase_karma);
>> >
>> > +
>> > +void drm_sched_resubmit_jobs2(struct drm_gpu_scheduler *sched, int 
>> max)
>> > +{
>> > +     struct drm_sched_job *s_job, *tmp;
>> > +     uint64_t guilty_context;
>> > +     bool found_guilty = false;
>> > +     struct dma_fence *fence;
>> > +     int i = 0;
>> > +
>> > +     list_for_each_entry_safe(s_job, tmp, &sched->pending_list, 
>> list) {
>> > +             struct drm_sched_fence *s_fence = s_job->s_fence;
>> > +
>> > +             if (i>=max)
>> > +                     break;
>> > +
>> > +             if (!found_guilty && atomic_read(&s_job->karma) > 
>> sched->hang_limit) {
>> > +                     found_guilty = true;
>> > +                     guilty_context = 
>> s_job->s_fence->scheduled.context;
>> > +             }
>> > +
>> > +             if (found_guilty && s_job->s_fence->scheduled.context 
>> == guilty_context)
>> > + dma_fence_set_error(&s_fence->finished, -ECANCELED);
>> > +
>> > + dma_fence_put(s_job->s_fence->parent);
>> > +             fence = sched->ops->run_job(s_job);
>> > +             i++;
>> > +
>> > +             if (IS_ERR_OR_NULL(fence)) {
>> > +                     if (IS_ERR(fence))
>> > + dma_fence_set_error(&s_fence->finished, PTR_ERR(fence));
>> > +
>> > + s_job->s_fence->parent = NULL;
>> > +             } else {
>> > + s_job->s_fence->parent = fence;
>> > +             }
>> > +     }
>> > +}
>> > +EXPORT_SYMBOL(drm_sched_resubmit_jobs2);
>> > +
>> > +
>> > +
>> > +void drm_sched_reset_karma(struct drm_sched_job *bad)
>> > +{
>> > +     int i;
>> > +     struct drm_sched_entity *tmp;
>> > +     struct drm_sched_entity *entity;
>> > +     struct drm_gpu_scheduler *sched = bad->sched;
>> > +
>> > +     /* don't reset @bad's karma if it's from KERNEL RQ,
>> > +      * because sometimes GPU hang would cause kernel jobs (like 
>> VM updating jobs)
>> > +      * corrupt but keep in mind that kernel jobs always 
>> considered good.
>> > +      */
>> > +     if (bad->s_priority != DRM_SCHED_PRIORITY_KERNEL) {
>> > +             atomic_set(&bad->karma, 0);
>> > +             for (i = DRM_SCHED_PRIORITY_MIN; i < 
>> DRM_SCHED_PRIORITY_KERNEL;
>> > +                  i++) {
>> > +                     struct drm_sched_rq *rq = &sched->sched_rq[i];
>> > +
>> > + spin_lock(&rq->lock);
>> > + list_for_each_entry_safe(entity, tmp, &rq->entities, list) {
>> > +                             if (bad->s_fence->scheduled.context ==
>> > + entity->fence_context) {
>> > + if (entity->guilty)
>> > + atomic_set(entity->guilty, 0);
>> > +                                     break;
>> > +                             }
>> > +                     }
>> > + spin_unlock(&rq->lock);
>> > +                     if (&entity->list != &rq->entities)
>> > +                             break;
>> > +             }
>> > +     }
>> > +}
>> > +EXPORT_SYMBOL(drm_sched_reset_karma);
>> > +
>> >   /**
>> >    * drm_sched_stop - stop the scheduler
>> >    *
>> > diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
>> > index 1c815e0a14ed..01c609149731 100644
>> > --- a/include/drm/gpu_scheduler.h
>> > +++ b/include/drm/gpu_scheduler.h
>> > @@ -321,7 +321,9 @@ void drm_sched_wakeup(struct drm_gpu_scheduler 
>> *sched);
>> >   void drm_sched_stop(struct drm_gpu_scheduler *sched, struct 
>> drm_sched_job *bad);
>> >   void drm_sched_start(struct drm_gpu_scheduler *sched, bool 
>> full_recovery);
>> >   void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched);
>> > +void drm_sched_resubmit_jobs2(struct drm_gpu_scheduler *sched, int 
>> max);
>> >   void drm_sched_increase_karma(struct drm_sched_job *bad);
>> > +void drm_sched_reset_karma(struct drm_sched_job *bad);
>> >   bool drm_sched_dependency_optimized(struct dma_fence* fence,
>> >                                    struct drm_sched_entity *entity);
>> >   void drm_sched_fault(struct drm_gpu_scheduler *sched);
>>
>
>


--------------6D079B68AE3FDED59AEBA789
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Yeah, but wouldn't it be feasible to extend the existing function
    with parameters what to do like Andrey suggested? (It's possible
    that I just missed the response for this).<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 10.03.21 um 15:05 schrieb Zhang,
      Jack (Jian):<br>
    </div>
    <blockquote type="cite" cite="mid:DM5PR1201MB0204120DC4A44A5A32196901BB919@DM5PR1201MB0204.namprd12.prod.outlook.com">
      
      <p style="font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div dir="auto" style="direction: ltr; margin: 0; padding: 0;
          font-family: sans-serif; font-size: 11pt; color: black; ">
          <br>
        </div>
        <div dir="auto" style="direction: ltr; margin: 0; padding: 0;
          font-family: sans-serif; font-size: 11pt; color: black; ">
          As Monk previously explained in another mail session.&nbsp;Because
          the drm_sched_resubmit_jobs submit all jobs which does not
          meet our needs.
          <br>
        </div>
        <div dir="auto" style="direction: ltr; margin: 0; padding: 0;
          font-family: sans-serif; font-size: 11pt; color: black; ">
          <br>
        </div>
        <div dir="auto" style="direction: ltr; margin: 0; padding: 0;
          font-family: sans-serif; font-size: 11pt; color: black; ">
          We need a new APi&nbsp; drm_sched_resubmit_jobs2()<br>
        </div>
        <div dir="auto" style="direction: ltr; margin: 0; padding: 0;
          font-family: sans-serif; font-size: 11pt; color: black; ">
        </div>
        <div dir="auto" style="direction: ltr; margin: 0px; padding:
          0px; font-family: sans-serif; font-size: 11pt; color: black;
          text-align: left;">
          to submit the first job of a ring. (also we can leverage the
          error handling for Null or Error fence inside this
          function&nbsp;).&nbsp;</div>
        <div dir="auto" style="direction: ltr; margin: 0px; padding:
          0px; font-family: sans-serif; font-size: 11pt; color: black;
          text-align: left;">
          <br>
        </div>
        <div dir="auto" style="direction: ltr; margin: 0px; padding:
          0px; font-family: sans-serif; font-size: 11pt; color: black;
          text-align: left;">
          It seems clean to use this jobs2 function than writing the
          run_job + some error handling in the main logic.&nbsp;</div>
        <div dir="auto" style="direction: ltr; margin: 0px; padding:
          0px; font-family: sans-serif; font-size: 11pt; color: black;
          text-align: left;">
          <br>
        </div>
        <div dir="auto" style="direction: ltr; margin: 0px; padding:
          0px; font-family: sans-serif; font-size: 11pt; color: black;
          text-align: left;">
          <br>
        </div>
        <div dir="auto" style="direction: ltr; margin: 0px; padding:
          0px; font-family: sans-serif; font-size: 11pt; color: black;
          text-align: left;">
          Thanks，<br>
          /Jack </div>
        <div dir="auto" style="direction: ltr; margin: 0px; padding:
          0px; font-family: sans-serif; font-size: 11pt; color: black;
          text-align: left;">
          <br>
        </div>
        <div dir="auto" style="direction: ltr; margin: 0px; padding:
          0px; font-family: sans-serif; font-size: 11pt; color: black;
          text-align: left;">
          <br>
        </div>
        <div dir="auto" style="direction: ltr; margin: 0px; padding:
          0px; font-family: sans-serif; font-size: 11pt; color: black;
          text-align: left;">
          <br>
        </div>
        <div dir="auto" style="direction: ltr; margin: 0; padding: 0;
          font-family: sans-serif; font-size: 11pt; color: black; ">
          <br>
        </div>
        <div id="id-f87222bd-c403-491c-81fb-bdf2e154f36d" class="ms-outlook-mobile-reference-message">
          <div style="font-family: sans-serif; font-size: 12pt; color:
            rgb(0, 0, 0);"><br>
          </div>
          <hr style="display:inline-block;width:98%" tabindex="-1">
          <div id="divRplyFwdMsg"><strong>发件人:</strong> Koenig,
            Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
            <strong>发送时间:</strong> 2021年3月10日星期三 下午9:49<br>
            <strong>收件人:</strong> Zhang, Jack (Jian);
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Grodzovsky, Andrey; Liu,
            Monk; Deng, Emily<br>
            <strong>主题:</strong> Re: [PATCH v4] drm/amd/amdgpu implement
            tdr advanced mode<br>
          </div>
          <br>
          <meta content="text/html; charset=utf-8">
          Andrey needs to review the reste, but essentially I don't see
          the reason why you need this drm_sched_resubmit_jobs2().<br>
          <br>
          Christian.<br>
          <br>
          <div class="moz-cite-prefix">Am 10.03.21 um 14:36 schrieb
            Zhang, Jack (Jian):<br>
          </div>
          <blockquote type="cite">
            <p style="font-family:Arial; font-size:11pt; color:#0078D7;
              margin:5pt" align="Left">
              [AMD Official Use Only - Internal Distribution Only]<br>
            </p>
            <br>
            <div>
              <div dir="auto" style="direction:ltr; margin:0; padding:0;
                font-family:sans-serif; font-size:11pt; color:black">
                Thanks Christian， just did the checkpatch scan.&nbsp; Please
                see the V6 patch<br>
              </div>
              <div dir="auto" style="direction:ltr; margin:0; padding:0;
                font-family:sans-serif; font-size:11pt; color:black">
                <br>
              </div>
              <div dir="auto" style="direction:ltr; margin:0; padding:0;
                font-family:sans-serif; font-size:11pt; color:black">
                /Jack<br>
              </div>
              <div dir="auto" style="direction:ltr; margin:0px;
                padding:0px; font-family:sans-serif; font-size:11pt;
                color:black; text-align:left">
                <br>
              </div>
              <div dir="auto" style="direction:ltr; margin:0; padding:0;
                font-family:sans-serif; font-size:11pt; color:black">
                <br>
              </div>
              <hr tabindex="-1" style="display:inline-block; width:98%">
              <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b> Koenig, Christian
                  <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a><br>
                  <b>Sent:</b> Wednesday, March 10, 2021 8:54:53 PM<br>
                  <b>To:</b> Zhang, Jack (Jian) <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Zhang1@amd.com" moz-do-not-send="true">
                    &lt;Jack.Zhang1@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                    amd-gfx@lists.freedesktop.org</a> <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                    &lt;amd-gfx@lists.freedesktop.org&gt;</a>;
                  Grodzovsky, Andrey <a class="moz-txt-link-rfc2396E" href="mailto:Andrey.Grodzovsky@amd.com" moz-do-not-send="true">
                    &lt;Andrey.Grodzovsky@amd.com&gt;</a>; Liu, Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu@amd.com" moz-do-not-send="true">
                    &lt;Monk.Liu@amd.com&gt;</a>; Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">
                    &lt;Emily.Deng@amd.com&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH v4] drm/amd/amdgpu
                  implement tdr advanced mode</font>
                <div>&nbsp;</div>
              </div>
              <div class="BodyFragment"><font size="2"><span style="font-size:11pt">
                    <div class="PlainText">Am 10.03.21 um 12:19 schrieb
                      Jack Zhang:<br>
                      &gt; [Why]<br>
                      &gt; Previous tdr design treats the first job in
                      job_timeout as the bad job.<br>
                      &gt; But sometimes a later bad compute job can
                      block a good gfx job and<br>
                      &gt; cause an unexpected gfx job timeout because
                      gfx and compute ring share<br>
                      &gt; internal GC HW mutually.<br>
                      &gt;<br>
                      &gt; [How]<br>
                      &gt; This patch implements an advanced tdr mode.It
                      involves an additinal<br>
                      &gt; synchronous pre-resubmit step(Step0 Resubmit)
                      before normal resubmit<br>
                      &gt; step in order to find the real bad job.<br>
                      &gt;<br>
                      &gt; 1. At Step0 Resubmit stage, it synchronously
                      submits and pends for the<br>
                      &gt; first job being signaled. If it gets timeout,
                      we identify it as guilty<br>
                      &gt; and do hw reset. After that, we would do the
                      normal resubmit step to<br>
                      &gt; resubmit left jobs.<br>
                      &gt;<br>
                      &gt; 2. Re-insert Bailing job to mirror_list, and
                      leave it to be handled by<br>
                      &gt; the main reset thread.<br>
                      &gt;<br>
                      &gt; 3. For whole gpu reset(vram lost), do
                      resubmit as the old way.<br>
                      &gt;<br>
                      &gt; Signed-off-by: Jack Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Zhang1@amd.com" moz-do-not-send="true">
                        &lt;Jack.Zhang1@amd.com&gt;</a><br>
                      &gt; Change-Id:
                      I408357f10b9034caaa1b83610e19e514c5fbaaf2<br>
                      &gt; ---<br>
                      &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                      | 73 ++++++++++++++++++++-<br>
                      &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp;
                      |&nbsp; 2 +-<br>
                      &gt;&nbsp;&nbsp; drivers/gpu/drm/scheduler/sched_main.c&nbsp;&nbsp;&nbsp;&nbsp;
                      | 75 ++++++++++++++++++++++<br>
                      &gt;&nbsp;&nbsp; include/drm/gpu_scheduler.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      |&nbsp; 2 +<br>
                      &gt;&nbsp;&nbsp; 4 files changed, 148 insertions(+), 4
                      deletions(-)<br>
                      &gt;<br>
                      &gt; diff --git
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                      &gt; index e247c3a2ec08..02056355a055 100644<br>
                      &gt; ---
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                      &gt; +++
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                      &gt; @@ -4639,7 +4639,7 @@ int
                      amdgpu_device_gpu_recover(struct amdgpu_device
                      *adev,<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r = 0;<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_emergency_restart = false;<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool audio_suspended = false;<br>
                      &gt; -<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; tmp_vram_lost_counter;<br>
                      <br>
                      Please keep the empoty line between declaration
                      and code.<br>
                      <br>
                      In general give that patch a pass with
                      checkpath.pl since there are a <br>
                      couple of other place which needs fixing at first
                      glance.<br>
                      <br>
                      Christian.<br>
                      <br>
                      <br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Special case: RAS triggered and
                      full reset isn't supported<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
                      &gt; @@ -4689,9 +4689,14 @@ int
                      amdgpu_device_gpu_recover(struct amdgpu_device
                      *adev,<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev,
                      &quot;Bailing on TDR for s_job:%llx, as another already
                      in progress&quot;,<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job ?
                      job-&gt;base.id : -1);<br>
                      &gt;&nbsp;&nbsp; <br>
                      &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* even we skipped this reset,
                      still need to set the job to guilty */<br>
                      &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job)<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job) {<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* re-insert node to
                      avoid memory leak */<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      spin_lock(&amp;job-&gt;base.sched-&gt;job_list_lock);<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      list_add(&amp;job-&gt;base.node,
                      &amp;job-&gt;base.sched-&gt;pending_list);<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      spin_unlock(&amp;job-&gt;base.sched-&gt;job_list_lock);<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* even we skipped this
                      reset, still need to set the job to guilty */<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      drm_sched_increase_karma(&amp;job-&gt;base);<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto skip_recovery;<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                      &gt;&nbsp;&nbsp; <br>
                      &gt; @@ -4788,6 +4793,7 @@ int
                      amdgpu_device_gpu_recover(struct amdgpu_device
                      *adev,<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                      &gt;&nbsp;&nbsp; <br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp; tmp_vram_lost_counter =
                      atomic_read(&amp;((adev)-&gt;vram_lost_counter));<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Actual ASIC resets if needed.*/<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO Implement XGMI hive reset
                      logic for SRIOV */<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
                      &gt; @@ -4805,6 +4811,67 @@ int
                      amdgpu_device_gpu_recover(struct amdgpu_device
                      *adev,<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Post ASIC reset for all devs .*/<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev,
                      device_list_handle, gmc.xgmi.head) {<br>
                      &gt;&nbsp;&nbsp; <br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_gpu_recovery == 2
                      &amp;&amp;<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(tmp_vram_lost_counter
                      &lt;
                      atomic_read(&amp;adev-&gt;vram_lost_counter))) {<br>
                      &gt; +<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                      AMDGPU_MAX_RINGS; ++i) {<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
                      amdgpu_ring *ring = tmp_adev-&gt;rings[i];<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret = 0;<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
                      drm_sched_job *s_job;<br>
                      &gt; +<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring ||
                      !ring-&gt;sched.thread)<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      continue;<br>
                      &gt; +<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* No point to
                      resubmit jobs if we didn't HW reset*/<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                      (!tmp_adev-&gt;asic_reset_res &amp;&amp;
                      !job_signaled) {<br>
                      &gt; +<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_job =
list_first_entry_or_null(&amp;ring-&gt;sched.pending_list, struct
                      drm_sched_job, list);<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                      (s_job == NULL)<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      continue;<br>
                      &gt; +<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
                      clear job's guilty and depend the folowing step to
                      decide the real one */<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      drm_sched_reset_karma(s_job);<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      drm_sched_resubmit_jobs2(&amp;ring-&gt;sched, 1);<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
                      dma_fence_wait_timeout(s_job-&gt;s_fence-&gt;parent,
                      false, ring-&gt;sched.timeout);<br>
                      &gt; +<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret
                      == 0) { /* timeout */<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      DRM_ERROR(&quot;Found the real bad job! ring:%s,
                      job_id:%llx\n&quot;, ring-&gt;sched.name,
                      s_job-&gt;id);<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      /* set guilty */<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      drm_sched_increase_karma(s_job);<br>
                      &gt; +<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      /* do hw reset */<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      if (amdgpu_sriov_vf(adev)) {<br>
                      &gt;
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      amdgpu_virt_fini_data_exchange(adev);<br>
                      &gt;
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      r = amdgpu_device_reset_sriov(adev, false);<br>
                      &gt;
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      if (r)<br>
                      &gt;
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      adev-&gt;asic_reset_res = r;<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      } else {<br>
                      &gt;
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      r&nbsp; = amdgpu_do_asic_reset(hive,
                      device_list_handle, &amp;need_full_reset, false);<br>
                      &gt;
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      if (r &amp;&amp; r == -EAGAIN)<br>
                      &gt;
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      goto retry;<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      }<br>
                      &gt; +<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      /* add reset counter so that the following
                      resubmitted job could flush vmid */<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      atomic_inc(&amp;tmp_adev-&gt;gpu_reset_counter);<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      continue;<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                      &gt; +<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* got
                      the hw fence, signal finished fence */<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      atomic_dec(&amp;ring-&gt;sched.num_jobs);<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      dma_fence_get(&amp;s_job-&gt;s_fence-&gt;finished);<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      dma_fence_signal(&amp;s_job-&gt;s_fence-&gt;finished);<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      dma_fence_put(&amp;s_job-&gt;s_fence-&gt;finished);<br>
                      &gt; +<br>
                      &gt; +<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
                      remove node from list and free the job */<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      spin_lock(&amp;ring-&gt;sched.job_list_lock);<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      list_del_init(&amp;s_job-&gt;node);<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      spin_unlock(&amp;ring-&gt;sched.job_list_lock);<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      ring-&gt;sched.ops-&gt;free_job(s_job);<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                      &gt; +<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                      AMDGPU_MAX_RINGS; ++i) {<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring
                      *ring = tmp_adev-&gt;rings[i];<br>
                      &gt;&nbsp;&nbsp; <br>
                      &gt; diff --git
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
                      &gt; index 865f924772b0..9c3f4edb7532 100644<br>
                      &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
                      &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
                      &gt; @@ -509,7 +509,7 @@
                      module_param_named(compute_multipipe,
                      amdgpu_compute_multipipe, int, 0444);<br>
                      &gt;&nbsp;&nbsp;&nbsp; * DOC: gpu_recovery (int)<br>
                      &gt;&nbsp;&nbsp;&nbsp; * Set to enable GPU recovery mechanism (1
                      = enable, 0 = disable). The default is -1 (auto,
                      disabled except SRIOV).<br>
                      &gt;&nbsp;&nbsp;&nbsp; */<br>
                      &gt; -MODULE_PARM_DESC(gpu_recovery, &quot;Enable GPU
                      recovery mechanism, (1 = enable, 0 = disable, -1 =
                      auto)&quot;);<br>
                      &gt; +MODULE_PARM_DESC(gpu_recovery, &quot;Enable GPU
                      recovery mechanism, (2 = advanced tdr mode, 1 =
                      enable, 0 = disable, -1 = auto)&quot;);<br>
                      &gt;&nbsp;&nbsp; module_param_named(gpu_recovery,
                      amdgpu_gpu_recovery, int, 0444);<br>
                      &gt;&nbsp;&nbsp; <br>
                      &gt;&nbsp;&nbsp; /**<br>
                      &gt; diff --git
                      a/drivers/gpu/drm/scheduler/sched_main.c
                      b/drivers/gpu/drm/scheduler/sched_main.c<br>
                      &gt; index d82a7ebf6099..99a6a8bddd6f 100644<br>
                      &gt; --- a/drivers/gpu/drm/scheduler/sched_main.c<br>
                      &gt; +++ b/drivers/gpu/drm/scheduler/sched_main.c<br>
                      &gt; @@ -395,6 +395,81 @@ void
                      drm_sched_increase_karma(struct drm_sched_job
                      *bad)<br>
                      &gt;&nbsp;&nbsp; }<br>
                      &gt;&nbsp;&nbsp; EXPORT_SYMBOL(drm_sched_increase_karma);<br>
                      &gt;&nbsp;&nbsp; <br>
                      &gt; +<br>
                      &gt; +void drm_sched_resubmit_jobs2(struct
                      drm_gpu_scheduler *sched, int max)<br>
                      &gt; +{<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *s_job, *tmp;<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t guilty_context;<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool found_guilty = false;<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *fence;<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp; int i = 0;<br>
                      &gt; +<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(s_job, tmp,
                      &amp;sched-&gt;pending_list, list) {<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_fence *s_fence
                      = s_job-&gt;s_fence;<br>
                      &gt; +<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i&gt;=max)<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                      &gt; +<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!found_guilty &amp;&amp;
                      atomic_read(&amp;s_job-&gt;karma) &gt;
                      sched-&gt;hang_limit) {<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; found_guilty = true;<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; guilty_context =
                      s_job-&gt;s_fence-&gt;scheduled.context;<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                      &gt; +<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (found_guilty &amp;&amp;
                      s_job-&gt;s_fence-&gt;scheduled.context ==
                      guilty_context)<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      dma_fence_set_error(&amp;s_fence-&gt;finished,
                      -ECANCELED);<br>
                      &gt; +<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      dma_fence_put(s_job-&gt;s_fence-&gt;parent);<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fence =
                      sched-&gt;ops-&gt;run_job(s_job);<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i++;<br>
                      &gt; +<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR_OR_NULL(fence)) {<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(fence))<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      dma_fence_set_error(&amp;s_fence-&gt;finished,
                      PTR_ERR(fence));<br>
                      &gt; +<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      s_job-&gt;s_fence-&gt;parent = NULL;<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      s_job-&gt;s_fence-&gt;parent = fence;<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                      &gt; +}<br>
                      &gt; +EXPORT_SYMBOL(drm_sched_resubmit_jobs2);<br>
                      &gt; +<br>
                      &gt; +<br>
                      &gt; +<br>
                      &gt; +void drm_sched_reset_karma(struct
                      drm_sched_job *bad)<br>
                      &gt; +{<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity *tmp;<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity *entity;<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gpu_scheduler *sched =
                      bad-&gt;sched;<br>
                      &gt; +<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* don't reset @bad's karma if it's
                      from KERNEL RQ,<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * because sometimes GPU hang would
                      cause kernel jobs (like VM updating jobs)<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * corrupt but keep in mind that kernel
                      jobs always considered good.<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (bad-&gt;s_priority !=
                      DRM_SCHED_PRIORITY_KERNEL) {<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;bad-&gt;karma,
                      0);<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =
                      DRM_SCHED_PRIORITY_MIN; i &lt;
                      DRM_SCHED_PRIORITY_KERNEL;<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i++) {<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_rq *rq
                      = &amp;sched-&gt;sched_rq[i];<br>
                      &gt; +<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      spin_lock(&amp;rq-&gt;lock);<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      list_for_each_entry_safe(entity, tmp,
                      &amp;rq-&gt;entities, list) {<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                      (bad-&gt;s_fence-&gt;scheduled.context ==<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      entity-&gt;fence_context) {<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      if (entity-&gt;guilty)<br>
                      &gt;
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      atomic_set(entity-&gt;guilty, 0);<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      spin_unlock(&amp;rq-&gt;lock);<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                      (&amp;entity-&gt;list != &amp;rq-&gt;entities)<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                      &gt; +}<br>
                      &gt; +EXPORT_SYMBOL(drm_sched_reset_karma);<br>
                      &gt; +<br>
                      &gt;&nbsp;&nbsp; /**<br>
                      &gt;&nbsp;&nbsp;&nbsp; * drm_sched_stop - stop the scheduler<br>
                      &gt;&nbsp;&nbsp;&nbsp; *<br>
                      &gt; diff --git a/include/drm/gpu_scheduler.h
                      b/include/drm/gpu_scheduler.h<br>
                      &gt; index 1c815e0a14ed..01c609149731 100644<br>
                      &gt; --- a/include/drm/gpu_scheduler.h<br>
                      &gt; +++ b/include/drm/gpu_scheduler.h<br>
                      &gt; @@ -321,7 +321,9 @@ void
                      drm_sched_wakeup(struct drm_gpu_scheduler *sched);<br>
                      &gt;&nbsp;&nbsp; void drm_sched_stop(struct
                      drm_gpu_scheduler *sched, struct drm_sched_job
                      *bad);<br>
                      &gt;&nbsp;&nbsp; void drm_sched_start(struct
                      drm_gpu_scheduler *sched, bool full_recovery);<br>
                      &gt;&nbsp;&nbsp; void drm_sched_resubmit_jobs(struct
                      drm_gpu_scheduler *sched);<br>
                      &gt; +void drm_sched_resubmit_jobs2(struct
                      drm_gpu_scheduler *sched, int max);<br>
                      &gt;&nbsp;&nbsp; void drm_sched_increase_karma(struct
                      drm_sched_job *bad);<br>
                      &gt; +void drm_sched_reset_karma(struct
                      drm_sched_job *bad);<br>
                      &gt;&nbsp;&nbsp; bool drm_sched_dependency_optimized(struct
                      dma_fence* fence,<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
                      drm_sched_entity *entity);<br>
                      &gt;&nbsp;&nbsp; void drm_sched_fault(struct
                      drm_gpu_scheduler *sched);<br>
                      <br>
                    </div>
                  </span></font></div>
            </div>
          </blockquote>
          <br>
          <br>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------6D079B68AE3FDED59AEBA789--

--===============0255904589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0255904589==--
