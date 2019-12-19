Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA713C2D0D1
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 22:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E0724676
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 22:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vwspwWyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E0724676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B40446EBA8;
	Thu, 19 Dec 2019 22:44:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5456D6EBA7
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 22:44:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uj1Oh58Q4MJICdYt0VAu8Q35xvKBwMFTYzcvjbmekSRWXIRebSLBAp3r9zGx9N9bT2qRVvw+evGrL7kmQaDmZODqSAK3VwoeVLMCTlBpk6Hed4Atru2WPi9Y4shpFqwk8/QqYeozT82cLj0t3JUFV6hKoiWjCB3t37ygy+GzH0A98n45hzCU5szQrOtPuW/qmKA/AEjxupjIr7R07FY+l7vwGxGPOMPkjuj7jvllbOtniH50XDzIL8kpLCr8uCfzRaGVvJZohGAzCohE69OzBvxzcs+dZK/eRrh2EG9jqOlrh/UNI2KyPGBdCeu2bbh8OVdl29sEO/oz4OSXjvyiiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJPbHtx4Esb8mmgZquGDWi/C1FeGjW4lI9oIugDhCDE=;
 b=Q5PzOufMCa38iBAnyp4Cx/AuSsIkiS3ryQGTdN0cg4HvEa/7NE+CkV/rX+x8vE8g2rFzCQPw4qihXl20lxCpdIwd6FRI9+7TvPDkIcNJDH9tgcUtqBdnnMAEpkDiPJHZy16ll0OqZTI/2H/jChWcuyokEkYFYzEPR9HC9iCWdcVZ/rtD8mDbgr2qxSlhVlf7B4Sco4elbZDgdkvXv8KXQW8G8p3VI1srKiC0m2T6h6/K9g9kxAPLzwC3xoqYdEieGrGne7CE1KRypuIcM7HcONIFGW0W9don2DM4BDOZJQ5rB5QQBKpkimD7auL3Avu3ss5CNVTBhaBojjve9Xm7jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJPbHtx4Esb8mmgZquGDWi/C1FeGjW4lI9oIugDhCDE=;
 b=vwspwWyfzkVRj0rpSkATrPNNkllIqHJop9n3adV8Svpk0pXrTK2ZaGDuqwKQCTgkyc82FyaBsM3jp5L5QPBvW4iHWnMrQRwsnoaVBCDz/Ir4+WN4Dh+J36UuSsElcnpCh3UD8luJxEMuMGMXft5NT3ovdESel4dwDcvXkR1olHw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB4171.namprd12.prod.outlook.com (10.141.187.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 19 Dec 2019 22:44:27 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2538.019; Thu, 19 Dec 2019
 22:44:27 +0000
Subject: Re: [PATCwH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV
To: shaoyunl <shaoyun.liu@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1576577994-12874-1-git-send-email-Monk.Liu@amd.com>
 <1576577994-12874-2-git-send-email-Monk.Liu@amd.com>
 <b4117c49-7107-6ded-a5e0-9fd7ea69e9dc@amd.com>
 <MN2PR12MB3933E586A9792FC3901F460184520@MN2PR12MB3933.namprd12.prod.outlook.com>
 <MN2PR12MB39334EA3BB4AB52FDC37A97084520@MN2PR12MB3933.namprd12.prod.outlook.com>
 <DM6PR12MB3241F577F9502E7C7189B9CDF4520@DM6PR12MB3241.namprd12.prod.outlook.com>
 <MN2PR12MB393372385EF083A4654A28FD84520@MN2PR12MB3933.namprd12.prod.outlook.com>
 <DM6PR12MB32410F2E41C7AC550FCAB829F4520@DM6PR12MB3241.namprd12.prod.outlook.com>
 <e348a6ff-803a-a061-f348-a076470b63b9@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <d4fe6560-f9e4-98f0-42cc-8e24bd72fa95@amd.com>
Date: Thu, 19 Dec 2019 17:44:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <e348a6ff-803a-a061-f348-a076470b63b9@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::37) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9ad48baf-46c3-4350-6022-08d784d500b2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4171:|DM6PR12MB4171:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB417144938E8830FFC42DAB0192520@DM6PR12MB4171.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0256C18696
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(13464003)(51914003)(189003)(199004)(53546011)(6506007)(5660300002)(36916002)(52116002)(478600001)(966005)(30864003)(110136005)(316002)(4001150100001)(2906002)(8676002)(81156014)(81166006)(8936002)(31696002)(44832011)(86362001)(2616005)(26005)(186003)(6486002)(6512007)(36756003)(66946007)(31686004)(66556008)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4171;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCU1ZtyP+Y4XXMwkvlEX0PTuMIY5jQLRZeden5ws/93N7nmBFIjApuPYPafJzXLRHkdmmNR6EW/PqHeq7mKW0CsarZnxtAFOw2uO1YJi6WLTuC+PTiZveKGirKdSlkFOlMsbHy2FR6ghlBi80fiCScZRGY3d28nACNM1aR7Q+33Y0OLpj2K7Lp46sHbD5uHHfpFNISlo62UT5maEtXiowNjSGrYa9Lq6kZF0PtaZjzEh2OfGlTrD5H604B527ro7b4vlO3LUbObKLoPw8+9sPG5ZfaOOgy4IkoK94eiFDOTNjuC4P0tL5awjMV0xc8kLePz7zJFI5l2Y7500tlpT773nsMwmO7769Almur5L32lanmKc7wsEdtm0sTX/PuF6S0q1uecRczpZxo0Am2Wr7qDLpoVxK5vbD6ikv76kQ6k3pNQKctNh5rkNml7CB5I2efwJ27wD9OSrIA9cQEmmM8cIuBO1eSLadarDbKGS07OfpoT/CCoT2Rq3L9j1k3ObBbTwiFZp+cLOY7ML9+DQ6xawxy9rE7SUwp6erisOnZi95706LCZSY+1n2DpWmCwH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad48baf-46c3-4350-6022-08d784d500b2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 22:44:27.3263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USiGOC7ztdu6SEuu2XPzEJDkl9HdyLxO91X52FcU0nYj5jakc5C0SBHG+/lGVPfYbccwMOt1G15w271zxC1pJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I'm thinking, if we know we're preparing for a GPU reset, maybe we =

shouldn't even try to suspend processes and stop the HIQ. =

kfd_suspend_all_processes, stop_cpsch and other functions up that call =

chain up to kgd2kfd_suspend could have a parameter (bool pre_reset) that =

would update the driver state but not touch the hardware. That avoids =

unnecessary timeouts on things that aren't expected to complete anyway.

Regards,
 =A0 Felix


On 2019-12-19 11:59 a.m., shaoyunl wrote:
>
> After check the code , in KFD side , should be simple just add the =

> check in stop_cpsch code . For kiq, there is no return for WREG32 , so =

> no easy way to check the return value . Maybe we can add kiq_status in =

> struct amdgpu_kiq=A0 to indicate the kiq is hang or not ,=A0 in =

> hdq_destroy function check this=A0 kiq_status after acquire_queue , =

> finish the destroy function is kiq is hang for SRIOV only .
>
> Any comments ?
>
>
> shaoyun.liu
>
>
> On 2019-12-19 9:51 a.m., Liu, Shaoyun wrote:
>
>> I see, thanks for the detail information.
>> Normally when CP is hang, the hiq access to unmap the queue will =

>> failed before driver call to the hqd_destroy. I think driver should =

>> add the code to check the return value=A0 and directly finish the =

>> pre_reset in this case . If the hiq does not hang but kiq hang. We =

>> can use the same logic in hqd_destroy function, return in first =

>> access failure instead go further.=A0 With this change we probably can =

>> move the pre_reset function back to normal .
>> Felix, do you have any concerns or comments for the change.
>>
>> Regards
>> Shaoyun.liu
>> ------------------------------------------------------------------------
>> *From:* Liu, Monk <Monk.Liu@amd.com>
>> *Sent:* December 19, 2019 1:13:24 AM
>> *To:* Liu, Shaoyun <Shaoyun.Liu@amd.com>; =

>> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> *Subject:* RE: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR =

>> of SRIOV
>>
>> >>> I would like to check why we need a special sequences for sriov =

>> on this pre_reset. If possible, make it the same as bare metal mode =

>> sounds better solution.
>>
>> Because before VF FLR calling function would lead to register access =

>> through KIQ, =A0which will not complete because KIQ/GFX already hang by =

>> that time
>>
>> >>> I don't remember any register access by amdkfd_pre_reset call,=A0=A0 =

>> please let me know if this assumption is wrong .
>>
>> Please check =93void pm_uninit(struct packet_manager *pm)=94 which is =

>> invoked inside of amdkfd_pre_reset() :
>>
>> It will call uninitialized() in kfd_kernel_queue.c file
>>
>> And then go to the path of =93kq->mqd_mgr->destroy_mqd(=85)=94
>>
>> And finally it calls =93static int kgd_hqd_destroy(=85)=94 in =

>> amdgpu_amdkfd_gfx_v10.c
>>
>> 539 {
>>
>> 540=A0=A0=A0=A0 struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
>>
>> 541=A0=A0=A0=A0 enum hqd_dequeue_request_type type;
>>
>> 542=A0=A0=A0=A0 unsigned long end_jiffies;
>>
>> 543=A0=A0=A0=A0 uint32_t temp;
>>
>> 544=A0=A0=A0=A0 struct v10_compute_mqd *m =3D get_mqd(mqd);
>>
>> 545
>>
>> 546 #if 0
>>
>> 547=A0=A0=A0=A0 unsigned long flags;
>>
>> 548=A0=A0=A0=A0 int retry;
>>
>> 549 #endif
>>
>> 550
>>
>> 551=A0=A0=A0=A0 acquire_queue(kgd, pipe_id, queue_id); //this introduce =

>> register access via KIQ
>>
>> 552
>>
>> 553=A0=A0=A0=A0 if (m->cp_hqd_vmid =3D=3D 0)
>>
>> 554=A0=A0=A0=A0=A0=A0=A0=A0 WREG32_FIELD15(GC, 0, RLC_CP_SCHEDULERS, sch=
eduler1, 0); =

>> //this introduce register access via KIQ
>>
>> 555
>>
>> 556=A0=A0=A0=A0 switch (reset_type) {
>>
>> 557=A0=A0=A0=A0 case KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN:
>>
>> 558=A0=A0=A0=A0=A0=A0=A0=A0 type =3D DRAIN_PIPE;
>>
>> 559=A0=A0=A0=A0=A0=A0=A0=A0 break;
>>
>> 560=A0=A0=A0=A0 case KFD_PREEMPT_TYPE_WAVEFRONT_RESET:
>>
>> 561=A0=A0=A0=A0=A0=A0=A0=A0 type =3D RESET_WAVES;
>>
>> 562=A0=A0=A0=A0=A0=A0=A0=A0 break;
>>
>> 563=A0=A0=A0=A0 default:
>>
>> 564=A0=A0=A0=A0=A0=A0=A0=A0 type =3D DRAIN_PIPE;
>>
>> 565=A0=A0=A0=A0=A0=A0=A0=A0 break;
>>
>> 566=A0=A0=A0=A0 }
>>
>> 624=A0=A0=A0=A0 WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_DEQUEUE_REQUEST)=
, =

>> type); //this introduce register access via KIQ
>>
>> 625
>>
>> 626=A0=A0=A0=A0 end_jiffies =3D (utimeout * HZ / 1000) + jiffies;
>>
>> 627=A0=A0=A0=A0 while (true) {
>>
>> 628=A0=A0=A0=A0=A0=A0=A0=A0 temp =3D RREG32(SOC15_REG_OFFSET(GC, 0, mmCP=
_HQD_ACTIVE)); =

>> //this introduce register access via KIQ
>>
>> 629=A0=A0=A0=A0=A0=A0=A0=A0 if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
>>
>> 630=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>>
>> 631=A0=A0=A0=A0=A0=A0=A0=A0 if (time_after(jiffies, end_jiffies)) {
>>
>> 632=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_err("cp queue preemption time=
 out.\n");
>>
>> 633=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 release_queue(kgd);
>>
>> 634=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ETIME;
>>
>> 635=A0=A0=A0=A0=A0=A0=A0=A0 }
>>
>> 636=A0=A0=A0=A0=A0=A0=A0=A0 usleep_range(500, 1000);
>>
>> 637=A0=A0=A0=A0 }
>>
>> 638
>>
>> 639=A0=A0=A0=A0 release_queue(kgd);
>>
>> 640=A0=A0=A0=A0 return 0;
>>
>> If we use the sequence from bare-metal, all above highlighted =

>> register access will not work because KIQ/GFX already died by that =

>> time which means the amdkfd_pre_reset() is actually=A0 not working as =

>> expected.
>>
>> _____________________________________
>>
>> Monk Liu|GPU Virtualization Team |AMD
>>
>> sig-cloud-gpu
>>
>> *From:* Liu, Shaoyun <Shaoyun.Liu@amd.com>
>> *Sent:* Thursday, December 19, 2019 12:30 PM
>> *To:* Liu, Monk <Monk.Liu@amd.com>; amd-gfx@lists.freedesktop.org
>> *Subject:* Re: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR =

>> of SRIOV
>>
>> I don't remember any register access by amdkfd_pre_reset call,=A0=A0 =

>> please let me know if this assumption is wrong .
>> This function will use hiq to access CP, in case CP already hang, we =

>> might not able to get the response from hw and will got a timeout. I =

>> think kfd internal should handle this. Felix already have some =

>> comments on that.
>> I would like to check why we need a special sequences for sriov on =

>> this pre_reset. If possible, make it the same as bare metal mode =

>> sounds better solution.
>>
>> Regards
>> Shaoyun.liu
>>
>> ------------------------------------------------------------------------
>>
>> *From:*Liu, Monk <Monk.Liu@amd.com <mailto:Monk.Liu@amd.com>>
>> *Sent:* December 18, 2019 10:52:47 PM
>> *To:* Liu, Shaoyun <Shaoyun.Liu@amd.com =

>> <mailto:Shaoyun.Liu@amd.com>>; amd-gfx@lists.freedesktop.org =

>> <mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org =

>> <mailto:amd-gfx@lists.freedesktop.org>>
>> *Subject:* RE: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR =

>> of SRIOV
>>
>> Oh, by the way
>>
>> >>> Do we know the root cause why this function would ruin MEC ?
>>
>> Only we call this function right after VF FLR will ruin MEC and lead =

>> to following KIQ ring test fail , and on bare-metal it is called =

>> before gpu rest , so that's why on bare-metal we don't have this issue
>>
>> But the reason we cannot call it before VF FLR on SRIOV case was =

>> already stated in this thread
>>
>> Thanks
>> _____________________________________
>> Monk Liu|GPU Virtualization Team |AMD
>>
>>
>> -----Original Message-----
>> From: Liu, Monk
>> Sent: Thursday, December 19, 2019 11:49 AM
>> To: shaoyunl <shaoyun.liu@amd.com <mailto:shaoyun.liu@amd.com>>; =

>> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> Subject: RE: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of =

>> SRIOV
>>
>> Hi Shaoyun
>>
>> >>> Do we know the root cause why this function would ruin MEC ? From =

>> the logic, I think this function should be called before FLR since we =

>> need to disable the user queue submission first.
>> Right now I don't know which detail step lead to KIQ ring test fail, =

>> I totally agree with you that this func should be called before VF =

>> FLR, but we cannot do it and the reason is described in The comment:
>>
>> > if we do pre_reset() before VF FLR, it would go KIQ way to do register
>> > access and stuck there, because KIQ probably won't work by that time
>> > (e.g. you already made GFX hang)
>>
>>
>> >>> I remembered the function should use hiq to communicate with HW , =

>> shouldn't use kiq to access HW registerm,=A0 has this been changed ?
>> Tis function use WREG32/RREG32 to do register access, like all other =

>> functions in KMD,=A0 and WREG32/RREG32 will let KIQ to do the register =

>> access If we are under dynamic SRIOV=A0 mode (means we are SRIOV VF and =

>> isn't under full exclusive mode)
>>
>> You see that if you call this func before EVENT_5 (event 5 triggers =

>> VF FLR) then it will run under dynamic mode and KIQ will handle the =

>> register access, which is not an option Since ME/MEC probably already =

>> hang ( if we are testing quark on gfx/compute rings)
>>
>> Do you have a good suggestion ?
>>
>> thanks
>> _____________________________________
>> Monk Liu|GPU Virtualization Team |AMD
>>
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org =

>> <mailto:amd-gfx-bounces@lists.freedesktop.org>> On Behalf Of shaoyunl
>> Sent: Tuesday, December 17, 2019 11:38 PM
>> To: amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> Subject: Re: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of =

>> SRIOV
>>
>> I think amdkfd side depends on this call to stop the user queue, =

>> without this call, the user queue can submit to HW during the reset =

>> which could cause hang again ...
>> Do we know the root cause why this function would ruin MEC ? From the =

>> logic, I think this function should be called before FLR since we =

>> need to disable the user queue submission first.
>> I remembered the function should use hiq to communicate with HW , =

>> shouldn't use kiq to access HW registerm,=A0 has this been changed ?
>>
>>
>> Regards
>> shaoyun.liu
>>
>>
>> On 2019-12-17 5:19 a.m., Monk Liu wrote:
>> > issues:
>> > MEC is ruined by the amdkfd_pre_reset after VF FLR done
>> >
>> > fix:
>> > amdkfd_pre_reset() would ruin MEC after hypervisor finished the VF
>> > FLR, the correct sequence is do amdkfd_pre_reset before VF FLR but
>> > there is a limitation to block this sequence:
>> > if we do pre_reset() before VF FLR, it would go KIQ way to do register
>> > access and stuck there, because KIQ probably won't work by that time
>> > (e.g. you already made GFX hang)
>> >
>> > so the best way right now is to simply remove it.
>> >
>> > Signed-off-by: Monk Liu <Monk.Liu@amd.com <mailto:Monk.Liu@amd.com>>
>> > ---
>> >=A0=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 --
>> >=A0=A0 1 file changed, 2 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> > index 605cef6..ae962b9 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> > @@ -3672,8 +3672,6 @@ static int amdgpu_device_reset_sriov(struct =

>> amdgpu_device *adev,
>> >=A0=A0=A0=A0=A0=A0=A0 if (r)
>> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return r;
>> >
>> > -=A0=A0=A0=A0 amdgpu_amdkfd_pre_reset(adev);
>> > -
>> >=A0=A0=A0=A0=A0=A0=A0 /* Resume IP prior to SMC */
>> >=A0=A0=A0=A0=A0=A0=A0 r =3D amdgpu_device_ip_reinit_early_sriov(adev);
>> >=A0=A0=A0=A0=A0=A0=A0 if (r)
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
