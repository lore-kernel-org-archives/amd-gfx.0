Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0F6E81DE9
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 12:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE71C10E1F7;
	Fri,  6 Oct 2023 12:57:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3EC710E1F7
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 12:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivTeVsxK4BoB+R9Jbyi7RLvYLvtaO8uncQeN+Ef5+OIMQKx6Y85ONZensFbaoxv+cZzMua+D0vdPtxIf12dyKCoecYPuCXc6A+Az9JkO1nFnYS+7f9Tl+vgsTjc/t7a9nB6Zu6kD/JnmLSmiM+D4mdLZfo4zzH/zdmCZ1N99pyXoVRkqKgMmIYaqGW7muVekCDsM/QAISdsSUdNXcTih5otWYhUnC324qoQxM1Bt8uc4a99CNZzIrDkPrIkEq/dn95ZATTOVMF7r10A5FgaxO9H51voP75odscZIoHh4on9dX7uB5ahUFV3TbSCO+xJSZ4NtubakhgX3CsdJQ6Elog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8acRlrdGVZI5eyEDBLjQ/HKJ+ndD2dlYiSgPWDuTBeI=;
 b=Q5sAlAuSkxuA1hutGjSgMd3f944PipFBC9vTmaoteFx43vMQThyemgGa4h7XNNLIbqNLoRzAP319KSdaCZUmG4PYPafVsfoBoQobmuyh8qZ6ArYjt391o7r4P5oftadVwred74DRpLoxUpbedgOTGchWx1nQs5vOlk4WoDxRI+rxib2YmDkIxCKbew2vjUxmW89LsKCa992RxweNXTewsGqA022C2C7HnxSwYq8Wg11j27Snb+o8uBNSiy6sLREzReEKfsoDEdSBOEjJcC/jRilGCRz7tcXvLZQCborQT3jikXxWu5raes5IS/a+QflwJPCJbxO/DeXzT3E2E9WoIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8acRlrdGVZI5eyEDBLjQ/HKJ+ndD2dlYiSgPWDuTBeI=;
 b=Y6bRo3lPeuFQt4Z1L5FBkUt728ACtri5HNQlnb7CYWJgpjAYFTVmJV8+1E2BLdUTGM6bQfl0FnpxCT3MOZfm04mvWP90NLBGgBYwY+x46NvdO0IdkGf56nymBq99BEnPcelYHP+/eEEhD52AJ433bX4hCqvWryHybMNctlTeVW8=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN9PR12MB5148.namprd12.prod.outlook.com (2603:10b6:408:119::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Fri, 6 Oct
 2023 12:57:47 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab%7]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 12:57:47 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "StDenis, Tom" <Tom.StDenis@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2 1/4] drm/amdgpu: add pmlog structure definition
Thread-Topic: [PATCH v2 1/4] drm/amdgpu: add pmlog structure definition
Thread-Index: AQHZ+BT/0fqBx/cja0qrrrgrwPZdo7A8otkAgAAP89CAAARkmoAAAJKg
Date: Fri, 6 Oct 2023 12:57:47 +0000
Message-ID: <BYAPR12MB461482C0FFEDEC5F3CC751D497C9A@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20231006052149.1566154-1-lijo.lazar@amd.com>
 <PH7PR12MB599741EB6BA789C3D349682182C9A@PH7PR12MB5997.namprd12.prod.outlook.com>
 <BYAPR12MB4614CB22B5E7598DBC5F401797C9A@BYAPR12MB4614.namprd12.prod.outlook.com>
 <DM6PR12MB3547B76D8F43ECC6953404D7F7C9A@DM6PR12MB3547.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3547B76D8F43ECC6953404D7F7C9A@DM6PR12MB3547.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=821f94f0-17b9-4553-91d3-5c0912870ee7;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-10-06T12:54:55Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|BN9PR12MB5148:EE_
x-ms-office365-filtering-correlation-id: 4b426743-0f72-434a-ac4a-08dbc66bd72a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P29uJdpuOSM5vXAucG/z6vPGjvyVkk7dpHA9WuQcF5zypkpF0gCHVEXzpFzupunMROyfYFVlerMgJQPMVfTJ5zivlbpeTObmIG91Z3/RAnWwJs7UaXlhKE5TKpp9/nC+3fO7/Ok47GL8fsdlj9ZMEq+cD2BkBGADCmZqMJbzjiUDbhw8zCgWckCEwqToHGWNG0AVyKP90jJAAstHFbOFibiKewkM2Tb/O/XuuMqgOSTwngscgN5afEKXWH8iqeEa4ceXXUptwVL7BxKNhXgFFKxZ2NS7LSFS0zt9dn7QZu/hhp3ayzDwRdFopMZY6cV7pc9XZgctz6VgsGfW+jIMw6aH1ewsEfLVHN6LWT8O7Tc0fzatGVpJRremABuL7+xuU/SJo8QjWXcdBntd+iDQvG/XKZwc5ZmIHCZ6G0iD0sQNen8FRBhZEVdDbC8LvLNC0GHrt9GN5o4KSRhV3ErlOaW8Y5Blvm0O8znk4BGpIcJjVKo2DFEg79ut4grTkAJeVLhEyISVCkYBiiTsIFZL4ka42F0xhhylK4lDTBkYOimxSQROhDbNcI+iFBuhBjfWCscyi7MiPw4vgOT8cieWitJQsa6t2MQAW9+Ney8XG9YxV/FTE430IQIhWWhXauqT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(8676002)(76116006)(8936002)(66556008)(66476007)(66446008)(66946007)(64756008)(41300700001)(2906002)(4326008)(110136005)(86362001)(71200400001)(38100700002)(38070700005)(26005)(5660300002)(6636002)(316002)(83380400001)(52536014)(55016003)(33656002)(478600001)(6506007)(7696005)(122000001)(53546011)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2mqgeTp0WMT5zF0WRPfF3AJdCxmUprf+osl8tDVmIRKYLk1NL8yD29QaRc4z?=
 =?us-ascii?Q?ZcSBbJm9K9Nsf3Ykd3thYgMgtg/H+AUUgJyvoVY42nzAqjKZlhkY+0KojEgh?=
 =?us-ascii?Q?hSuh7NeSlr0ZSHTt5JTINo/C59E8TDHjsviwx6HDY3GR4CgoJmMI1GGRBkM6?=
 =?us-ascii?Q?V/LgrHAlMxjClaWxPf/2QPqIPUxxXNbAw/ItaekRVYMpho44y5IW0eykp46D?=
 =?us-ascii?Q?VEirynFwG57VC1vdV8r1f+uXilk/a0WPe98EFegoOFT4hDxotQcid0BS5y36?=
 =?us-ascii?Q?QkaykBKs1L1vU34T47yW9O1GMlw1Smju3L5NqSPFVZ7YjSqeqgwjJEq6xc4h?=
 =?us-ascii?Q?xrET6vxD7c0gNOkA1Ek9jCHpYw+YsXpQcasexsA3+K5msMVbfjOwkZD60AEA?=
 =?us-ascii?Q?5F58XTNLr0UUswIifgO2MwFmo0hmKdzT9UW7W0Ir0wwwWPlcf0FiaCX3astv?=
 =?us-ascii?Q?zaB7pjYlrm8Ec75lBzPXB08yPp91CBNbJXENnVEkEAQ2IGkaGUk332eJB6du?=
 =?us-ascii?Q?81NEi7mqiDEdr8Pl6Pwzbyp9wvW7reQseEB7mrZW5IH71x6G6ewDgGtxl81t?=
 =?us-ascii?Q?4+sXzDMU3VXI8IrF1Ted53hDBmAz2zP40FEMM4yDr1uW8Bov+sT4EsKs9dwG?=
 =?us-ascii?Q?EliDI4X2tmA4zNsh6u7X/+7PdVyRwOmTxkLK8bA+OOIx1+ZgNL4eVNa0gBoB?=
 =?us-ascii?Q?poaeZetAPGQJ9oUJeNZdxhEDl295Z0jHFVRSFvthcMjEubU+pqo1f3MU8E7b?=
 =?us-ascii?Q?XarzVWm1qiG6EsILejX5bOxWz2hp7QNuI0IC2BGEWn33Hxmn6FqxjEc+75RX?=
 =?us-ascii?Q?F/vBwy1WNRCBiKxhKuZkPwB+uWA4SDsBCaoMZoZkBAj/ImfMXme42YJAVzi7?=
 =?us-ascii?Q?JzXV6J/sUc+7ppy9Jw3YlpBbcwOTo/X25jtEcddt590WzUcTqWPrqwtHO3sP?=
 =?us-ascii?Q?YXcoP7F1RXcIqO+ku+GOKqaGIvjWeP/DLCK8g52O3k4eqPa1y3O0MqG0lPuY?=
 =?us-ascii?Q?3p9DtYcL7Sr1yEqzTGx3Rd7HXZbveBdCDlVY1F9ZP/d9gLM0bA8W2w8IsX80?=
 =?us-ascii?Q?XrKW/JO/pXuTwCfnIQy54XVamYac4/KDNHJu3dzitrqTJJ1DrzKXIIdY2WD5?=
 =?us-ascii?Q?Nx+6SarZfidNi7IyJIsOkA/FQ9bT90PJTF4hVk0ACXrDGpusXNwXdMiXCt2t?=
 =?us-ascii?Q?DJa4ZnFmZVauJEAYXynOT5q+yM6W8WRY/KkWVhrOBG64eN2ZO6iFOx2kaZxs?=
 =?us-ascii?Q?9Idq+qO+kQjp6MgI9KQ04ma/thTk7E2pzdyL8+bQUE9lj9TqfT0rjmQsuLJr?=
 =?us-ascii?Q?sWTE3dt/3JWzkFtUUqJN3RyHEtf8rqwEeL1vvb6jIECkm5/ANW9CLC8gyf4i?=
 =?us-ascii?Q?W56g76btULCDTLuJnldMYFTfQXfo8d+1TcLAnFOe7Fa/cdz08RUK4D2iAwji?=
 =?us-ascii?Q?fdxWW4Z86yViLG0FjCnHlLvv8IXvhQPWveSei6155RTiOYGRMU7lts7ixi9j?=
 =?us-ascii?Q?PoCmEziBKSKZpusqQshnD/NbIf+9WFH/TEiWt+n9yl+v5LUgye1csA8XtTBi?=
 =?us-ascii?Q?NHpP6CEGsUiWHy5D7iw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b426743-0f72-434a-ac4a-08dbc66bd72a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 12:57:47.6435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cnqpSRYrFzCgOYudcJF+UScRqfSWp+8W29UIGe9khhnNaIO1FJ3aoWBYgWHt3Udj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5148
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi Tom,

It's about below sort of versioning.  I don't know if we will have multiple=
 log data stacked or whether this will need a different format. So far we o=
nly get a single buffer of data from FW.

struct amdgpu_pmlog_v2 {
       struct amdgpu_pmlog_header common_header;

      <add some variables here for x,y,z?>
       uint8_t data[] or some struct here <>
};

Thanks,
Lijo

-----Original Message-----
From: StDenis, Tom <Tom.StDenis@amd.com>
Sent: Friday, October 6, 2023 6:22 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd=
.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher=
@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH v2 1/4] drm/amdgpu: add pmlog structure definition

[AMD Official Use Only - General]

I'm lost are we talking about the pmlog?  umr currently just uses the pmfw_=
version as a key to find the correct decoding table.

Is that value not specific to a given table version?

Tom

________________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, October 6, 2023 08:36
To: Wang, Yang(Kevin); amd-gfx@lists.freedesktop.org; Deucher, Alexander; S=
tDenis, Tom
Cc: Zhang, Hawking
Subject: RE: [PATCH v2 1/4] drm/amdgpu: add pmlog structure definition

[AMD Official Use Only - General]

Presently only a byte stream is intended. If version is needed, uint16_t pa=
d can be converted to format/content revision.

@Deucher, Alexander/@StDenis, Tom, any comments on keeping a version?

Thanks,
Lijo

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, October 6, 2023 5:08 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: RE: [PATCH v2 1/4] drm/amdgpu: add pmlog structure definition

[AMD Official Use Only - General]

Hi Lijo,

I prefer to add a version field in header, which is used for compatible in =
the future, what is your idea?
When the user attempts to parse this node, they cannot accurately determine=
 the format of the content.

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, October 6, 2023 1:22 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Deucher, Alexa=
nder <Alexander.Deucher@amd.com>
Subject: [PATCH v2 1/4] drm/amdgpu: add pmlog structure definition

From: Alex Deucher <alexander.deucher@amd.com>

Define the pmlog structures to be exposed via sysfs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index e0bb6d39f0c3..9905228fd89c 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -980,4 +980,19 @@ struct gpu_metrics_v2_4 {
        uint16_t                        average_soc_current;
        uint16_t                        average_gfx_current;
 };
+
+struct amdgpu_pmlog_header {
+       uint16_t structure_size;
+       uint16_t pad;
+       uint32_t mp1_ip_discovery_version;
+       uint32_t pmfw_version;
+       uint32_t pmlog_version;
+};
+
+struct amdgpu_pmlog {
+       struct amdgpu_pmlog_header common_header;
+
+       uint8_t data[];
+};
+
 #endif
--
2.25.1



