Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF007C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 08:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6708510EE69;
	Tue, 30 Jan 2024 08:33:43 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E16410EE69
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 08:33:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFQ+XQGuNBqjvDf/gIgzZhmwCA34sJP/XuWTcUnLdWWH8+yH3zvZGAn44phM7QtHxB08m9zyXdMmgTcKg9AVoDAZfz+re5F//5xtYOBtLbFNwRx3PoV68MLnY6VoMWlVQN17nyQ+7A7Pj2dXUr6W32T1De/Zhp0Pm7ECXYdwoiLtGACDrzFwYomnae8l7JhOSuyvMiDXEf8XMuMs3yjmqzujSrZLZ79XI8oZUGq8iJUukp+usRJ/XXUBgJyQMsLQIZLXTlSFfq6d/WDsYNJB3YpAYuc8ens3GnjDsFio2Xbte5JI4n1L4PRW1fhr3dvco7YV0yG8hFJ8DGUuRDmcvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q71JH/6s91MfgrCvPruyoRod7gWB606GGZIBX0Usn5g=;
 b=XjSOPL83NGlkPyyaLmBWu/aX4nB40ckZ0/W5vdwTv/t/NRUyJ4B5A8mCJftXLxYMAPBJb5atxCp19Us6ny2t36DbjDeljEw9m94JMzAxL9t7KFP97Br+NjtQrOvzA5FTsijakfA2k5APMqxqLsueMhRjWKHELL+Ujeqd34AHcfSlr3pZkGyJfr8uGzLC3ziBT2Rm0WN2BWCNqHfh4rDSqAB0LQBRffRQFWmce7vRMWjZXuBc/T475ZqUoBSREHTg5curpj9o6Yxqqov3hlyIlM/9+DcbFsJGadoSXBQUfJ7ebSKtFV4Si4Xt+nmvMuiCutBnBTsGn6vlUrqxh03BEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q71JH/6s91MfgrCvPruyoRod7gWB606GGZIBX0Usn5g=;
 b=rE4ULnF2LvnIWOlcRVmhDXEjHDdhhoGbZltDSQ1TcQXsRr6N/ZC25NRx0r7VTDDLeJ7BxpI5BRaYI9LYXNqupEYndDuXcFp97C50LZxL5L8II1644CWITjb6bAgswPlP00FqTKnkvT8M68Dqd55KBCNtH7OwHqKGSfBeS0mjKag=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 08:33:39 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::2481:719a:5a7a:d6ad]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::2481:719a:5a7a:d6ad%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 08:33:39 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove imu start dependency on amdgpu_dpm.
Thread-Topic: [PATCH] drm/amdgpu: remove imu start dependency on amdgpu_dpm.
Thread-Index: AQHaS3tIKxeEQBDmr06X8rfRPy+TVLDyFv6w
Date: Tue, 30 Jan 2024 08:33:39 +0000
Message-ID: <MW6PR12MB8898D2D6FF5FDFC85B72C744FB7D2@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20240120083220.1804937-1-yifan1.zhang@amd.com>
In-Reply-To: <20240120083220.1804937-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=af8364a8-7bb3-4920-b98d-8df8b14f6d14;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-30T08:33:35Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|LV2PR12MB5967:EE_
x-ms-office365-filtering-correlation-id: a1bb1d45-b50d-42ec-6163-08dc216e28f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rbBjXsdeNo5N8oe7aH2D6zdOUHlUfYrdtjtkbT1zRyYJx+PaFPoq1aQJ835n7Rhp2UvM6fv1vOMeFV752djgP269vDlmRC7GZ8U5znxXbx1QVczGkX0g4Mo6nBzh5MInJnlGAdCPmyOsNtdTqEvjMeuf7QHp3jIAIBEGDJgOEiBl9WYKkaFBC7ffQAvTRbQtwSvC/Hg4mG0xHSog092A/GhvSrqVkaDFpj1w1ky0K3x9cEd2c2qBWmilvMMApdrjxytAOOQ1+OaYN6324ni7PgP/ugI2DNck1T6vGy/2Cb3HhMzR/cE7I87PeBXe+GmNtRP1gX6YOcbBu2YTSwIb/A+S3S7G0tdXUgugtuCFvtnSZ1MKz1psogj1ak8wC+UCqsBGCArRmuVtp8On7whT6nVYnCIGudF31yZTu8Ogw0c8U9v7SVxhJaxzC4j7G/V6Jsy54Coz0t5CcqjD9sjvRZwjJ+At0dtrPKi1bdkZjoWiLjUywOSv4aNy5DL0gjW6bk0/uwDjzOPxyvPYD5WSNPT2vfsTwAwXaO2Ubw6v5Yx1Wl2b11KB0dK+DnRaqzpqxBv8DawW6rpGO9fFNyrycS7T8jwQ/tBMHSz7XaTJZmnmp47I+epQqgk9vGdE4d+P
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(316002)(52536014)(8936002)(4326008)(76116006)(2906002)(5660300002)(66946007)(33656002)(110136005)(8676002)(86362001)(66446008)(64756008)(54906003)(38070700009)(66476007)(38100700002)(9686003)(122000001)(66556008)(7696005)(6506007)(71200400001)(478600001)(83380400001)(41300700001)(55016003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1qawKmVw928+UDaaKhB+Lx5BTxUKs6nefu6fZgDM2SqyAVgZPfEXHFnv3Hga?=
 =?us-ascii?Q?XBh4ggi2RxDaCAMU6UjhcvwzTl/ZvIQGIl2a0TaS0KNSEuNsz6z1zzENDSrY?=
 =?us-ascii?Q?Za7bpx/HvYXYJtYuXOuqkldMwu9QdIUTT8UNm00nsDOmgidV2brwQtrYxHbP?=
 =?us-ascii?Q?BSMPTJyqeBspdk07Tr/yD2/E9Lx4QtKj1orMzhXQP+X5M7L+VZE3/PWcp32X?=
 =?us-ascii?Q?ViYRpuea/ILTewa1q0Lu8oTuJWFi8P1des4s2PX6OZutR/SFq4RoCNlnm+Ta?=
 =?us-ascii?Q?fbKoOdupiwFgoKdO9hnlLcdi0WyKve7766jAOiLP1nHVyPcPU1UzX1gDe9HN?=
 =?us-ascii?Q?cjUsXhy5O/jPwec6X0vhrxFhoYY/5vkkxt4/MVqJuLntPyl5oG6Sfr+5kq16?=
 =?us-ascii?Q?Vto0p45DKoSb/M8xL74jIflMy/oZb0hXaxDkl+7wZ/7OpOshZeEe5E3mhu4Y?=
 =?us-ascii?Q?bBpyVkG10mgUJomp+vun1C7HNr1jrxmlu+vHK8gN/f2vZmzRA70AZFS7eJsF?=
 =?us-ascii?Q?8UyatuCyszBAtD/TCvHSZOzcpJqRDHhxSzsoO+eggadccUajZK+TCy0w9QAf?=
 =?us-ascii?Q?clT9QBtnAVZ1R2qJsK/JJv8tI7vlVvXRvpWASrAyV7e1j3HtVF3kpOe1r/L1?=
 =?us-ascii?Q?EhROcl2pfbQOakmmpJRpNCQuXKoOz1uc1pegddFu0Nom+Ni3JYOb/OnhX9I2?=
 =?us-ascii?Q?6zdjG+6onRSgSTDbhIMjmboW4V1dgNbdpAwKuf1qEgPitz2sSZUTRN4DfkHj?=
 =?us-ascii?Q?LnSs4BAKERD6Fw7/HOTvAOQ/BQ6/KvpPYiaVeKhC81VhJQcYfCkrZO3vB99B?=
 =?us-ascii?Q?Smk8NrKJb97eAxQjs3PhPWWqhjWMKblifC5jgiUohNjHydqvchdv+gL4pJlC?=
 =?us-ascii?Q?3xknS2ivwwV7gF5rSV3UI0QlA4jVhIwmFtHe2Oxf/xiISuyfdLBbfjib6x16?=
 =?us-ascii?Q?SRVcyNRJR3/tYsor4FxmWh88xxomRloO5C0U/fSwqPGappV5jNTAEn816E2f?=
 =?us-ascii?Q?JpWUP9Erq+anTuJUV5HOzhoK/OhMsU67Q/FyI6gSG9UsNtjgIspHHHNjJ+5F?=
 =?us-ascii?Q?bEf70OMSGMyNDkC1TT/7WGyKVRIyTRBTVRhiOZFC7h/d3aJSooLyZXvnYYc6?=
 =?us-ascii?Q?xO+NDwrq5GAnLakXIF2gmSi9qnWl0qeLG1HqMRM8zcaCWtJ+DMwN3MBUq0TU?=
 =?us-ascii?Q?ebAZJGOLdqcakE7SU3ssdtfIclRhYfZxWCFLE2KQMPJqSgi8Q0ktsitonh7t?=
 =?us-ascii?Q?eu95oAPkGM49LVV9j/09lDjHjwQiCxfI/g2wqNDvLGE2SlLU5xX2YoXi2YbN?=
 =?us-ascii?Q?rMKElUNwMDcpJf/S7rirHEygpjgw0RHtHULY9kqsG/1b1p8k0tbnv3v3UqPI?=
 =?us-ascii?Q?yUGacj5g5tQEyfTUnWgm+9mnHPOPzDbubHBLN2oHhYlV47BXI3G6LyLfneXR?=
 =?us-ascii?Q?sFhCmqdWq8bjsmTF0bAe90fwrH5Se09RZOOb+UazIHof8L4nMTyCHFDfB97e?=
 =?us-ascii?Q?/AzMwRTbOLHFttpQreiivclpKSjb0pg73AQc00P3A5KzdnSUun43d8ybuXpO?=
 =?us-ascii?Q?kYF731vbaq6Co2QZNic=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bb1d45-b50d-42ec-6163-08dc216e28f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 08:33:39.6441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1t0y3VuyjxST6JRTxOrynABwoOUDZMiBXRwHHdhxsY/Ij9gPWxohdRAROuAyVnN6GgfJ56Eg2jeYz0dL1t8vng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Ma,
 Li" <Li.Ma@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Lang Yu <lang.yu@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan Z=
hang
>Sent: Saturday, January 20, 2024 4:32 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Tim
><Tim.Huang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Ma, Li
><Li.Ma@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
>Subject: [PATCH] drm/amdgpu: remove imu start dependency on amdgpu_dpm.
>
>IMU starts anyway when dpm is disabled in backdoor loading.
>
>Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>index a2d3cced8f19..c5b1d036c95d 100644
>--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>@@ -4324,7 +4324,7 @@ static int gfx_v11_0_hw_init(void *handle)
>                       return r;
>       } else {
>               if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) =
{
>-                      if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
>+                      if (adev->gfx.imu.funcs) {
>                               if (adev->gfx.imu.funcs->load_microcode)
>                                       adev->gfx.imu.funcs-
>>load_microcode(adev);
>                               if (adev->gfx.imu.funcs->setup_imu)
>--
>2.37.3

