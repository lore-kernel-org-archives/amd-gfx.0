Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F27C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 12:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25CCD611C0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 12:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 25CCD611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98C7C6E9EA;
	Fri, 10 Sep 2021 12:23:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B16EB6E9E8
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 12:23:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biHgGd2r/bUYprUNy4iHZ0anfqsw/TzpIJMMsmolxHAWkE/n/1phZv9eOppoAwOK3I7Kq9XG1rAhLKCdG+s84+sB3rzi16Atz0ZUE3ZEs/sgPgsbfPlvC+PtaYwdr4xdI0oSSdAJhAIC4rYlgT0e5T5lOzmR+7IVYjxwrw7E/EUzppIl2y0p+8FggRg8U4590HaV8NSA+aT6qaVaLBw5YILqW6D2xHp1+h9ZOIYvMR5lMrmdeJIzBKGMK0xOX5lCs0BGUhnEWaCbHGTot8oGhYQMgmqf4gdCsHOzawoWo2d5M8ALrHeYQ8FPm5OKJ93Wfy6S59kUddeWSZI3bLvFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Mcp6KBAHE+w/pMfL4EC5q/DK4GD4B6fTKK9ua8y0tME=;
 b=NlCD6xa6kZEXBA6aQiLl4gRmjHKKhWp86RNrl93XAGI2CCX/0vby0bBj0WQREXRE+CR+L+cYQF6q9EtDqY5CCO9GJ12+Fwph1Z8WomZeal04OLsY772+2XpnR5+xCPzyIpGlV7od+SPav8YUvbrbziAveq3Z1rp2Qka+FmPqNktj6y3PaXsEWidOJQrp+EYWJYA5C69SbJqn1+quhsdEEeFbHSNlaVk0qE2pAuHTf36ZwoEON1eGvh3bicOMPk2t4Ab8KFWyTWowcibhljCmbCE4qLFZCtnpPZEaq61jq5EycsuEiJfuGFCPBsWQOAJdgJ2JbLT74gwBzTiMi+/8uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mcp6KBAHE+w/pMfL4EC5q/DK4GD4B6fTKK9ua8y0tME=;
 b=Y9Jqw8uzFSCwEFa79RsZpaf7N/iSoWpy5V9h9jKqg23OWLJJ1pB+oQBDz7GZK6UwhsJwrdsYQ0nOk1JRBSTCbLQhpNOS4N868qTKpT1t1KHGpB3vteTpN2inWa9tmGjL2ViHTTjGlf1clWSYBc92YldwHgOSOK3zvn7xLrE8H74=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 12:23:19 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 12:23:19 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiDlm57lpI06IOWbnuWkjTogW1BBVENI?=
 =?UTF-8?Q?_2/4=5d_drm/amdgpu=3a_UVD_avoid_memory_allocation_during_IB_test?=
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210910003828.4013-1-xinhui.pan@amd.com>
 <20210910003828.4013-2-xinhui.pan@amd.com>
 <005bbb06-034d-6cdf-7c61-1d0339b2e54d@amd.com>
 <DM4PR12MB5165533F0F3EB7FE1F14CD6D87D69@DM4PR12MB5165.namprd12.prod.outlook.com>
 <9393c355-0d63-d4f5-1ecb-1ec9fa392a85@amd.com>
 <DM4PR12MB516591BAA84BA6798E40601E87D69@DM4PR12MB5165.namprd12.prod.outlook.com>
 <56bbddc3-2971-4f82-fce4-24cd773a8efc@amd.com>
 <DM4PR12MB5165DD166CF1CA57A579DD7087D69@DM4PR12MB5165.namprd12.prod.outlook.com>
 <7ae47f89-08eb-2ef2-c203-86c265e9ae31@amd.com>
 <DM4PR12MB516549F84BA58E16D447ABAF87D69@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b2011399-a4be-0fab-e87e-6a4cc5c214f4@amd.com>
Date: Fri, 10 Sep 2021 14:23:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM4PR12MB516549F84BA58E16D447ABAF87D69@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR03CA0095.eurprd03.prod.outlook.com
 (2603:10a6:208:69::36) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM0PR03CA0095.eurprd03.prod.outlook.com (2603:10a6:208:69::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 12:23:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd8ee1e5-496a-4e20-01b5-08d97455c5b2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB415973582CF82B2F1E3CB19983D69@MN2PR12MB4159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NfCvW3Wara5mmJc+iOC7a9jQUxx3jiAe8pwodOUkgo8v+x1fLyHVbfYuIk1Y2ZZciFU4tF2peQRlloMViDu/KT1S+1H5/lzaYgCZnfGg6JwHzXYEoKOMyYuvWz5K6HBeZDdPxNEHvJz5V2R30396FWY4+BgynzczPBVlUSVPhIBRUESJfat/xxluAPmLKIQcAUg67i6nD5UPY1CK07+2b9AFcBuE8RIxTkCWYvi1PzhaQvPd4FdpRaslcvPze+djPojS7k+pDKRQ0iD0bmk99miNqUKDM6HvrpcwBxjnsKhWkmxjRSG26mr67VmEoVtobejvQ+n8Z3VQHQ0HSnegj4xrPe0TRWWvicvXZ+d9OVe4RVjeGYzRNN9BzrjN8ewj4pcNR8hTpis1eHjoxbilp+18yD3fuw8Pq15mqEwOQZHu9ah0r+GqJO37nIx8pV3k1mlDrvWFSBikJ+ZZtXXBDnxIqZx2rzxNnBpJWbZ3sOmB0y62Th6pfythFEJJFH4iDFuaI3dSPFBf3LACsDnRUkAEq8Zp2OLblSXcK7D0tLXRfaCsiud4/q0dGg+3RSw8DTJAOLDi5xEDRDI4Lfh/zZEZhJ5GzD6iMXq7ulflwBpw+/tBDMYHScQaimv/UwkoVEdHcIuwCMJTXjwGcSqlCY50QDFxSA7CL2cyWbh51Ro5+wKOH5FlMOF14IB6TTtOxKcvY+KdTUOlB7bG3S24gJl5Nykx55Gu4F34O7Xonhg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(8936002)(31696002)(66946007)(6666004)(86362001)(66476007)(110136005)(66556008)(26005)(36756003)(186003)(316002)(30864003)(2616005)(16576012)(2906002)(4326008)(956004)(6486002)(31686004)(478600001)(224303003)(83380400001)(5660300002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?gb2312?B?OERnNVZWVDBuQWdFN2VXcE5EUXJEdVVCT2wycVBwMk9JSE03dmZYMkVsSmV5?=
 =?gb2312?B?Q2pWUE1IR2pXNnY2MmUxdEw4cW1Ha05tWExZaUJ6R1ZVSytvTUlrN1VHMU9q?=
 =?gb2312?B?bEp1Vmt5bm9DcnJEUmptMDNONTM3S2did0lyNVNnbDI2Wll4WFpOVU9BRkxy?=
 =?gb2312?B?NDYvYWFZZkdVUGk2azRHdWkyclZYeDFteXpVcDNjZ2F4d2M3YjlTWEZkS2ZQ?=
 =?gb2312?B?bUFCMTV5M09MeFhoVGxRUlg4a0hDZDIzSFBEVVI2T3lPb2pOWVc1ZXFwZUN0?=
 =?gb2312?B?aTRvUW5XTm5jVEpkbmU1cWxaZy9NTFlPcHBVWUhGcFVWMDJUU2srUFJtNDNS?=
 =?gb2312?B?L3VxNmViMnRmM1ZKQmhuTnNRcUZsdHlJbjZBTk13N001UmdLaEhnbW9ZTldW?=
 =?gb2312?B?Rmd4QUpwZlZvZlJicGFxTW55K3N6NFd2aG4rL1dlSHJQeWRMdGkyRDk5c045?=
 =?gb2312?B?WWEvWXEydi8rMFhselFlUnFsSld4ejA0d1JGUlkza21PZCtTdTRuWmtGSC9H?=
 =?gb2312?B?akxCblYxZlFzZEVmZm14WTkvYTZvc3dXZFhNUzFXMUU1Wmp1SjljTHcvcEZs?=
 =?gb2312?B?RzJBa1ZjU1A5SEZCZnBTeDE5WXFwNWFJclpMdHhnUFNkd0pPRExWR3VPNUVw?=
 =?gb2312?B?cElqaWM1UzB2UTg2YnlkN0VEV1prdEVVRGdqRWZremgzRlpxU1I1SGhRKzlX?=
 =?gb2312?B?UnRiRnEyai92K2RlTUJqNFF0Z3orT3prUFVZbHl0bXNrYkhQS0hWUUpZK2po?=
 =?gb2312?B?N3Z5YXVlRllmMDJIOUExdXArejhNYTYxZ3RKRTRMbnBzNTBMeUtLdGgxSHJ3?=
 =?gb2312?B?WU04eU9YWTRmdjBvNWR2bGFqUDRGMGVXWHN6Zzg3eVFJWVJMZnlDREVDWURN?=
 =?gb2312?B?SXV3R3Y1WTZFUnVQc0lVK1pVN0YwYXNCNDFCNmpSUGd0U2E0Lzd1UnNveVh5?=
 =?gb2312?B?bEVrNUE5UDFUVzFkZVB0a1BvNS9yYUxHWHErRzhzTGtKRm01SDlFNXZ2ci9L?=
 =?gb2312?B?cXB0TEEwSldvWGswUk9qQ29OYlVCaW1rLzdHQXNBR21vZTdwSHpwY0oxY0g0?=
 =?gb2312?B?SGNsaS94TllSOEwxVTJVQnA3ZzU2WWRyUFNIanB5Y0Zyb2Z2akFoMFlkZ0I3?=
 =?gb2312?B?SnprbVN2N3k1bVdreFkrZTg4ZmxzMk15d2xUSkdzS3Y1R3RWTXFUL1NnMHB6?=
 =?gb2312?B?SmJ3M3VHTkh4azhIOVo5K3duU3lBeGRMZ1IxS3d3NkozQ1l5VWc4QUZYeTda?=
 =?gb2312?B?amtNRnd4ZjNkSnhleUNmaktxNm4wOEhvRnd2MUJJaTJ1QlQ4TFJ5dUlNRE5o?=
 =?gb2312?B?bjN0Mk9VVDlMRVpaN3M5YjNkamI0Y3pNZGsyV3VUbUt0d2NMZ252UHRoTEM1?=
 =?gb2312?B?SGE0N3hNTWJsY2FqNmNRUWRuZU9xallPSDhzQllTK004b2tnenRhODMrVFp2?=
 =?gb2312?B?ZUZzQlR1dkY4SzN6S2tab09UMVR4czdXdGtJUmVJNFZERkVsVU94K2dqdk1s?=
 =?gb2312?B?cDdaYy9FMVNLbXBrTnIwUkUyNmxuaUZQL1IwanBlZDNvaGdNNHpDaTBsU3pM?=
 =?gb2312?B?bzNuVFo4MWNYWXFiTFI1enRIclN5RDROWENVSE1peEVNZWo4bCtoNmkvcGUv?=
 =?gb2312?B?a1ZtTldEcG1aMENDSzM1bUtzVWduQlVCTXAzWHI3eWhPM1F4SnBVbElJbEtJ?=
 =?gb2312?B?eG5Ja3ROdnVhb1diMnN0L0p5MVduTXJBLzVZWTExa09VTVhIWDNpSitqWjk3?=
 =?gb2312?Q?l0zkSesV30WkkHgXcUU3bKbBPEOD/u9IUNwd3yz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8ee1e5-496a-4e20-01b5-08d97455c5b2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 12:23:18.9604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXa39L7N0Dz0o+mZZHKK40rmQwiQtQnguKq3EWWIxBmGSJwgeTuffwX15Y5ORX2U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yeah, that indeed sounds buggy. Probably easiest to just down write the 
reset sem.

Christian.

Am 10.09.21 um 13:48 schrieb Pan, Xinhui:
> [AMD Official Use Only]
>
> looks like amdgpu_debugfs_test_ib_show use direct IB submission too.
> It parks the ring scheduler thread, and down read the reset_sem to avoid race with gpu reset.
> BUT, amdgpu_debugfs_test_ib_show itself could be called in parrel. Need fix it.
>
> ________________________________________
> 发件人: Koenig, Christian <Christian.Koenig@amd.com>
> 发送时间: 2021年9月10日 19:10
> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
> 抄送: Deucher, Alexander
> 主题: Re: 回复: 回复: 回复: [PATCH 2/4] drm/amdgpu: UVD avoid memory allocation during IB test
>
> Yeah, but that IB test should use the indirect submission through the
> scheduler as well.
>
> Otherwise you have IB test and scheduler writing both to the ring buffer
> at the same time and potentially corrupting it.
>
> Christian.
>
> Am 10.09.21 um 12:10 schrieb Pan, Xinhui:
>> [AMD Official Use Only]
>>
>> we need take this lock.
>> IB test can be triggered through debugfs. Recent days I usually test it by cat gpu recovery and amdgpu_test_ib in debugfs.
>>
>>
>> ________________________________________
>> 发件人: Koenig, Christian <Christian.Koenig@amd.com>
>> 发送时间: 2021年9月10日 18:02
>> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
>> 抄送: Deucher, Alexander
>> 主题: Re: 回复: 回复: [PATCH 2/4] drm/amdgpu: UVD avoid memory allocation during IB test
>>
>> *sigh* yeah, you are probably right. Wouldn't be to simple if this would
>> be easy, doesn't it?
>>
>> In this case you can also skip taking the reservation lock for the
>> pre-allocated BO, since there should absolutely be only one user at a time.
>>
>> Christian.
>>
>> Am 10.09.21 um 11:42 schrieb Pan, Xinhui:
>>> [AMD Official Use Only]
>>>
>>> oh, god. uvd free handler submit delayed msg which depends on scheduler with reservation lock hold.
>>> This is not allowed as commit c8e42d57859d "drm/amdgpu: implement more ib pools (v2)" says
>>> Any jobs which schedule IBs without dependence on gpu scheduler should use DIRECT pool.
>>>
>>> Looks like we should only use reserved BO for direct IB submission.
>>> As for delayed IB submission, we could alloc a new one dynamicly.
>>> ________________________________________
>>> 发件人: Koenig, Christian <Christian.Koenig@amd.com>
>>> 发送时间: 2021年9月10日 16:53
>>> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
>>> 抄送: Deucher, Alexander
>>> 主题: Re: 回复: [PATCH 2/4] drm/amdgpu: UVD avoid memory allocation during IB test
>>>
>>> It should not unless we are OOM which should not happen during driver
>>> initialization.
>>>
>>> But there is another problem I'm thinking about: Do we still use UVD IB
>>> submissions to forcefully tear down UVD sessions when a process crashes?
>>>
>>> If yes that stuff could easily deadlock with an IB test executed during
>>> GPU reset.
>>>
>>> Christian.
>>>
>>> Am 10.09.21 um 10:18 schrieb Pan, Xinhui:
>>>> [AMD Official Use Only]
>>>>
>>>> I am wondering if amdgpu_bo_pin would change BO's placement in the futrue.
>>>> For now, the new placement is calculated by new = old ∩ new.
>>>>
>>>> ________________________________________
>>>> 发件人: Koenig, Christian <Christian.Koenig@amd.com>
>>>> 发送时间: 2021年9月10日 14:24
>>>> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
>>>> 抄送: Deucher, Alexander
>>>> 主题: Re: [PATCH 2/4] drm/amdgpu: UVD avoid memory allocation during IB test
>>>>
>>>> Am 10.09.21 um 02:38 schrieb xinhui pan:
>>>>> move BO allocation in sw_init.
>>>>>
>>>>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>>>>> ---
>>>>>       drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 75 +++++++++++++++----------
>>>>>       drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |  1 +
>>>>>       drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c   |  8 +--
>>>>>       drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c   |  8 +--
>>>>>       4 files changed, 49 insertions(+), 43 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>>>> index d451c359606a..e2eaac941d37 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>>>> @@ -141,6 +141,8 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>>>>>           const char *fw_name;
>>>>>           const struct common_firmware_header *hdr;
>>>>>           unsigned family_id;
>>>>> +     struct amdgpu_bo *bo = NULL;
>>>>> +     void *addr;
>>>>>           int i, j, r;
>>>>>
>>>>>           INIT_DELAYED_WORK(&adev->uvd.idle_work, amdgpu_uvd_idle_work_handler);
>>>>> @@ -298,9 +300,34 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>>>>>                   adev->uvd.filp[i] = NULL;
>>>>>           }
>>>>>
>>>>> +     r = amdgpu_bo_create_reserved(adev, 128 << 10, PAGE_SIZE,
>>>>> +                     AMDGPU_GEM_DOMAIN_GTT,
>>>>> +                     &bo, NULL, &addr);
>>>>> +     if (r)
>>>>> +             return r;
>>>>> +
>>>>>           /* from uvd v5.0 HW addressing capacity increased to 64 bits */
>>>>> -     if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0))
>>>>> +     if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0)) {
>>>>>                   adev->uvd.address_64_bit = true;
>>>>> +             amdgpu_bo_kunmap(bo);
>>>>> +             amdgpu_bo_unpin(bo);
>>>>> +             r = amdgpu_bo_pin_restricted(bo, AMDGPU_GEM_DOMAIN_VRAM,
>>>>> +                             0, 256 << 20);
>>>> Please keep using amdgpu_uvd_force_into_uvd_segment() and validate here,
>>>> cause I want to remove amdgpu_bo_pin_restricted() sooner or later.
>>>>
>>>>> +             if (r) {
>>>>> +                     amdgpu_bo_unreserve(bo);
>>>>> +                     amdgpu_bo_unref(&bo);
>>>>> +                     return r;
>>>>> +             }
>>>>> +             r = amdgpu_bo_kmap(bo, &addr);
>>>>> +             if (r) {
>>>>> +                     amdgpu_bo_unpin(bo);
>>>>> +                     amdgpu_bo_unreserve(bo);
>>>>> +                     amdgpu_bo_unref(&bo);
>>>>> +                     return r;
>>>>> +             }
>>>>> +     }
>>>>> +     adev->uvd.ib_bo = bo;
>>>>> +     amdgpu_bo_unreserve(bo);
>>>>>
>>>>>           switch (adev->asic_type) {
>>>>>           case CHIP_TONGA:
>>>>> @@ -342,6 +369,7 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
>>>>>                   for (i = 0; i < AMDGPU_MAX_UVD_ENC_RINGS; ++i)
>>>>>                           amdgpu_ring_fini(&adev->uvd.inst[j].ring_enc[i]);
>>>>>           }
>>>>> +     amdgpu_bo_free_kernel(&adev->uvd.ib_bo, NULL, NULL);
>>>>>           release_firmware(adev->uvd.fw);
>>>>>
>>>>>           return 0;
>>>>> @@ -1080,23 +1108,10 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>>>>>           unsigned offset_idx = 0;
>>>>>           unsigned offset[3] = { UVD_BASE_SI, 0, 0 };
>>>>>
>>>>> -     amdgpu_bo_kunmap(bo);
>>>>> -     amdgpu_bo_unpin(bo);
>>>>> -
>>>>> -     if (!ring->adev->uvd.address_64_bit) {
>>>>> -             struct ttm_operation_ctx ctx = { true, false };
>>>>> -
>>>>> -             amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
>>>>> -             amdgpu_uvd_force_into_uvd_segment(bo);
>>>>> -             r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>>>> -             if (r)
>>>>> -                     goto err;
>>>>> -     }
>>>>> -
>>>>>           r = amdgpu_job_alloc_with_ib(adev, 64, direct ? AMDGPU_IB_POOL_DIRECT :
>>>>>                                        AMDGPU_IB_POOL_DELAYED, &job);
>>>>>           if (r)
>>>>> -             goto err;
>>>>> +             return r;
>>>>>
>>>>>           if (adev->asic_type >= CHIP_VEGA10) {
>>>>>                   offset_idx = 1 + ring->me;
>>>>> @@ -1148,8 +1163,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>>>>>           }
>>>>>
>>>>>           amdgpu_bo_fence(bo, f, false);
>>>>> -     amdgpu_bo_unreserve(bo);
>>>>> -     amdgpu_bo_unref(&bo);
>>>>>
>>>>>           if (fence)
>>>>>                   *fence = dma_fence_get(f);
>>>>> @@ -1159,10 +1172,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>>>>>
>>>>>       err_free:
>>>>>           amdgpu_job_free(job);
>>>>> -
>>>>> -err:
>>>>> -     amdgpu_bo_unreserve(bo);
>>>>> -     amdgpu_bo_unref(&bo);
>>>>>           return r;
>>>>>       }
>>>>>
>>>>> @@ -1173,16 +1182,15 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>>>>>                                 struct dma_fence **fence)
>>>>>       {
>>>>>           struct amdgpu_device *adev = ring->adev;
>>>>> -     struct amdgpu_bo *bo = NULL;
>>>>> +     struct amdgpu_bo *bo = adev->uvd.ib_bo;
>>>>>           uint32_t *msg;
>>>>>           int r, i;
>>>>>
>>>>> -     r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
>>>>> -                                   AMDGPU_GEM_DOMAIN_GTT,
>>>>> -                                   &bo, NULL, (void **)&msg);
>>>>> +     r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
>>>>>           if (r)
>>>>>                   return r;
>>>>>
>>>>> +     msg = amdgpu_bo_kptr(bo);
>>>>>           /* stitch together an UVD create msg */
>>>>>           msg[0] = cpu_to_le32(0x00000de4);
>>>>>           msg[1] = cpu_to_le32(0x00000000);
>>>>> @@ -1198,23 +1206,25 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>>>>>           for (i = 11; i < 1024; ++i)
>>>>>                   msg[i] = cpu_to_le32(0x0);
>>>>>
>>>>> -     return amdgpu_uvd_send_msg(ring, bo, true, fence);
>>>>> +     r = amdgpu_uvd_send_msg(ring, bo, true, fence);
>>>>> +
>>>>> +     amdgpu_bo_unreserve(bo);
>>>>> +     return r;
>>>>>       }
>>>>>
>>>>>       int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>>>>>                                  bool direct, struct dma_fence **fence)
>>>>>       {
>>>>>           struct amdgpu_device *adev = ring->adev;
>>>>> -     struct amdgpu_bo *bo = NULL;
>>>>> +     struct amdgpu_bo *bo = adev->uvd.ib_bo;
>>>>>           uint32_t *msg;
>>>>>           int r, i;
>>>>>
>>>>> -     r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
>>>>> -                                   AMDGPU_GEM_DOMAIN_GTT,
>>>>> -                                   &bo, NULL, (void **)&msg);
>>>>> +     r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
>>>> Please use amdgpu_bo_reserve() here and elsewhere as well just to be on
>>>> the clean side.
>>>>
>>>> Lockdep will sooner or later complain that we reserve a BO in the reset
>>>> path, but that is mostly a theoretical problem and existed before. So
>>>> I'm fine with sticking with that for now cause the problem was there
>>>> before as well.
>>>>
>>>> It's just that trylock might not work because the BO is busy with
>>>> indirect submission.
>>>>
>>>> Apart from those two minor issues the patch looks good to me.
>>>>
>>>> Thanks,
>>>> Christian.
>>>>
>>>>>           if (r)
>>>>>                   return r;
>>>>>
>>>>> +     msg = amdgpu_bo_kptr(bo);
>>>>>           /* stitch together an UVD destroy msg */
>>>>>           msg[0] = cpu_to_le32(0x00000de4);
>>>>>           msg[1] = cpu_to_le32(0x00000002);
>>>>> @@ -1223,7 +1233,10 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>>>>>           for (i = 4; i < 1024; ++i)
>>>>>                   msg[i] = cpu_to_le32(0x0);
>>>>>
>>>>> -     return amdgpu_uvd_send_msg(ring, bo, direct, fence);
>>>>> +     r = amdgpu_uvd_send_msg(ring, bo, direct, fence);
>>>>> +
>>>>> +     amdgpu_bo_unreserve(bo);
>>>>> +     return r;
>>>>>       }
>>>>>
>>>>>       static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
>>>>> index edbb8194ee81..76ac9699885d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
>>>>> @@ -68,6 +68,7 @@ struct amdgpu_uvd {
>>>>>           /* store image width to adjust nb memory state */
>>>>>           unsigned                decode_image_width;
>>>>>           uint32_t                keyselect;
>>>>> +     struct amdgpu_bo        *ib_bo;
>>>>>       };
>>>>>
>>>>>       int amdgpu_uvd_sw_init(struct amdgpu_device *adev);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>>>> index bc571833632e..301c0cea7164 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>>>> @@ -332,12 +332,10 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
>>>>>       static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>>>>       {
>>>>>           struct dma_fence *fence = NULL;
>>>>> -     struct amdgpu_bo *bo = NULL;
>>>>> +     struct amdgpu_bo *bo = ring->adev->uvd.ib_bo;
>>>>>           long r;
>>>>>
>>>>> -     r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
>>>>> -                                   AMDGPU_GEM_DOMAIN_VRAM,
>>>>> -                                   &bo, NULL, NULL);
>>>>> +     r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
>>>>>           if (r)
>>>>>                   return r;
>>>>>
>>>>> @@ -357,9 +355,7 @@ static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>>>>
>>>>>       error:
>>>>>           dma_fence_put(fence);
>>>>> -     amdgpu_bo_unpin(bo);
>>>>>           amdgpu_bo_unreserve(bo);
>>>>> -     amdgpu_bo_unref(&bo);
>>>>>           return r;
>>>>>       }
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>>>>> index b6e82d75561f..efa270288029 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>>>>> @@ -338,12 +338,10 @@ static int uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handl
>>>>>       static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>>>>       {
>>>>>           struct dma_fence *fence = NULL;
>>>>> -     struct amdgpu_bo *bo = NULL;
>>>>> +     struct amdgpu_bo *bo = ring->adev->uvd.ib_bo;
>>>>>           long r;
>>>>>
>>>>> -     r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
>>>>> -                                   AMDGPU_GEM_DOMAIN_VRAM,
>>>>> -                                   &bo, NULL, NULL);
>>>>> +     r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
>>>>>           if (r)
>>>>>                   return r;
>>>>>
>>>>> @@ -363,9 +361,7 @@ static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>>>>
>>>>>       error:
>>>>>           dma_fence_put(fence);
>>>>> -     amdgpu_bo_unpin(bo);
>>>>>           amdgpu_bo_unreserve(bo);
>>>>> -     amdgpu_bo_unref(&bo);
>>>>>           return r;
>>>>>       }
>>>>>

