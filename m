Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9886CC48BDF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 10:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6610A613DB
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 10:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6610A613DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 203DB89B18;
	Tue, 15 Jun 2021 10:38:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECE0089B18
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 10:38:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cm+fU9sjJtQXH6oYqwbK1wyBPvLt2P9VJJOzBe+bMvBuRTWMSn+KgWEuNxfbiZRSwU8Ks/glsvsLwREIL8QHWXHEs/7+qusxh5XWIE2DEQqx7UmPaBv/DuE1sD1Ci1i090ml+9zp01ZfC4gY61sAcw5vtNl2wuxWDB2tpjP6eQVBDq2za1x6hSuCPulAsR7ujHWRr3TXMXHqVC1j9XeqvaWmcv7sP1V3GtsOqtTY8h2LIEuwheDwFlBRRqOXlQqxCa2a5ddYyVYD2VgucgUGdessAt5hHsW5NNWwsI3AU7yPw3GJjsp5yzt1a4LGkp8TG8Mmz8abg+mrNYugGFFzHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V35o/2iHRLFXj9F4XogK6w1yKSv+z3pz6Cj6pg9he4Q=;
 b=RVEtdfJCRK253wYCV17qialTyn85x/0fAa/hJJaLo2mAUv4VBO5gD20Hw+mTDFbA+r8a2bl3vN+VK8eugJ8AAqUJ9c1fHIKz5j+i0+NzYgQXHYGiFD+33HVXWM9bU5IxbiZ89L0fa+yM4DZvq7k8t3/YkoGhydIwn6OQnYKm0ciegt1Diwet9jmZFEiGx/kXHuoqlass+oLD1Jk315FNLA1GeSaVr1mT/rzIzrArOFSoXOPjNmEQdA8Q8qpAAcb3efeLxVNV6h+dGoKjL3Wxxi58Lx+r7IJ4m8XxVW3h79r8mIPj6PMxuMihzY6YfGMGtJZoWOIT/ayNbIb7U/5ELg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V35o/2iHRLFXj9F4XogK6w1yKSv+z3pz6Cj6pg9he4Q=;
 b=VFUuXBHouWcHUmaL+4D5q9rLVvzDn0IJSBR7F2NQOovKa+KafZ9hJDTpeg+W6l17RyA1INwnW2M8sYQHNQnxY0VqDJM9zJXsC0FqbDJO5Bgk7dWY2vSIH+DmS0eqWGMc/AFY/zxaDVkoxSzpFj9VjUUESWZRi7r7UkL6/nyzQKw=
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM6PR12MB2890.namprd12.prod.outlook.com (2603:10b6:5:15e::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.23; Tue, 15 Jun 2021 10:38:03 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::1d06:dcde:55f9:3eb7]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::1d06:dcde:55f9:3eb7%7]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 10:38:03 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdkfd: remove unused variable
Thread-Topic: [PATCH 1/1] drm/amdkfd: remove unused variable
Thread-Index: AQHXYdHo/VSYFqscpUGwGKGQcdNBgqsU4K6AgAAAZwA=
Date: Tue, 15 Jun 2021 10:38:03 +0000
Message-ID: <DM5PR12MB468091114BF01CACCB90CD2785309@DM5PR12MB4680.namprd12.prod.outlook.com>
References: <20210615103325.28587-1-nirmoy.das@amd.com>
 <0037a67f-d0d8-16e7-b174-721249600aa0@amd.com>
In-Reply-To: <0037a67f-d0d8-16e7-b174-721249600aa0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=e8cc018e-cd61-4281-a0eb-f238b3213876;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-15T10:36:55Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68e8732e-2c33-4506-7764-08d92fe9a797
x-ms-traffictypediagnostic: DM6PR12MB2890:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB289098237B1037F47BEE9E9B85309@DM6PR12MB2890.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iJb5toj5jsa+eLMQe0G4gyVlRGySXks7drbjECBMJuhIVdVGohLcAe7y1N8P1tenO4IRf6xShG3YxygAXPC3Gt4knEQuC0pWuiQtDqzOv0JpNzSCEVmvtgjY0QpVVgEfBZNrMFArADv5n9ubvUeYD49kGEzxaF5WPwFDRLUEJNsH12SihUxt3vF9kU4FJOTLnnzRhu/OYa3K5LLwjJpLcrvho6skjdWxffpvqQ5CWZU+EgAtQ1R6mawkrYZm62fVGJPKFWYzZvQjAJTE6Y6VIRxRzHRlgPKPdP9UeGAcBV7OovJq3yukA+EZbkd7ukTxT2cJbVgMyQnz4bVwt+2bWPbqVmBRTjYKgUU2hjWPHcCKmVTi/yvpnOUxRhETKP9OR0nURV1e4+2/7J3hvP6+DdbosUYr62huACFcjBuD6mNBkNMjzG/2Jjr/V9LopUQrVlzxgkhqDF/+fQLQnQbyN7Aq35X2AqtXydqbZq3CKuB0wAXz0HgLsNeQppk70q+ThZ3hsQfhFBiIdbrB2wUyDt+XJGRnAR4yrW8adujEut7Hk6q6Ie7LrEqghbUXuUtdk8HWb2Lyyawghw59wEANQLSfvyWpZ3vNighdbTHDdMI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(5660300002)(2906002)(186003)(316002)(33656002)(86362001)(8676002)(55016002)(71200400001)(6506007)(110136005)(53546011)(26005)(83380400001)(7696005)(9686003)(122000001)(4326008)(76116006)(66556008)(52536014)(38100700002)(64756008)(66946007)(66476007)(66446008)(8936002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVVmU0FTNG5JSFg1UENLTXR3ZFc2NDlpS213TUtJdWFLMjNERFVzSHNpSEFR?=
 =?utf-8?B?ZG1Tc3lYNXg2bE1MQTRSZlNmMWpVTXZVRWc4RzhYTGRrRSttNHlrdHFpUll1?=
 =?utf-8?B?NzRmb2ZQU3VMS1duL28wQzJSWUJIb25ERDNLWHNJZ0hWMnJBWXJ2cm1vRmx1?=
 =?utf-8?B?U0tVSkVKb2hwdkF0ZmRaaTFWRGJ5aGpoM1pNdHpJeFNSUWpDTzRtYUkvUG0w?=
 =?utf-8?B?U2pFM0hSYTMycjMrK29uUlprTWdUejRQaEhidGxkUW1YczZ5Rnl4S2piQVV5?=
 =?utf-8?B?dFF5VEloZDRPM2VXZjYvdVMwZGJxbS9Bb05ITGlNTi9Pajc1dUg0aHhIenpG?=
 =?utf-8?B?aG5oU2dTUS9uVXR3OFRGQmVmbkJTOGNPQkJsdlR6L1lIOW1LKytJZG1ZajdT?=
 =?utf-8?B?cWZxNXlCL25xeDJhRXFjZTVtSTgrbGdzZHhjTG5Nb0QxNkhPQ2hudi85NlBa?=
 =?utf-8?B?bzRUeGdwWEdlOThKWDltQVFVMTNhUTAyUkt2STZBVVI5NC9tb0gvTG41VnB5?=
 =?utf-8?B?bGJVbUk0MTdldklqVkZaUFNUL0JZY3dRREJ4WHdPOUxpdDY1dEgvQTNqTFFT?=
 =?utf-8?B?aEI5RWoyTk9saFhhTTNsVkhoSTZoL2pON3BTOUpuMGlyUzFXbExuaXVxNDVD?=
 =?utf-8?B?WEJHaEpaWFVIY3k5b1BFL3c5L000Wlk0Qmk3YmxlcURoYWZZK3hrWUtSbHBH?=
 =?utf-8?B?TmZGQS9TU09wd2ZEUXl6NU5ieHVlSGl5VGNPSGpFSkFDNlFsTWtnL1pvZ3N6?=
 =?utf-8?B?S3N2NFNoYkd3UnM1MjgzQXZWVlgxaTBrWnJHSnp2eTBUWU9pMncvL1RBbDg4?=
 =?utf-8?B?Z0JxRlFWTENqeTZVSEJRZXJwVGd6eXRKSTF2UHJabGh1OEo3TmFnMDRsWmg1?=
 =?utf-8?B?Z1hWOGRZWEV6NWNRbnZGQVFsQ0U4eHJlZmhxdkh0cDJxcGtqaUlLUnBGUUlo?=
 =?utf-8?B?Yk9JR2hoTWRxTW1uZkZBWVpWWXFGU0hmc1JHNUEyU3gySEZvUkY1RTFDcmlW?=
 =?utf-8?B?T1Y4cmtGMkZIeU0ycjVkQktZeDN1RklHaTlvTzlWcC80R3RKZUNhOGF2eEZ1?=
 =?utf-8?B?b0plc1NleGlkc0dTOWhGVFg1dXlwaFlNVTI4REd2eHQwOXAzTmhiemlCVWFw?=
 =?utf-8?B?ckI5SmxXd3RyTFUxc2xVSGZBY1oyNUNLeEJRdEVMUW5CZktMT2FmWjk0ZnRk?=
 =?utf-8?B?UkE5S2VvZFQ5UlUyUUNhL2llLzRWM3dIODNwY1VaTGtYQk1XUjRkZkE1V3lF?=
 =?utf-8?B?U28zMGY2QW5JMGt4Yy9ZTnMwNDZwVU5CdXp4VUhNNGVxMkovVS9ONWc4ajg2?=
 =?utf-8?B?VWF0R3pNYTJseHRpbkMxNEZKa1JLSm1McjRBVlFXNThRaFYwRTF4OFBSYWx4?=
 =?utf-8?B?VVl0b0tEM0owNzZXdVpmZVZGZkRLcDVxWXBWT2lmUFNXUjEwVVY3anNvYWxT?=
 =?utf-8?B?citNcDNDMTBOLzNxTStwcHhKb2xvODAxd09xVFNCTkw0T1B2L0hCcXNqa1hU?=
 =?utf-8?B?VGExVzdzTGpMeGhMT1lqZnVWU0kwbnh0bXkyRHR0MGZjdC93NlM0NDA3UU5Q?=
 =?utf-8?B?Y1gxTEQvdWJxZGF5Nzdjd0MrdjJPWGFVcnlPTjFDVFMxT2pjK01STmZNcVF3?=
 =?utf-8?B?R2dpM3V6Z3p1cjR0ZGcvUU5nVVFGL1dmdlNTTHNpQ1I2NHlJT2RTRkVqaG1v?=
 =?utf-8?B?U09hMlpVRjUyekpQZjYrdVNDY3NOYTVvNzFyQ1dWbGRFQUs1aDMrek1aT1pO?=
 =?utf-8?Q?v4xvXedrRsq3/p+LBf+WWNsv24+jJavM5BXWSp4?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e8732e-2c33-4506-7764-08d92fe9a797
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 10:38:03.4893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xT18zp8HwlUHLfXZWzMFACfvFWcfqHiJ/EoGiPIxYmq7uWINOqviZOANYbLUGwXm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2890
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Thanks for the catch.
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> -----Original Message-----
> From: Das, Nirmoy <Nirmoy.Das@amd.com>
> Sent: Tuesday, June 15, 2021 6:35 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>
> Subject: Re: [PATCH 1/1] drm/amdkfd: remove unused variable
>
>
> On 6/15/2021 12:33 PM, Nirmoy Das wrote:
> > Remove it.
> >
> > CC: jonathan.kim@amd.com
> > CC: felix.kuehling@amd.com
> > Fixes: d7b132507384c("drm/amdkfd: fix circular locking on get_wave_state")
> > Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > index e6366b408420..539212039876 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > @@ -997,7 +997,7 @@ static int start_nocpsch(struct
> device_queue_manager *dqm)
> >   {
> >     pr_info("SW scheduler is used");
> >     init_interrupts(dqm);
> > -
> > +
> Please ignore this extra space. I will push without it once I get a r-b.
> >     if (dqm->dev->device_info->asic_family == CHIP_HAWAII)
> >             return pm_init(&dqm->packets, dqm);
> >     dqm->sched_running = true;
> > @@ -1674,7 +1674,6 @@ static int get_wave_state(struct
> device_queue_manager *dqm,
> >                       u32 *save_area_used_size)
> >   {
> >     struct mqd_manager *mqd_mgr;
> > -   int r;
> >
> >     dqm_lock(dqm);
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
