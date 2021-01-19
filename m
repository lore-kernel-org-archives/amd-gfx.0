Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07FAC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 19:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36F3C216FD
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 19:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F3C216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4697C6E415;
	Tue, 19 Jan 2021 16:58:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADE506E415
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 16:58:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bm2aBHRcDlsechOvrc1BrL0kVU3sGhxLyqyWp2DByMfRGoaUf7+IWOrXiOocIpqzmwUS30VSO6srbAaJdm2DFMXSiSxT1Y8zII3bi+nHI2M4e755tkvbiFN2pOwdWLqztgMni+yDjvuuoMDTxoEIFUU4iE7Zso1eYSgT0RI9KVSzxEgBjjAYeKanJVPJ1O4bADeeQXN/b84/rBJSPRpes6XOF7K3AK2yQNiU8DKfZv6hNydAZlAzk5eNptxXjcZBfjboi/HPsMw/HhS9mBipHIT3r/4FC1IejS5l6HtA7x4NHNy+KYTlWI+ImbFgyINnPzfdwRo1scXR13gC6gvQSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLZsAMDTyz1YZKShnlYVjSePE3JXJ6CcEUcictFuf00=;
 b=nCJfJVHQ/RopCXC0T8VsIktRF4q5lWvx/KPS0Z8PO3zr1OrsE2xb9tNjzMprFhRoQQPnY63GUAu8jd8opQ0vgnorFARvkxlF9KpV6n7pXe8S02qCVpTCWZqKokjbRccs0nKk17NjFYJJ93bB9N+FpBCrpWiQb/flLH70mKruAokAN3PSGvoXUUtQRfsq6Q8rI87UqW4IOYoFnkyqprE+U5BhHh3lZNkVkEVSCyF9e35kFapUusHKVOu+DMhMYjfEy9quoGaFVDVnWxu8xIpfq67WXTOyfyDUbzOU6j2dKkgXFKJFDn9kf5g9l2yGBLoH7R5HU2OrbbYEp/1pZoaptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLZsAMDTyz1YZKShnlYVjSePE3JXJ6CcEUcictFuf00=;
 b=NOLYrT9hQqZ6CR/ySmckoYO6veYaZzeEmzKLsGFb6iioAA1sIVsSTwLntcXxq+NftrhafaxdoS2TONP3wSyl+31PAFYk13TE5+C7JPNz+I3KJcwuHExhuOrjAxGKEFS12sYd7GLatBshGSyUlSLSDHLm5BTuITJweQFR5exJfVo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4591.namprd12.prod.outlook.com (2603:10b6:806:9d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Tue, 19 Jan
 2021 16:58:32 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::5d30:b29d:5f5b:6921]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::5d30:b29d:5f5b:6921%5]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 16:58:31 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIDEvMl0gZHJtL2FtZGdwdTogcmFjZSBp?=
 =?UTF-8?Q?ssue_when_jobs_on_2_ring_timeout?=
To: "Chen, Horace" <Horace.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210119122236.8039-1-horace.chen@amd.com>
 <3365c92c-9dbd-56df-4ba0-55793806cac7@amd.com>
 <CY4PR12MB157352A2F7BF029B68A4A769E1A30@CY4PR12MB1573.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <bb133853-4291-1c6e-36ee-1eb05854c56a@amd.com>
Date: Tue, 19 Jan 2021 11:58:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CY4PR12MB157352A2F7BF029B68A4A769E1A30@CY4PR12MB1573.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:c1b5:6dec:d289:5430]
X-ClientProxiedBy: YT1PR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::10) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:c1b5:6dec:d289:5430]
 (2607:fea8:3edf:49b0:c1b5:6dec:d289:5430) by
 YT1PR01CA0131.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.10 via Frontend Transport; Tue, 19 Jan 2021 16:58:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6458b417-db1c-4e90-3c48-08d8bc9b731c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4591:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB459118C05CE2559422B7FAB3EAA39@SA0PR12MB4591.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J6swOQqbd65PWzFEbk1iJQgNqIg2+v+JDLgAmwrl097GoYtxaIfWnDMrNz23EXwaLvteD7+xdvbCvf3rJfBnLg2lbj4fS7W16T3HRRYHGlOjOsNemT5a1omhmwCt3/awbqTvnSpXMssSek4vYRuclNlDK1wQoo/x+/95GlJqMBBjunHSAP+r2ZHdOL2hk/kWBxAPJmO1KDtPVetpFQqaFOv+viZFbvv3Yga1vqj0DjxxDHZufcyRLkxraPwuJ8sg8bRqJW0FwvX5wsPkaQu/9jmm5FHmi5xMDJqdbGlY7ajntcQhSIGNs63feRvCXo3o+LFsg7ZEWU3SWkZv/vw5gGLmlh7/wRwQ0RDx0M7RrlWJXHRNgZZCCB3ZFhVSnL1f/4VuxbL8S6Ke0n3B3lIR4unSev9EjxBDZMnHVEWDZ4OBIFaa9f/mZRAslI+gqxHYNKqCGCcIMOOh2MJYWCC7tddSOjk+EEGdZOZORwiq4Pg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(83380400001)(53546011)(2906002)(6486002)(52116002)(110136005)(86362001)(33964004)(5660300002)(54906003)(2616005)(66556008)(224303003)(478600001)(31686004)(66476007)(66946007)(19627405001)(16526019)(36756003)(316002)(30864003)(186003)(8936002)(31696002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Smk1VTBENU5BM3MrSHVsRTBMZlFCNUppSGMyRG44bGZGZjl6V0xTM0F1dm9N?=
 =?utf-8?B?MmVCWEhMeVZTU1ovWGVlekZWMXR5VFJRMUhzcEFBaUd0ck8vbzhWUythU3di?=
 =?utf-8?B?SXA1Y2FhcUdoQVdaNGQ4UWhleEcvdjJJV2IwY2dLekl2RjlyYWdPUFJweGNW?=
 =?utf-8?B?WWtmc3M0QnpVRjBmRjQrUHpLYUxqYS9aend5WHZKUmpTWnBIZm45Q2RvZHE5?=
 =?utf-8?B?Uk5Jd3Jjem9Qd3FiL3MvY3VtMzJCemFhR1lUNG5zWnMyYzNyL0NZQUxvL21j?=
 =?utf-8?B?Vk1RL0laUzZCVjBidVpVOVlaM2F5NTZIMm9JaEhwbTFvcnE2OTY2R002OXcy?=
 =?utf-8?B?VW9yTE5kbHh4d1RremFacC85aE9UTjJQY1RoWmsvcGM2b2hWdTNDYUNjT0Jj?=
 =?utf-8?B?eGJ6MThDeWRPc2dGS1VsRzI4STFMbUp5N0I4aU5tbm90MGlMZnE1TkRnMVov?=
 =?utf-8?B?aE90akJMbTVNdDhhWFR5a0hIdWwzbTJoWG9ZZ1BISlhveFN0SjZLSDZrdHdO?=
 =?utf-8?B?Z3JuSkR4REkwdkJMWTRraEc1R1ZkcVYxN0UxU1FGRWZjMVJrMnNnaUNGNCtk?=
 =?utf-8?B?VGNCNDBoMUV4TkpUMHN2Q0J5R1hPdEpVNFFaZEluMm9CYTdXT1ZVTUpZd3pB?=
 =?utf-8?B?TmJqYlRRcGI3bjJwM3c4a3lJQU1nVHBONWJ2ckFIVkoxc0RzbDl6Qm1VOFh4?=
 =?utf-8?B?Z25xcnZBT1BadXVSa0hIZEVhL3VkeUtzUnBrRzZXSHQ0SnhjaEo4L2gxMnla?=
 =?utf-8?B?eGl0aldJNFhUejljVzhDb0V1WWhJOW45bVFmUGJlYTV1a1hPZU5PL1YrTURs?=
 =?utf-8?B?WlJJdlptN1Ezdlovb1hkYUtZdzhkNXEvSGE1Q0MrV3hPQ0Ruckt5UzN1bVNX?=
 =?utf-8?B?enJYUEp2Y3Q2RGRPcnJTcEtNeXlmU29XbGpRT0VueUlaRHk4ZENOc2xZSExR?=
 =?utf-8?B?cGp4Q1FuY0dBL01HWjdpWmc0UGRXTFlTSlIrN3UrYTkrc29mU2ltVTBEL2t0?=
 =?utf-8?B?TW42T2NWWW80RmxmdFJFK2VETjJaU3pybFdxbGc1dEczcWlqSVNlY3VmSEM5?=
 =?utf-8?B?Vng4b2c3L1dSYm1GR2RYZ0lhTHEyZ3FHVVNwRmVHdHJRODlrNk9MMXlnRkxM?=
 =?utf-8?B?ODFyc3F5VDNiODI4SDNPTys2eWVDS2JscHgrTHB3aGRMOUwrNW12TmhGVFFj?=
 =?utf-8?B?ZlJ6elVQSC91bGkwNzVqdnZhNGFEbWlYMVZsY0NpTnIxQkJWNW5adG1pd1NE?=
 =?utf-8?B?OU1XVXV1RkI4Tmh5TG5NNXlBYStMQWlLZXdzVDlMN2pFMVpqL1gyWGNnL2RS?=
 =?utf-8?B?T2hyYnFaNXlVNUtjdUtUOHgxQWpDWmRLMDgwaDBRN0psb0ErTHA2ckhJbTcw?=
 =?utf-8?B?RERSVjlCUEE2T0pzZlJ5UUVCRFJyNE5IQjhLQ2YwZEU5MkMzRGJjWkZwRVVM?=
 =?utf-8?B?YmZYeEt4Z0ZnQmVBVWtwMTRVRHBPS1Frd3IxTk9aN1BYeXd0VWpTV0NxcHR1?=
 =?utf-8?B?bDYvQXZtYW1BTE5ROWdwMDlsZzdVL0E1YVlFOUlVOFdCUXZUTXBXQlB1TUF6?=
 =?utf-8?B?cjNJUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6458b417-db1c-4e90-3c48-08d8bc9b731c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 16:58:31.2796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLOchJ75iuiofQe4GaK6eT4LPgb7iwft3J/VcbzxlqZkfdaFgfMr9dtx98krtv8TR3NfVR+v7EgZmXRsTvaASg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4591
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0862074615=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0862074615==
Content-Type: multipart/alternative;
 boundary="------------CC066039E2C3685DDB39E4CA"
Content-Language: en-US

--------------CC066039E2C3685DDB39E4CA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/19/21 11:39 AM, Chen, Horace wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> Hi Andrey,
>
> I think the list in the XGMI hive won't be break in the middle if we lock the 
> device before we change the list. Because if 2 devices in 1 hive went into the 
> function, it will follow the same sequence to lock the devices. So one of them 
> will definately break at the first device. I add iterate devices here is just 
> to lock all device in the hive since we will change the device sequence in the 
> hive soon after.


I didn't mean break in a sense of breaking the list itself, I just meant the 
literal 'break' instruction
to terminate the iteration once you failed to lock a particular device.


>
> The reason to break the interation in the middle is that the list is changed 
> during the iteration without taking any lock. It is quite bad since I'm fixing 
> one of this issue. And for XGMI hive, there are 2 locks protecting the list, 
> one is the device lock I changed here, the other one is in front of my change, 
> there is a hive->lock to protect the hive.
>
> Even the bad thing really happened, I think moving back through the list is 
> also very dengerous since we don't know what the list finally be, Unless we 
> stack the devices we have iterated through a mirrored list. That can be a big 
> change.


Not sure we are on the same page, my concern is let's sat your XGMI hive 
consists of 2 devices, you manged to call successfully do
amdgpu_device_lock_adev for dev1 but then failed for dev2, in this case you will 
bail out without releasing dev1, no ?


Andrey


>
>
> I'm ok to seperate the locking in amdgpu_device_lock_adev here, I'll do some 
> test and update the code later.
>
> Thanks & Regards,
> Horace.
> --------------------------------------------------------------------------------
> *发件人:* Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> *发送时间:* 2021年1月19日 22:33
> *收件人:* Chen, Horace <Horace.Chen@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *抄送:* Quan, Evan <Evan.Quan@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; 
> Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking 
> <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei 
> <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Xiaojie Yuan 
> <xiaojie.yuan@amd.com>
> *主题:* Re: [PATCH 1/2] drm/amdgpu: race issue when jobs on 2 ring timeout
>
> On 1/19/21 7:22 AM, Horace Chen wrote:
> > Fix a racing issue when jobs on 2 rings timeout simultaneously.
> >
> > If 2 rings timed out at the same time, the amdgpu_device_gpu_recover
> > will be reentered. Then the adev->gmc.xgmi.head will be grabbed
> > by 2 local linked list, which may cause wild pointer issue in
> > iterating.
> >
> > lock the device earily to prevent the node be added to 2 different
> > lists.
> >
> > Signed-off-by: Horace Chen <horace.chen@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 42 +++++++++++++++-------
> >   1 file changed, 30 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 4d434803fb49..9574da3abc32 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -4540,6 +4540,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
> >        int i, r = 0;
> >        bool need_emergency_restart = false;
> >        bool audio_suspended = false;
> > +     bool get_dev_lock = false;
> >
> >        /*
> >         * Special case: RAS triggered and full reset isn't supported
> > @@ -4582,28 +4583,45 @@ int amdgpu_device_gpu_recover(struct amdgpu_device 
> *adev,
> >         * Build list of devices to reset.
> >         * In case we are in XGMI hive mode, resort the device list
> >         * to put adev in the 1st position.
> > +      *
> > +      * lock the device before we try to operate the linked list
> > +      * if didn't get the device lock, don't touch the linked list since
> > +      * others may iterating it.
> >         */
> >        INIT_LIST_HEAD(&device_list);
> >        if (adev->gmc.xgmi.num_physical_nodes > 1) {
> >                if (!hive)
> >                        return -ENODEV;
> > -             if (!list_is_first(&adev->gmc.xgmi.head, &hive->device_list))
> > - list_rotate_to_front(&adev->gmc.xgmi.head, &hive->device_list);
> > -             device_list_handle = &hive->device_list;
> > +
> > +             list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
> > +                     get_dev_lock = amdgpu_device_lock_adev(tmp_adev, hive);
> > +                     if (!get_dev_lock)
> > +                             break;
>
>
> What about unlocking back all the devices you already locked if the break
> happens in the middle of the iteration ?
> Note that at skip_recovery: we don't do it. BTW, i see this issue is already in
> the current code.
>
> Also, maybe now it's better to separate the actual locking in
> amdgpu_device_lock_adev
> from the other stuff going on there since I don't think you would wont to toggle
> stuff
> like adev->mp1_state back and forth and also the function name is not
> descriptive of
> the other stuff going on there anyway.
>
> Andrey
>
>
> > +             }
> > +             if (get_dev_lock) {
> > +                     if (!list_is_first(&adev->gmc.xgmi.head, 
> &hive->device_list))
> > + list_rotate_to_front(&adev->gmc.xgmi.head, &hive->device_list);
> > +                     device_list_handle = &hive->device_list;
> > +             }
> >        } else {
> > - list_add_tail(&adev->gmc.xgmi.head, &device_list);
> > -             device_list_handle = &device_list;
> > +             get_dev_lock = amdgpu_device_lock_adev(adev, hive);
> > +             tmp_adev = adev;
> > +             if (get_dev_lock) {
> > + list_add_tail(&adev->gmc.xgmi.head, &device_list);
> > +                     device_list_handle = &device_list;
> > +             }
> > +     }
> > +
> > +     if (!get_dev_lock) {
> > +             dev_info(tmp_adev->dev, "Bailing on TDR for s_job:%llx, as 
> another already in progress",
> > +                                     job ? job->base.id : -1);
> > +             r = 0;
> > +             /* even we skipped this reset, still need to set the job to 
> guilty */
> > +             goto skip_recovery;
> >        }
> >
> >        /* block all schedulers and reset given job's ring */
> >        list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
> > -             if (!amdgpu_device_lock_adev(tmp_adev, hive)) {
> > -                     dev_info(tmp_adev->dev, "Bailing on TDR for 
> s_job:%llx, as another already in progress",
> > -                               job ? job->base.id : -1);
> > -                     r = 0;
> > -                     goto skip_recovery;
> > -             }
> > -
> >                /*
> >                 * Try to put the audio codec into suspend state
> >                 * before gpu reset started.

--------------CC066039E2C3685DDB39E4CA
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/19/21 11:39 AM, Chen, Horace
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CY4PR12MB157352A2F7BF029B68A4A769E1A30@CY4PR12MB1573.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <p style="font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Hi Andrey,</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          I think the list in the XGMI hive won't be break in the middle
          if we lock the device before we change the list. Because if 2
          devices in 1 hive went into the function, it will follow the
          same sequence to lock the devices. So one of them will
          definately break at the first device. I add iterate devices
          here is just to lock all device in the hive since we will
          change the device sequence in the hive soon after.</div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>I didn't mean break in a sense of breaking the list itself, I
      just meant the literal 'break' instruction<br>
      to terminate the iteration once you failed to lock a particular
      device. <br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:CY4PR12MB157352A2F7BF029B68A4A769E1A30@CY4PR12MB1573.namprd12.prod.outlook.com">
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          The reason to break the interation in the middle is that the
          list is changed during the iteration without taking any lock.
          It is quite bad since I'm fixing one of this issue. And for
          XGMI hive, there are 2 locks protecting the list, one is the
          device lock I changed here, the other one is in front of my
          change, there is a hive-&gt;lock to protect the hive.</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Even the bad thing really happened, I think moving back
          through the list is also very dengerous since we don't know
          what the list finally be, Unless we stack the devices we have
          iterated through a mirrored list. That can be a big change.<br>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Not sure we are on the same page, my concern is let's sat your
      XGMI hive consists of 2 devices, you manged to call successfully
      do<font size="2"><span style="font-size:11pt"><br>
          amdgpu_device_lock_adev for dev1 but then failed for dev2, in
          this case you will bail out&nbsp;</span></font> without releasing
      dev1, no ?</p>
    <p><br>
    </p>
    <p>Andrey<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:CY4PR12MB157352A2F7BF029B68A4A769E1A30@CY4PR12MB1573.namprd12.prod.outlook.com">
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          I'm ok to seperate the locking in <font size="2"><span style="font-size:11pt">amdgpu_device_lock_adev here, I'll
              do some test and update the code later.<br>
            </span></font></div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <font size="2"><span style="font-size:11pt"><br>
            </span></font></div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <font size="2"><span style="font-size:11pt">Thanks &amp;
              Regards,</span></font></div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <font size="2"><span style="font-size:11pt">Horace.</span></font><br>
        </div>
        <div>
          <hr tabindex="-1" style="display:inline-block; width:98%">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>发件人:</b>
              Grodzovsky, Andrey <a class="moz-txt-link-rfc2396E" href="mailto:Andrey.Grodzovsky@amd.com">&lt;Andrey.Grodzovsky@amd.com&gt;</a><br>
              <b>发送时间:</b> 2021年1月19日 22:33<br>
              <b>收件人:</b> Chen, Horace <a class="moz-txt-link-rfc2396E" href="mailto:Horace.Chen@amd.com">&lt;Horace.Chen@amd.com&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
              <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
              <b>抄送:</b> Quan, Evan <a class="moz-txt-link-rfc2396E" href="mailto:Evan.Quan@amd.com">&lt;Evan.Quan@amd.com&gt;</a>; Tuikov,
              Luben <a class="moz-txt-link-rfc2396E" href="mailto:Luben.Tuikov@amd.com">&lt;Luben.Tuikov@amd.com&gt;</a>; Koenig, Christian
              <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Deucher, Alexander
              <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Xiao, Jack
              <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Xiao@amd.com">&lt;Jack.Xiao@amd.com&gt;</a>; Zhang, Hawking
              <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a>; Liu, Monk
              <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu@amd.com">&lt;Monk.Liu@amd.com&gt;</a>; Xu, Feifei
              <a class="moz-txt-link-rfc2396E" href="mailto:Feifei.Xu@amd.com">&lt;Feifei.Xu@amd.com&gt;</a>; Wang, Kevin(Yang)
              <a class="moz-txt-link-rfc2396E" href="mailto:Kevin1.Wang@amd.com">&lt;Kevin1.Wang@amd.com&gt;</a>; Xiaojie Yuan
              <a class="moz-txt-link-rfc2396E" href="mailto:xiaojie.yuan@amd.com">&lt;xiaojie.yuan@amd.com&gt;</a><br>
              <b>主题:</b> Re: [PATCH 1/2] drm/amdgpu: race issue when
              jobs on 2 ring timeout</font>
            <div>&nbsp;</div>
          </div>
          <div class="BodyFragment"><font size="2"><span style="font-size:11pt">
                <div class="PlainText"><br>
                  On 1/19/21 7:22 AM, Horace Chen wrote:<br>
                  &gt; Fix a racing issue when jobs on 2 rings timeout
                  simultaneously.<br>
                  &gt;<br>
                  &gt; If 2 rings timed out at the same time, the
                  amdgpu_device_gpu_recover<br>
                  &gt; will be reentered. Then the
                  adev-&gt;gmc.xgmi.head will be grabbed<br>
                  &gt; by 2 local linked list, which may cause wild
                  pointer issue in<br>
                  &gt; iterating.<br>
                  &gt;<br>
                  &gt; lock the device earily to prevent the node be
                  added to 2 different<br>
                  &gt; lists.<br>
                  &gt;<br>
                  &gt; Signed-off-by: Horace Chen
                  <a class="moz-txt-link-rfc2396E" href="mailto:horace.chen@amd.com">&lt;horace.chen@amd.com&gt;</a><br>
                  &gt; ---<br>
                  &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 42
                  +++++++++++++++-------<br>
                  &gt;&nbsp;&nbsp; 1 file changed, 30 insertions(+), 12
                  deletions(-)<br>
                  &gt;<br>
                  &gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                  &gt; index 4d434803fb49..9574da3abc32 100644<br>
                  &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                  &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                  &gt; @@ -4540,6 +4540,7 @@ int
                  amdgpu_device_gpu_recover(struct amdgpu_device *adev,<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r = 0;<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_emergency_restart = false;<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool audio_suspended = false;<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool get_dev_lock = false;<br>
                  &gt;&nbsp;&nbsp; <br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Special case: RAS triggered and full
                  reset isn't supported<br>
                  &gt; @@ -4582,28 +4583,45 @@ int
                  amdgpu_device_gpu_recover(struct amdgpu_device *adev,<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Build list of devices to reset.<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * In case we are in XGMI hive mode,
                  resort the device list<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to put adev in the 1st position.<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * lock the device before we try to operate
                  the linked list<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * if didn't get the device lock, don't
                  touch the linked list since<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * others may iterating it.<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;device_list);<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.num_physical_nodes
                  &gt; 1) {<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hive)<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;<br>
                  &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                  (!list_is_first(&amp;adev-&gt;gmc.xgmi.head,
                  &amp;hive-&gt;device_list))<br>
                  &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  list_rotate_to_front(&amp;adev-&gt;gmc.xgmi.head,
                  &amp;hive-&gt;device_list);<br>
                  &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_list_handle =
                  &amp;hive-&gt;device_list;<br>
                  &gt; +<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev,
                  &amp;hive-&gt;device_list, gmc.xgmi.head) {<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_dev_lock =
                  amdgpu_device_lock_adev(tmp_adev, hive);<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!get_dev_lock)<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                  <br>
                  <br>
                  What about unlocking back all the devices you already
                  locked if the break<br>
                  happens in the middle of the iteration ?<br>
                  Note that at skip_recovery: we don't do it. BTW, i see
                  this issue is already in <br>
                  the current code.<br>
                  <br>
                  Also, maybe now it's better to separate the actual
                  locking in <br>
                  amdgpu_device_lock_adev<br>
                  from the other stuff going on there since I don't
                  think you would wont to toggle <br>
                  stuff<br>
                  like adev-&gt;mp1_state back and forth and also the
                  function name is not <br>
                  descriptive of<br>
                  the other stuff going on there anyway.<br>
                  <br>
                  Andrey<br>
                  <br>
                  <br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (get_dev_lock) {<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                  (!list_is_first(&amp;adev-&gt;gmc.xgmi.head,
                  &amp;hive-&gt;device_list))<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  list_rotate_to_front(&amp;adev-&gt;gmc.xgmi.head,
                  &amp;hive-&gt;device_list);<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_list_handle =
                  &amp;hive-&gt;device_list;<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
                  &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  list_add_tail(&amp;adev-&gt;gmc.xgmi.head,
                  &amp;device_list);<br>
                  &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_list_handle =
                  &amp;device_list;<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_dev_lock =
                  amdgpu_device_lock_adev(adev, hive);<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev = adev;<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (get_dev_lock) {<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  list_add_tail(&amp;adev-&gt;gmc.xgmi.head,
                  &amp;device_list);<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_list_handle =
                  &amp;device_list;<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                  &gt; +<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!get_dev_lock) {<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(tmp_adev-&gt;dev, &quot;Bailing
                  on TDR for s_job:%llx, as another already in
                  progress&quot;,<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job ?
                  job-&gt;base.id : -1);<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = 0;<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* even we skipped this reset,
                  still need to set the job to guilty */<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto skip_recovery;<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                  &gt;&nbsp;&nbsp; <br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* block all schedulers and reset given
                  job's ring */<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev,
                  device_list_handle, gmc.xgmi.head) {<br>
                  &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                  (!amdgpu_device_lock_adev(tmp_adev, hive)) {<br>
                  &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(tmp_adev-&gt;dev,
                  &quot;Bailing on TDR for s_job:%llx, as another already in
                  progress&quot;,<br>
                  &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job ?
                  job-&gt;base.id : -1);<br>
                  &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = 0;<br>
                  &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto skip_recovery;<br>
                  &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                  &gt; -<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Try to put the audio codec into
                  suspend state<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * before gpu reset started.<br>
                </div>
              </span></font></div>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------CC066039E2C3685DDB39E4CA--

--===============0862074615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0862074615==--
