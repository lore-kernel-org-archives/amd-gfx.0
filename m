Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA244C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 04:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CBB465159
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 04:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBB465159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93B3D89C60;
	Mon,  8 Mar 2021 04:22:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A40689C14
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 04:22:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+4PILL3PVj33Dgt13gHlG5a0Tj3gVS1BXLz1gZwlKub/ggoJiQjMYWKkIBD9E2dAv5WVoEiWRbE8VnoCIIPTw4njRZW3kL2Bht/KB6LCWMAM/yRA0JTdmvOR7ALPGFCsnpy2sRRQ3dzIFH/BJjQznmnl4m8aY0RPH0djm8GYEZp1H17G68oDqo+N6R4jD2DEWdDLKexSB16A61EfinF/ryccyDV2s+js3XwDVB096u+F/yg1Yyc6eWpdumFXo49KTu0CXCfjj2L9cXrJmjw7QYX8J072/iBN8Bk+jk5Vdl2FTccSFbWF3g/AipX5dhW2q43bVdwGPtL9ET2IfQhmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4NPqyXfqtaf+Kp61zhBEtpn21oNVgUpiSPx8fY70z0=;
 b=Gxeu1e9D44DbahSyUalgaqEZZmagWEbI1mb3ACiCMT+BYeLUtLAzlzW3gPTuRDCcENnRk0zHS+KwBMUlZsaKrWqvjUebMIxGnPuzRm5zb6HlUYDqbdpAx1fkC2LFRVnieEFSBIrw8EfgKrLIz8bw6AMebJO4iXB1AjiZjDiP4ajQzgrRSDxXIAjpoAqa5cfjc278gN9otm+SNZPBjz3HKCfROdwLcRLPd0tjZ1WMukvu3iXL0ZuBhXgEla4C16x8sTPvXAS+ia+g0RB8Kh1fwRJmoL8eJ93kvJTa6rwl7XfqGFUIYdU5VrAlXR7rixrhfnGZqr4Gw1Ob3wf9IlSdxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4NPqyXfqtaf+Kp61zhBEtpn21oNVgUpiSPx8fY70z0=;
 b=HPWAR4K7IRxHTVr+pKs8yIuz7NGCk3g9DWZEGgTif7ozMw5QD2rSDyfxXZ4sc43IZyjdv6MKpoBUM2Pu74nEUykF0Y9R28GGGaxtnjQA1nNBhov9i32ADdY5yd+k3bAAosct5PanLHBTNDi97WR+Bta7mAwLHbKdAFCHjitUCOQ=
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10)
 by DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Mon, 8 Mar
 2021 04:22:15 +0000
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::28e0:5877:b4e6:6bdc]) by DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::28e0:5877:b4e6:6bdc%9]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 04:22:15 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Grodzovsky, Andrey"
 <Andrey.Grodzovsky@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>
Subject: RE: [PATCH v2] drm/amd/amdgpu implement tdr advanced mode
Thread-Topic: [PATCH v2] drm/amd/amdgpu implement tdr advanced mode
Thread-Index: AQHXEq260lsF0zvj+Uq4iNPnJeT2C6p3UWSAgAIp9QCAAANF0A==
Date: Mon, 8 Mar 2021 04:22:14 +0000
Message-ID: <DM5PR1201MB020418AFE4B70E229D82ADC8BB939@DM5PR1201MB0204.namprd12.prod.outlook.com>
References: <20210306172507.202243-1-Jack.Zhang1@amd.com>
 <9cea258e-1220-635e-1133-7dc1eae397b0@amd.com>
 <DM5PR12MB1708DCEC60FE2059CEE1DE5684939@DM5PR12MB1708.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1708DCEC60FE2059CEE1DE5684939@DM5PR12MB1708.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-08T04:05:55Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=2ed3891a-6c21-4f75-bbfc-549fee073cf6;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4180d6b-1ce3-46c5-2e2d-08d8e1e9c0c7
x-ms-traffictypediagnostic: DM5PR12MB1754:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1754F3980872AB0983882487BB939@DM5PR12MB1754.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gefEksGhF45FXuFQMhjJIWWdokoMIL+/SJ4JHPLv+JvSVIWJTcd5Z3/2MEgkPWKi4/kFJq4v8eh3nd+d1l78+RgNSTW4UFBgICLk0GZ6PxnPpYeTDwGFNzrzzOxsGODa8VdzSUoTD0Bwukx51MvwVk/8ZKshC2Q5HCTifxrXSjRqcNfnuJzv5wtXdOn13fvx3xR0Nk8JHsiBjAKEWq6ivVhBa97SRx1i3xb8QfnOkllHB5CWkobvfHnXTkCf0wUgWdE0H1uuhA/OWgKYvjG2PZ4ljFzdeXfBaSsFORPGeq6BD1GU/03AbcFXo6k8PuAmbpg5uwtvxccutFmoYq/Q4gQALb7Lw1z+lbA+UczT52+35bCaX/9aVu7XYVLmDYDsOD3kAl3aMimkDG2Y1+atB+/jGqpumg99SOswKK5Lyuka75No1BcYTWEyYdt2q21CprPyqRlIgwvQ5MX098IO9mEtZwcPhNBND3bM6SD1YFCeKyC5TJDU8pBr9PGb0N/pk6JbwrLd8hbp9ILEWscHOg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0204.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(33656002)(86362001)(66946007)(5660300002)(52536014)(7696005)(110136005)(71200400001)(26005)(186003)(478600001)(9686003)(8676002)(8936002)(2906002)(316002)(76116006)(6636002)(53546011)(83380400001)(64756008)(66476007)(66556008)(66446008)(6506007)(30864003)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?Y1BZUDBOYTFkRHprT2R3SjJmWEZFbmlDcXJzSTQ3eGI0UFNXb2s0YXFMblNw?=
 =?utf-8?B?aGhmN01wK2hTN3NPUHdWQzdFd2RFZmVwMDhESklmdGl0dmhDemRaYWhrMVRl?=
 =?utf-8?B?UkNFLzhQQk13MzlzVDlYdXlBNDBsZUM3UCt3VjJzRkRlZ1h0Q1o1aUVqM2p3?=
 =?utf-8?B?R3JQYy9Mek5LaldET1NTUHFtUDhCQU1GL2tsS1JKL3lLYlZ0UnEvMGxXb2hp?=
 =?utf-8?B?U29WWmtEZGJCWDBqWDZSazNtWldHTE5HbjJhdldmS29Ib3R0czA4dnFzVU1P?=
 =?utf-8?B?VzAvNG02YWlxejNPUGV2dHpvOU1Bd09xN2Q3c3ZZdTh3MVowK0M3MVdqYkJF?=
 =?utf-8?B?RzJHb0JuSHB6S0ZZaVRSYU4vTU1ScFg4N0lnclpIWElzaFhDSHFFYUNINEYz?=
 =?utf-8?B?TWFYNElvcElVRWdlS3ZCSjhCeml3RUNwaUg3bDg5UlFFQkg0bUVZa2x2NHRi?=
 =?utf-8?B?MXY3S0pOWVI5Z2hnZEtDN0J6SDk3dWFCNHlKakxSUFU4NWJLb3J0clpWQkRJ?=
 =?utf-8?B?aEFOYkNZMHJkMHRrMDVUYXdUMkgvTjBSTGE3dTkyYjh4R2tCc1ZMcUN5OVRz?=
 =?utf-8?B?K3hQWm9iMkxsNGRrQ2FjYnB3aXkrOE0vN0FnbWFOcnZnVWVPcCtMenNycVlP?=
 =?utf-8?B?N0FremVXK3VpcDBOSm9BT0xwSmcwMWF3MzVIdVlpZSsxb21QN1ZrU0NjVWRv?=
 =?utf-8?B?ZDhoV3JhRHRDKzFDeEt6SDdMSEZNQnZ0aHlLdWd1Y0JPRnhMdmNNZXdzVnph?=
 =?utf-8?B?cnFpRlFCdVN1YnU0eHFFd0hpWUp3aTNpRVlMZ0YrTkxlK3FEb0ZxWUNrNlRG?=
 =?utf-8?B?QTFOaFMyc3VIYWtJSUlOZWMrMzNJcWZYSkloMGxzandTTytGUW11LzlIWDBs?=
 =?utf-8?B?K3dHMm9wNGdaaU9wWXh4WUpnSHpZUzRSYzZKaTRaWTVPbU8zeFBQK29FeGNT?=
 =?utf-8?B?bEFVWnhyLzlZSTVhU2FrNDdTeDUxQy9Xc2NKNGZDQ04vSnRuTENtUE9Xdm0r?=
 =?utf-8?B?OWxiNzlKemZZUUNZNmlVYWFZaXJlVjJ4Z00yVnYyYlNNTXZOazA1YldmcGY2?=
 =?utf-8?B?QTJmdDBXYURrOU9ENWNueElCMEJuU2l3YkxLVitrelhhdldFL3RpeGwxQmlO?=
 =?utf-8?B?RU1IMmlwcGp0ZWIza3g4ZlV1RXR4azRCWlNhdStZZStuYlM4cWlLRUk4Ly9T?=
 =?utf-8?B?U2ljaStlL3E1MGJ0TTlra1VEeGk3ZkNmVHVORERwN1EyZUlGb0RzbHBzREMz?=
 =?utf-8?B?Sy9SSy9KSy93OTM3Z05JSlFZeWVWdnB6UXEwRStPbHA3UEcrUTNqYmdaZnk1?=
 =?utf-8?B?SnRsUDVPcTd6dEhCT1laT1g4QzJCWTA3ZU9CNWpaR3JTazRFcjYzMnpIdmh0?=
 =?utf-8?B?ZzdhTk9pNmo0YVRSby9uenNiNG1EdFhtM0ZnUUVYZHJxaVRVTFdOSzRkd3Yx?=
 =?utf-8?B?Ynd6UnNMZE9xYWZBWk51UjUyUWhNblhMcFdOT014YStDeTRZU0NoakJhUENM?=
 =?utf-8?B?cWFja2pMQlI0b0RURmRnK1NQZzVlNDB6WGt0SkxRSy9ETWpHN28yam4yclc1?=
 =?utf-8?B?T3JwN3hoNUFKeVFUM2ZTRFNWK3FKbWhVRWlyT1JWdkZOempkWkUzR0hEeWt6?=
 =?utf-8?B?cXQ1VGRPaWNjYVpMK25zYU9RQ0M5Qi9oQjhqd2ZWeHJURzhXMzltUGo0Rmsx?=
 =?utf-8?B?TkZndHJGNkpoYlI3Tk0rdWRpOWJnazlKa3dTV2dIazUzL1VlK3RIemI1Zm9p?=
 =?utf-8?Q?lY90ZQD/F+HW4C+re3v7goJ7vt0NY2M6i60jl+D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0204.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4180d6b-1ce3-46c5-2e2d-08d8e1e9c0c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 04:22:14.8204 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7HDqJm5rl1D2up6Nc7nw0/PouIaTkSbEMFY98f6h+TSa/bP7fsVPpVOyZehW+g4k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1754
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi, Christian and Monk,

Thanks so much for these valuable ideas. I will follow the advices.

>> Then the implementation is way to complicate. All you need to do is insert a dma_fence_wait after re-scheduling each job after a reset.
Sure, if I re-implement amd_sched_resubmit_jobs2(), and add a dma_fence_wait inside the job2 func, the change will be simpler.
I will do the change and submit for review later.

Thanks a lot for your help.
/Jack

-----Original Message-----
From: Liu, Monk <Monk.Liu@amd.com> 
Sent: Monday, March 8, 2021 12:06 PM
To: Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; amd-gfx@lists.freedesktop.org; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Deng, Emily <Emily.Deng@amd.com>
Subject: RE: [PATCH v2] drm/amd/amdgpu implement tdr advanced mode

[AMD Official Use Only - Internal Distribution Only]

>> well first of all please completely drop the affinity group stuff from this patch. We should concentrate on one feature at at time.
We need it to expedite the process, we can introduce this change in another patch


>> Then the implementation is way to complicate. All you need to do is insert a dma_fence_wait after re-scheduling each job after a reset.
No that's not true, during the " drm_sched_resubmit_jobs" it will put all jobs in mirror list into the hw ring, but we can only allow the first job to the ring To catch the real guilty one (otherwise it is possible that the later job in the ring also has bug and affect our judgement) So we need to implement a new " drm_sched_resubmit_jobs2()", like this way:

drm_sched_resubmit_jobs2()
~ 499 void drm_sched_resubmit_jobs2(struct drm_gpu_scheduler *sched, int max)
  500 {
  501     struct drm_sched_job *s_job, *tmp;
  502     uint64_t guilty_context;
  503     bool found_guilty = false;
  504     struct dma_fence *fence;
+ 505     int i = 0;
  506
  507     list_for_each_entry_safe(s_job, tmp, &sched->ring_mirror_list, node) {
  508         struct drm_sched_fence *s_fence = s_job->s_fence;
  509
+ 510         if (i >= max)
+ 511             break;
+ 512
  513         if (!found_guilty && atomic_read(&s_job->karma) > sched->hang_limit) {
  514             found_guilty = true;
  515             guilty_context = s_job->s_fence->scheduled.context;
  516         }
  517
  518         if (found_guilty && s_job->s_fence->scheduled.context == guilty_context)
  519             dma_fence_set_error(&s_fence->finished, -ECANCELED);
  520
  521         dma_fence_put(s_job->s_fence->parent);
  522         fence = sched->ops->run_job(s_job);
+ 523         i++;
  524
  525         if (IS_ERR_OR_NULL(fence)) {
  526             if (IS_ERR(fence))
  527                 dma_fence_set_error(&s_fence->finished, PTR_ERR(fence));
  528
  529             s_job->s_fence->parent = NULL;
  530         } else {
  531             s_job->s_fence->parent = fence;
  532         }
  533
  534
  535     }
  536 }
  537 EXPORT_SYMBOL(drm_sched_resubmit_jobs);
  538



Thanks 

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Sunday, March 7, 2021 3:03 AM
To: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; amd-gfx@lists.freedesktop.org; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Deng, Emily <Emily.Deng@amd.com>
Subject: Re: [PATCH v2] drm/amd/amdgpu implement tdr advanced mode

Hi Jack,

well first of all please completely drop the affinity group stuff from this patch. We should concentrate on one feature at at time.

Then the implementation is way to complicate. All you need to do is insert a dma_fence_wait after re-scheduling each job after a reset.

Additional to that this feature is completely AMD specific and shouldn't affect the common scheduler in any way.

Regards,
Christian.

Am 06.03.21 um 18:25 schrieb Jack Zhang:
> [Why]
> Previous tdr design treats the first job in job_timeout as the bad job.
> But sometimes a later bad compute job can block a good gfx job and 
> cause an unexpected gfx job timeout because gfx and compute ring share 
> internal GC HW mutually.
>
> [How]
> This patch implements an advanced tdr mode.It involves an additinal 
> synchronous pre-resubmit step(Step0 Resubmit) before normal resubmit 
> step in order to find the real bad job.
>
> 1. For Bailing TDR job, re-insert it to mirror_list, don't set it to 
> guilty and leave it to be handled by the main reset thread.
>
> 2. Don't set the job to guilty in pre_asic_reset, and leave it to be 
> handled by Step0 Resubmit Stage.
>
> 3. At Step0 Resubmit stage, it first resubmit jobs asynchronously, 
> then it iterate each ring mirror_list, synchronously pend for each hw 
> fence being signaled. If the a job's hw fence get timeout, we identify 
> it as guilty and do hw reset to recover hw. After that, we would do 
> the normal resubmit step to resubmit left jobs.
>
> 4. For whole gpu reset(vram lost), skip Step0 Resubmit as each job 
> after vram lost was considered as bad job.
>
> 5. Involve the concept "Affinity Group".
> Doing two hw resets is not necessary when there's only one ring that 
> has jobs among some hw-related rings.Thus, we involve "affinity group".
> Hw-related rings could be added into a common affinity group, such as 
> gfx and compute ring. When tdr happens, we iterate all rings in 
> affinity group, skip Step0 Resubmit stage if there's only one ring's 
> mirror_list that has valid sched jobs.
>
> V2:
>      -fix a cherry-pick mistake for bailing TDR handling.
>
>      -do affinity_group check according to the bad job's sched rather
>       than the default "1" so that there could be multiple affinity
>       groups being pre-defined in future.
>
> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 102 +++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  47 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  27 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   1 +
>   include/drm/gpu_scheduler.h                |   1 +
>   7 files changed, 173 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e247c3a2ec08..8632d7071292 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4188,6 +4188,37 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
>   	return false;
>   }
>   
> +bool amdgpu_affinity_group_has_only_or_null_working_ring(struct
> +amdgpu_device *adev, struct drm_sched_job *s_job) {
> +       int i;
> +       int working_ring_num = 0;
> +
> +	/*
> +	 * The job is considered as the real bad one
> +	 * if job's sched is not in affinity group
> +	 */
> +	if (s_job->sched.affinity_group == 0)
> +			return true;
> +
> +       for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> +               struct amdgpu_ring *ring = adev->rings[i];
> +
> +               if (!ring || !ring->sched.thread)
> +                       continue;
> +
> +               /* for non-empty affinity ring, increase working_ring_num */
> +               if (ring->sched.affinity_group == s_job->sched.affinity_group) {
> +                       if (!list_empty(&ring->sched.ring_mirror_list))
> +                               working_ring_num++;
> +               }
> +       }
> +
> +       if (working_ring_num > 1) {
> +               return false;
> +       }
> +       return true;
> +}
> +
>   /**
>    * amdgpu_device_should_recover_gpu - check if we should try GPU recovery
>    *
> @@ -4310,8 +4341,10 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   		amdgpu_fence_driver_force_completion(ring);
>   	}
>   
> -	if(job)
> -		drm_sched_increase_karma(&job->base);
> +	if (amdgpu_gpu_recovery != 2) {
> +		if (job)
> +			drm_sched_increase_karma(&job->base);
> +	}
>   
>   	/* Don't suspend on bare metal if we are not going to HW reset the ASIC */
>   	if (!amdgpu_sriov_vf(adev)) {
> @@ -4639,7 +4672,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	int i, r = 0;
>   	bool need_emergency_restart = false;
>   	bool audio_suspended = false;
> -
> +	int	tmp_vram_lost_counter;
>   	/*
>   	 * Special case: RAS triggered and full reset isn't supported
>   	 */
> @@ -4690,8 +4723,16 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   					job ? job->base.id : -1);
>   
>   		/* even we skipped this reset, still need to set the job to guilty */
> -		if (job)
> -			drm_sched_increase_karma(&job->base);
> +		if (job) {
> +			if (amdgpu_gpu_recovery == 2) {
> +				if (&job->base) {
> +					spin_lock(&job->base.sched->job_list_lock);
> +					list_add(&job->base.node, &job->base.sched->ring_mirror_list);
> +					spin_unlock(&job->base.sched->job_list_lock);
> +				}
> +			} else
> +				drm_sched_increase_karma(&job->base);
> +		}
>   		goto skip_recovery;
>   	}
>   
> @@ -4788,6 +4829,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		}
>   	}
>   
> +	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
>   	/* Actual ASIC resets if needed.*/
>   	/* TODO Implement XGMI hive reset logic for SRIOV */
>   	if (amdgpu_sriov_vf(adev)) {
> @@ -4804,18 +4846,64 @@ int amdgpu_device_gpu_recover(struct 
> amdgpu_device *adev,
>   
>   	/* Post ASIC reset for all devs .*/
>   	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
> +		int step = 1;
>   
> +		if (amdgpu_gpu_recovery == 2) {
> +			if (amdgpu_affinity_group_has_only_or_null_working_ring(adev,&job->base)
> +				|| tmp_vram_lost_counter < atomic_read(&adev->vram_lost_counter)) {
> +				DRM_INFO("Skip Stage0 Resubmit Stage\n");
> +				/* set guilty */
> +				drm_sched_increase_karma(&job->base);
> +				step = 1;
> +			} else {
> +				DRM_INFO("Do Stage0 Resubmit Stage\n");
> +				step = 0;
> +			}
> +		}
> +
> +retry_resubmit:
>   		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   			struct amdgpu_ring *ring = tmp_adev->rings[i];
> +			int ret = 0;
> +			struct drm_sched_job *s_bad_job = NULL;
>   
>   			if (!ring || !ring->sched.thread)
>   				continue;
>   
>   			/* No point to resubmit jobs if we didn't HW reset*/
> -			if (!tmp_adev->asic_reset_res && !job_signaled)
> +			if (!tmp_adev->asic_reset_res && !job_signaled) {
> +
>   				drm_sched_resubmit_jobs(&ring->sched);
>   
> -			drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
> +				if (amdgpu_gpu_recovery == 2 && step == 0) {
> +					ret = amdgpu_wait_resubmitted_jobs_completion(&ring->sched, ring->sched.timeout, &s_bad_job);
> +					if (ret == -1) {
> +						DRM_ERROR("Found the real bad job! ring:%s, job_id:%llx\n", ring->sched.name, s_bad_job->id);
> +						/* set guilty */
> +						drm_sched_increase_karma(s_bad_job);
> +
> +						/* do hw reset */
> +						if (amdgpu_sriov_vf(adev)) {
> +							amdgpu_virt_fini_data_exchange(adev);
> +							r = amdgpu_device_reset_sriov(adev, false);
> +							if (r)
> +								adev->asic_reset_res = r;
> +						} else {
> +							r  = amdgpu_do_asic_reset(hive, device_list_handle, &need_full_reset, false);
> +							if (r && r == -EAGAIN)
> +								goto retry;
> +						}
> +
> +						/* add reset counter so that the following resubmitted job could flush vmid */
> +						atomic_inc(&tmp_adev->gpu_reset_counter);
> +						step = 1;
> +						goto retry_resubmit;
> +					}
> +				}
> +			}
> +
> +			if (step == 1)
> +				drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
>   		}
>   
>   		if (!amdgpu_device_has_dc_support(tmp_adev) && !job_signaled) { 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 865f924772b0..9c3f4edb7532 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -509,7 +509,7 @@ module_param_named(compute_multipipe, amdgpu_compute_multipipe, int, 0444);
>    * DOC: gpu_recovery (int)
>    * Set to enable GPU recovery mechanism (1 = enable, 0 = disable). The default is -1 (auto, disabled except SRIOV).
>    */
> -MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 = 
> enable, 0 = disable, -1 = auto)");
> +MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (2 = 
> +advanced tdr mode, 1 = enable, 0 = disable, -1 = auto)");
>   module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 759b34799221..28cda321157a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -281,6 +281,53 @@ void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
>   	}
>   }
>   
> +int amdgpu_wait_resubmitted_jobs_completion(struct drm_gpu_scheduler 
> +*sched, long timeout, struct drm_sched_job **s_bad_job) {
> +	struct drm_sched_job *s_job, *tmp;
> +	int ret = 0;
> +
> +	list_for_each_entry_safe(s_job, tmp, &sched->ring_mirror_list, node) {
> +		struct drm_sched_fence *s_fence = s_job->s_fence;
> +
> +			if (s_fence->parent == NULL) { /* fail to get a hw fence */
> +				/* process a job */
> +				atomic_dec(&sched->num_jobs);
> +				dma_fence_get(&s_fence->finished);
> +				dma_fence_signal(&s_fence->finished);
> +				dma_fence_put(&s_fence->finished);
> +
> +				/* remove node from mirror_list and free the job */
> +				spin_lock(&sched->job_list_lock);
> +				list_del_init(&s_job->node);
> +				spin_unlock(&sched->job_list_lock);
> +				sched->ops->free_job(s_job);
> +				continue;
> +			}
> +
> +			ret = dma_fence_wait_timeout(s_fence->parent, false, timeout);
> +
> +			if (ret > 0) { /* succeed */
> +				/* process a job */
> +				atomic_dec(&sched->num_jobs);
> +				dma_fence_get(&s_fence->finished);
> +				dma_fence_signal(&s_fence->finished);
> +				dma_fence_put(&s_fence->finished);
> +
> +				/* remove node from mirror_list and free the job */
> +				spin_lock(&sched->job_list_lock);
> +				list_del_init(&s_job->node);
> +				spin_unlock(&sched->job_list_lock);
> +				sched->ops->free_job(s_job);
> +				continue;
> +			} else if (ret == 0) {
> +				*s_bad_job = s_job;
> +				return -1; /* timeout */
> +			}
> +	}
> +
> +	return 0;
> +}
> +
>   const struct drm_sched_backend_ops amdgpu_sched_ops = {
>   	.dependency = amdgpu_job_dependency,
>   	.run_job = amdgpu_job_run,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 81caac9b958a..25292f4699fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -76,5 +76,5 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
>   			     struct dma_fence **fence);
>   
>   void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler 
> *sched);
> -
> +int amdgpu_wait_resubmitted_jobs_completion(struct drm_gpu_scheduler 
> +*sched, long timeout, struct drm_sched_job **s_bad_job);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index b644c78475fd..cb50bfc80bc9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -35,6 +35,11 @@
>   #include "amdgpu.h"
>   #include "atom.h"
>   
> +static char *amdgpu_affinity_group[] = { "gfx", "comp"
> +};
> +
>   /*
>    * Rings
>    * Most engines on the GPU are fed via ring buffers.  Ring @@ -189,6
> +194,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct 
> +amdgpu_ring *ring,
>   		ring->adev = adev;
>   		ring->idx = adev->num_rings++;
>   		adev->rings[ring->idx] = ring;
> +		amdgpu_ring_set_affinity_group(ring);
>   		r = amdgpu_fence_driver_init_ring(ring, sched_hw_submission);
>   		if (r)
>   			return r;
> @@ -459,3 +465,24 @@ int amdgpu_ring_test_helper(struct amdgpu_ring *ring)
>   	ring->sched.ready = !r;
>   	return r;
>   }
> +
> +int amdgpu_ring_set_affinity_group(struct amdgpu_ring *ring) {
> +       struct amdgpu_device *adev = ring->adev;
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(amdgpu_affinity_group); i++) {
> +               char *temp_name = amdgpu_affinity_group[i];
> +
> +               /* set ring's affinity_group bit if find it in affinity_group list */
> +               if (strncmp(ring->name, temp_name, strlen(temp_name)) == 0) {
> +                       DRM_DEV_INFO(adev->dev, "set ring:%s in affinity_group\n",
> +                             ring->name);
> +                       ring->sched.affinity_group = 1;
> +                       return 0;
> +               }
> +       }
> +
> +       ring->sched.affinity_group = 0;
> +       return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 56acec1075ac..6b0d217e6f5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -350,4 +350,5 @@ int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>   			     struct amdgpu_ring *ring);
>   void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring);
>   
> +int amdgpu_ring_set_affinity_group(struct amdgpu_ring *ring);
>   #endif
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h 
> index 1c815e0a14ed..589cbaea35dc 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -301,6 +301,7 @@ struct drm_gpu_scheduler {
>   	atomic_t                        _score;
>   	bool				ready;
>   	bool				free_guilty;
> +	int				affinity_group;
>   };
>   
>   int drm_sched_init(struct drm_gpu_scheduler *sched,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
