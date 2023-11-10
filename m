Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CF5C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 21:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AD9A10E2A3;
	Fri, 10 Nov 2023 21:25:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B00510E2A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 21:25:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFMImAB8mT51s86BSnMErJyInrN1aF6WGOc3DD3eW+NCpI+trr6ZRk+AkNIBsDzA2Z/fRusBvVRaXuVEbTiFNlhWlAOezsP4uPP600+M8oRBDEhgVBTPy4X2DbaK2nsM+2AGvyk7fdLoWKwyL+3iufbaWGp61YqIS+KYd9nsDVltQKZOrzxqwJEhhicIPEdMFSkfQf3UmVIvuPQWHwX+GbaZrRUdX00beQTIxrbZj4Me4qBj7joJEvNE+NAX8UiNI5TFWE9/agWqnV9zfqAFm6s8b5e8kJU4j9a/wLmbOhMDrrW56+ys9p7Bm5261JsSwsahWiTlRAeWsr1mC1XiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUuKaCTrRgX/C8HbmoW1dXPZLF9dMA2GoFzjUQBpgzg=;
 b=KP/jkFq+IGn1sbJAyXOrtGJ7GYSmP8PwYKxhQFA6PS/kfhncKuDYxUcBYaiqy6+s5BC5EgWnR6VZO5BpG/GNNCunxoKDfAAD+9Ymuc2+fH68Q6djHTrVgmQ+HPWSmx7pRYpfxhTCOc0ni3+wWPhEpFufx793Dd8M+6EtTL2wlyccZgoXCBNZ58H3sVOhix2Fzb5jplxzgRVQbBcRVC31jriuwW0l5UO1JXfUYaDLiIf1q1L/CBCZh65gDOdaRkakliMNQxMW0AnZmuzXStLj/cDkNgWYl2tdqu9eL4fySdxIMYZymV/l9VIZkRpd9oOeSyCt28vYgagp53jJcXE43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUuKaCTrRgX/C8HbmoW1dXPZLF9dMA2GoFzjUQBpgzg=;
 b=FwwVY26KqGYGfjzKOFok2WiDzYfF9ul9asDpLo/+PBDWyU+wWcipUNsAv2aO7u542ZHs2SBb80q8hD2SgbXLZQ/swkMjwjFrKU/wo/x2vuf9K2VAExdffjjlPYEB0Y0uvvZyU0KsqbQGG05lP+4QOprG4kSFSZLGgq1XFsEinAQ=
Received: from MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12)
 by MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 21:25:18 +0000
Received: from MW5PR12MB5600.namprd12.prod.outlook.com
 ([fe80::f786:72d4:735c:aa84]) by MW5PR12MB5600.namprd12.prod.outlook.com
 ([fe80::f786:72d4:735c:aa84%6]) with mapi id 15.20.6977.019; Fri, 10 Nov 2023
 21:25:18 +0000
From: "Dhume, Samir" <Samir.Dhume@amd.com>
To: "Lu, Victor Cheng Chi (Victor)" <VictorChengChi.Lu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Do not program VF copy regs in mmhub v1.8
 under SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Do not program VF copy regs in mmhub v1.8
 under SRIOV
Thread-Index: AQHaEbEE4cIyiX9G4kapiGutbUiCurB0FAnw
Date: Fri, 10 Nov 2023 21:25:18 +0000
Message-ID: <MW5PR12MB5600A804F2DC648D9BD863B5E6AEA@MW5PR12MB5600.namprd12.prod.outlook.com>
References: <20231107193034.2345-1-victorchengchi.lu@amd.com>
In-Reply-To: <20231107193034.2345-1-victorchengchi.lu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a947ed2a-78fd-4bac-abc4-7b83982f106f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-10T21:20:20Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5600:EE_|MN2PR12MB4317:EE_
x-ms-office365-filtering-correlation-id: 26cc3079-5627-4dc3-2d2d-08dbe23389a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OEtnvRRNW/CarwVPntv1Mxv8QgLkz5GEM8qc/ae3UzF2eQmjMKwL9gLVeHdjLT2m9nNG38decLN5XK8ulJsWe7270izDR6N9zwWEkusqjTtmdMiqvrjEPzSgrTPpFampdFbJNZc3kiuQxASGnsZcFMpc8v26z26VMfDZw0na9Y4O+BY7t1Q+l0HxFCRBplcBistQRSWvbm/w2tT3itOfMWhUPlucr2G5HqAL4hXbe33/I9sZDr6rRzb+FdhJ7TjMbas1iWAv999aGZCoia06VZGx24tHojDrypslOeqA4OdlaA0rXdbUef0bNudT6cY5cTdRZYEkCgxbQMY8iT8O6VcWaagz8yRaHaurxf2KWDrq0Q3279a+f6A/w4+LwFWrY0ZDQdfn1uPTkPtvsbUgjB3X0Ob27uo5DtTSfUKNMcfgcHTWCV6mzLUwxROEwuRYIdFCGQ5lVeGmgoRO0VfNpLtI/Ab1pc6ff4vQonckPFbcroD7irKcrIQZvt/xXzHacugbWCU/HaaVrfl4wwDsOpDL23S6yJVOEM/CNsDXY1FfzShsDjIYP8TZu3/DOaC8/v8VD1Kigr3chO37D2oIav+Lu4VTNl4HvLoS6TCCyt5XaK2oTmqWXuJIT3M+GHvz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5600.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(83380400001)(9686003)(55016003)(26005)(71200400001)(53546011)(478600001)(316002)(2906002)(64756008)(66946007)(76116006)(66556008)(66446008)(38100700002)(66476007)(110136005)(5660300002)(122000001)(4326008)(41300700001)(8936002)(8676002)(52536014)(33656002)(86362001)(38070700009)(6506007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f8FQegkArC7rtpcm48izWSttoqCFJMJD3QO3MN7BYQDEvfY38b432tdd5nMK?=
 =?us-ascii?Q?xxpyD6y+/AJQHSWbx4y2y+kS9RVEllJ+/fUtG2q2UO7dSYn6Bmd2EGvGE9su?=
 =?us-ascii?Q?OXMqpwbr+BuFUKJ6wZbv1DrLUDzr+UNsQA6GKyIiNUhJ8euqD9YaWnmYHUfM?=
 =?us-ascii?Q?kqiQXBjIuIaiCsATBisdK5W/3eLnZVznitXArXqeFtoTngBktPIHJmLV61Co?=
 =?us-ascii?Q?CmqRWFBvxQ7jygc2O/HYzUoriXB0HBUmFEjHR02vCW2pH8VCGtV9UVDy9yHy?=
 =?us-ascii?Q?rB4bDNGsgAmTLFOv07bGVN5BOeY6oucw229y7ZSzarTUZd2W55vDBL/S6u5f?=
 =?us-ascii?Q?Nv51DHobslnfEcRSXRbXX2iO6+g5iS8WPmAyeRclM7JFuIYQ9WStgv3XsYVG?=
 =?us-ascii?Q?sv7zGyutNHxwD8B2W8R7MzD3E1Gpxa6+RKqHBahtGu6B3qu5eRgRvVHj4JHZ?=
 =?us-ascii?Q?6n4qsNftonrr8JAbfEVN7oHPCJiPCghcWTerBJjgvN+lgSslfOUrjXD56CQC?=
 =?us-ascii?Q?Pv3A3In8PD2JCRP75tDaz/mqy0ZA4Y98hbCKGoBcIuYiVncRnUxZc7D6bRDH?=
 =?us-ascii?Q?bBvBE+7u7jn8d8WPhGZEoDs4r/bqBlhseVX3GgBxvEFTfgRK7IUv1UP2Xwxl?=
 =?us-ascii?Q?QNNHr6/2IgUBiGbOq5vrTHLlVyU2vi/PXGfYaTbG+8dFac2/S3f4dr8Acjij?=
 =?us-ascii?Q?UY0NoOvDGvlHmVeysyc3eXu8JoNc9gxkUEHlEzeo555HP4PpjQ3VDN2Kakux?=
 =?us-ascii?Q?63N/YgI+/3ss4IhVziVvUyXVerbQKpRzCclv0paaegdM8U3dYuOUZaK1ZiWP?=
 =?us-ascii?Q?25q8HpHXRx8F/g3rCRrNkIGJLWNr4KQLifqslgPAAsTMAzuIEK6Ppe+NK2t2?=
 =?us-ascii?Q?HOexJG+z+CmcOkz1zp1tO0qm9OOHrI7WYTIwygqmPYa6W3TZoxuLemvm6vVH?=
 =?us-ascii?Q?PoaCrjjDbd/AyPzzmPehstwod7Y4Tn02WP0migoFRV67bFRwMANuOrduHk3D?=
 =?us-ascii?Q?omahy6EMsKrw4oAMerSQAENrL9xXuysYWDlByt/uKIMxNYVcbvc+Lp/t+BQK?=
 =?us-ascii?Q?lti4Bb87qfzPj1Gl6ocWJoAMGcIY3eTQT/KK7AdH4OXjXv0laaakoCwpUVNs?=
 =?us-ascii?Q?C5GX0liHOTxseVdB01DDSD5t2No0P6zUH5I/lP4ZWmOaux1IL3I5SuR6jAqV?=
 =?us-ascii?Q?ZOw4hRDa5KJiIZBlIEdyYUY3H8CCoP0ubf0folwky9KWnNXY8yOvTxC9F2V4?=
 =?us-ascii?Q?YyYYssIEugfM5TgLAe5Eh/ZHvHUEIwE1e4OsxIsdr8JSk1jIC37IGpL8gAh2?=
 =?us-ascii?Q?FalqThLJy4R4lPVJbbfEUN3c34qvHX1SCboW7XEQEImbhCxE4xlU/WAO1g6V?=
 =?us-ascii?Q?07peKXg7UXqFQtyIBgVh5xIrPR32YBWXfa4WlDRzSwryXrRlcQ1OspGC14hR?=
 =?us-ascii?Q?toC/rWy5EMcWJs2oz4GSIGm+Ky+bgZfkMvkiKKFyPVVBfvBL/hRcrswVmhaM?=
 =?us-ascii?Q?MtxMJD8mWgTGp0gj3W0kXWGXgE9X9VkggCi86NK5EJ04s+VgCZyTTwEiqCpU?=
 =?us-ascii?Q?wmgkOxvA59SNXZXOYuk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cc3079-5627-4dc3-2d2d-08dbe23389a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 21:25:18.3158 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6CnXlcg65WvTdhXIYYhoONXUXpbXfSP6sRrzDDM/rNtUPqQ9r1z3lo8E7uJUJYpu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317
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
Cc: "Lu, Victor Cheng Chi \(Victor\)" <VictorChengChi.Lu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

It makes more sense to put the check for sriov in the beginning of the func=
tion rather than inside the for-loop.

Thanks,
Samir

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Victor L=
u
Sent: Tuesday, November 7, 2023 2:31 PM
To: amd-gfx@lists.freedesktop.org
Cc: Dhume, Samir <Samir.Dhume@amd.com>; Lu, Victor Cheng Chi (Victor) <Vict=
orChengChi.Lu@amd.com>
Subject: [PATCH] drm/amdgpu: Do not program VF copy regs in mmhub v1.8 unde=
r SRIOV

MC_VM_AGP_* registers should not be programmed by guest driver.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_8.c
index ea142611be1c..125917c3cba1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -132,6 +132,9 @@ static void mmhub_v1_8_init_system_aperture_regs(struct=
 amdgpu_device *adev)

        inst_mask =3D adev->aid_mask;
        for_each_inst(i, inst_mask) {
+               if (amdgpu_sriov_vf(adev))
+                       return;
+
                /* Program the AGP BAR */
                WREG32_SOC15(MMHUB, i, regMC_VM_AGP_BASE, 0);
                WREG32_SOC15(MMHUB, i, regMC_VM_AGP_BOT, @@ -139,9 +142,6 @=
@ static void mmhub_v1_8_init_system_aperture_regs(struct amdgpu_device *ad=
ev)
                WREG32_SOC15(MMHUB, i, regMC_VM_AGP_TOP,
                             adev->gmc.agp_end >> 24);

-               if (amdgpu_sriov_vf(adev))
-                       return;
-
                /* Program the system aperture low logical page number. */
                WREG32_SOC15(MMHUB, i, regMC_VM_SYSTEM_APERTURE_LOW_ADDR,
                        min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18)=
;
--
2.34.1

