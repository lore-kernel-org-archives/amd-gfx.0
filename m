Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DB8C02198
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 12:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A64210E69F;
	Tue, 18 Feb 2025 12:20:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KDd6H44t";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C7910E69F
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 12:20:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPwtXzYl+a55z7Pl7CIpktK93aShP0TXHxs2YOUEzBA91Mxb3zXneDquI4w3NYwOn7I6qso51fjBOAljGIsTYsyfcaSLnitdaKLZ4TNTgVO0jp3QBoygRKWbznxjbx4z1BVbQlUWVnKBJQ/WvY2DP3kw0xugCt1FWYXw6UPM9BGFdhkp4UEA3EkzpowA8wUxLQCJwhYK9NpxdEYb8fe0Q0if3jnURPThtkxsaYC2UiUXjyIhHRkzzmIHmZRP0pYZv1/ipb0IjbPt9c2tqnh1h8CmdMVr15gaI+ZYrPu4hiBVHU9qY7Q1lCb6VTUubIAaBr12j/HFpQdtGu3Ju+KrHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIeTM9yUvf2QWcticAG9UjHtbsLlKmpbqcNMf1INj+8=;
 b=g10vF+rjmUbXJFJnGUzkiQwr0ZeYYTY+iBbLmDoQn01S7PZLUmq2cqsMIkhlWXIJG8xOVO0aVK+KSbgq6/uIoI1WG5POfk7W9kdi2farOHQuF76DMPCwu0dLr8o22iE0Z4rk0g/rbg7ofrvtH6pkJFGczzVfmBeOzP5nRZJO6Tdq0MpL+wVyNY4psIOW05TH85y44MrUHWZ85FKCz0vU/5ZE3bctb31Z4jhqed0Vp6TRLFW7CBrkh89cRc+58teUVN98olnMsXR5dFOqOLiJjrLhTOla2/O/JklkjHuX4bT8Q2tVQMnu50XEa5YFjZ7bjBjZYCu99XGKMS/dkvIKzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIeTM9yUvf2QWcticAG9UjHtbsLlKmpbqcNMf1INj+8=;
 b=KDd6H44t+qmIqxV09RDALglQa6rUNdTDpE0xT+H/6yYzlXXmBB+JmZwzPnoSGVadpaxLg4hqgRl4DZEb/7Uf0U29RUAN5Dd471OCjDlpyXxH6FA2OHTGh95wEgvwtGmoG5mrwNUKFb/Vk0zesorOys47eU/46zzwNOGmlFiuVf8=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 SA1PR12MB7441.namprd12.prod.outlook.com (2603:10b6:806:2b9::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.16; Tue, 18 Feb 2025 12:20:13 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%4]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 12:20:13 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Fetch current power limit from PMFW
Thread-Topic: [PATCH] drm/amd/pm: Fetch current power limit from PMFW
Thread-Index: AQHbgf79gowRiHrK2UW3ZZcz0lfxcbNM+ufQ
Date: Tue, 18 Feb 2025 12:20:13 +0000
Message-ID: <DS7PR12MB60713D6F7A4E51607643A9588EFA2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250218121630.18577-1-lijo.lazar@amd.com>
In-Reply-To: <20250218121630.18577-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7942cbc7-0b43-4732-924b-e3c06b3687ae;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-18T12:20:07Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|SA1PR12MB7441:EE_
x-ms-office365-filtering-correlation-id: d3873a06-7264-4ced-eaf9-08dd501698b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?OszezD1ffvWmdKZ0xuE4xi9Emnt95tpSjAK7nsPAv5u5EloufI8cPhgq8e54?=
 =?us-ascii?Q?xEaUvDvbKuULCKx37L4CFfdhdexblQVglMesFQIbeYq2pdjJgOYdtNoGxlX5?=
 =?us-ascii?Q?ngO8un+I7vOce/T701kjpPeUhmkjkuuY3ctLdIbdbSkNox5yjIqbMmL5e7Rp?=
 =?us-ascii?Q?j20YXGGzX6z4IVVGsZ7oQvphQXiXEm5EZsnCNg2sWnTV+MzGS5J0gIfZBHEr?=
 =?us-ascii?Q?VYNdrtS2Utavug2WDBiIWYCOYXkB5BNEqZ3PujhAp3ap6UaBoyYMXdnq+6FS?=
 =?us-ascii?Q?0XqXphQ++lqnj5TEOVMt32+9KKiqNP06Rp//SXMJsqyKBTSSwo4+uW8YF+dW?=
 =?us-ascii?Q?h5Senh8BVPYwWmgzSy1Jb80kY+6MOPMHK8w7n8Pnx/MN+dCaFLVRC/xmVU9n?=
 =?us-ascii?Q?iESA+tKjN0HRNcA0WsG9373nHbaAoagzT0QvLa/A/2juOkHagEXGu0hq8Hu0?=
 =?us-ascii?Q?3nQDKM6JlnDStdpbejbSdTQIgtqAPmRQQa5im/oEyBxBY5gqr2x3GPotvNnc?=
 =?us-ascii?Q?rUty/+xhqeZPbHNU9vUaSTQMPS2ceD7fTLMrF7Zo1RssikI96AwMAxV+pSQ9?=
 =?us-ascii?Q?tFo+S+1hHQBbLOgfu1c7fPDL9eqbXMg1eChuJP6HHJ7PPxfed2bfRhoozwkR?=
 =?us-ascii?Q?j9XCdcsRggFgRrf2rVtehKw/gnZ6Bzk0HQoYCy5QDYPdwE4tKHLErpCB/VQ8?=
 =?us-ascii?Q?ckucORRB7TBr2IdtoEBD+avIck3wk4TcAfMIel8v0ljlJPXmAlGYo0n6q5Di?=
 =?us-ascii?Q?I5XHpshmOk2BwT9d38qnAyzQqZTRnz8fCrwefqKrwjE3dIKMWofRtERdK6Bt?=
 =?us-ascii?Q?PJYcBBjtSTkq+ZDVpH4g+nknVkOmc9frnk6DAyNHo6TksCNIsXIlSo+KpyhN?=
 =?us-ascii?Q?hlXzCp1vXTSr/Kie/SHay62pJlXWABNMm6A0fArHjBX4K7Z7FddG5YAktbuT?=
 =?us-ascii?Q?fRAa2suDlXaOtNVdY0Cc4zQ3orbfRlE4xX8cbmrBM95U8euGR1Gfd1OggGVs?=
 =?us-ascii?Q?TvULbDmJ/1mHcrayjYoh4aK1tUlMT5sXVPPrd2AbPcMv6lZT6nbhNWFzPAR4?=
 =?us-ascii?Q?tVk/84ZXcEfP5csX3N4j9iEalwth8P30Ru+gRZ+udWGAi1OCTOxnf3NWwttg?=
 =?us-ascii?Q?fc/T5i5ovAE1B+opv3hCFV4IgLWkgQ/jxUl3mzVpug/JfD3Jxsdy89+e8UAR?=
 =?us-ascii?Q?czYYokT4lsv/NJ+kuNWjJkjyc0tuU/NLgHh2GoPocRFap3+AmA2PcLjGH+I8?=
 =?us-ascii?Q?3AdLhtf9SeZ+UrF9+Rhd8s5qcFIZxrStqz3GGHrNQNdJsMX8RIjqBQZeRCfH?=
 =?us-ascii?Q?OFvxak256ipxz8FPY0t5jHB7KEw1mWzM3t+bZf9Apcl9xzIiTiLn1lVmCI+I?=
 =?us-ascii?Q?U9p8eI034VRHeTWaC+cguv7X/Bb5trn/tpQL2n8x8AySH8Ot6z6HRJO1asaj?=
 =?us-ascii?Q?Cjn972aiS+XdepglEbn06IiMEcwe3KXd?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jh6tFcf3DTX6RUQTTC3jBQI2KClIg8NsYTaDSmPLP4gjTnv86m3RZnehuL5i?=
 =?us-ascii?Q?D8fPh3sOcVh+VW2jO/KYk/RaRVfL3ObrZCtIZavPSRW2LPrszlozKW9pb2jy?=
 =?us-ascii?Q?KZFY0v9EKxvg52z4sD/uE9Fwrrp1yQCa+Qi0kc8oRTsVsKiCRRTcEEWYqLH/?=
 =?us-ascii?Q?ynrbeXSpfjsTxS0Dk2WFv2Ehy87de2oRvi2bXq16SaiFvIfPrzW/ZAfxvY+a?=
 =?us-ascii?Q?+g5bdPMI6qksYXQ1tvxTJL2KVMj/k7WQmzzK/Jpv6R7zuiPTe2NEzxmA99tO?=
 =?us-ascii?Q?r2/UDhlV95GI6Rrmu6XROqMTXdCS2AFK85Ez8vDf6Pfzf9zmpBhfzzaNL9r/?=
 =?us-ascii?Q?A32S/QleWeeSHdMQ1+34ae9e4Z9T6OjAFKu/zsilIXRTL3iQQdjTaXgY++Cn?=
 =?us-ascii?Q?+vIqagOLW4qNl6kZ3eHxBOPhw515pwrWQDhK35DycKIwxdvJe3Roipt7BKCF?=
 =?us-ascii?Q?mrhGwcVtGY3v+bS82OumcxGYL71mbgXZpcYK6nhofTHCeDHdAaportqmMvuz?=
 =?us-ascii?Q?xyLu8T5Lb+1exWncCsIXknDXSqN1i9PTb/6FlsGbhiG9N6veM8K2etsJeHBB?=
 =?us-ascii?Q?POFonDsUQZU4g3BqUFddz7dBI/xIOQz8+3/G6ruJG1F9Z1oiBrAudf7WaUTo?=
 =?us-ascii?Q?vkRfoeiKLnimgUPyUO5IvC+NBgSLovUf4DV9NfKWC2vxtj27SsbPEotIhrJ3?=
 =?us-ascii?Q?mdc9niBnAs2M3AAMI9pC3FA6Wus6uv1790SV57Cs4KIUhK6SAfrM+EUfJLDc?=
 =?us-ascii?Q?JX5+wrysFjbYCpALgPhQ1YXe1qIzucKcnzCjoCSFmOenoUG9o4cl+hJGJiI5?=
 =?us-ascii?Q?3ZKvDAx0qEVoRgkbAY5F8UXl6VMZSikeHwpCy9wJ9utA8HfWfyTeRwvu7CC1?=
 =?us-ascii?Q?d7nuPz9sdMBloYx+ZAL+PjFmjTUAOiDfg29jzUndBOXxabKpZdNOqOuURdYE?=
 =?us-ascii?Q?+EgKfnye2A1GnNHTMk7/YSioFhwFljOeG5rRK1xDBxD1hXDXdOaeeh/VToM4?=
 =?us-ascii?Q?Of0FircbDShh2ZlEYn5EH5f7wlK2PLs4LJWqjA6J0mEShm61/6aDsEJrBw23?=
 =?us-ascii?Q?uJDhk5owLeYJZdSjYRIp5ViPJdSbGqEcTRbIMuXPx/Z9mRG2oIWIk7H99zFT?=
 =?us-ascii?Q?j4iq6yTzeIB+8IflH6Hu3cRBdbvZKi6ahX65jbceBPVzfD6sXbfZRjv8Yc4u?=
 =?us-ascii?Q?X6qQdn1HyBQTw/sz9XCvXFeoUUo90+mSXSfukE9puDVg78BwS7MF/fsjBS8P?=
 =?us-ascii?Q?ZG2/Hx+Z9pEdYV2fFhIkIxsSxTPcmU2W+EaeSfuJch7UuGS9Ur+7uLP9Cp07?=
 =?us-ascii?Q?DO/JI/dbVrBiXiPZPBO6rR9ivC4nO2N6++0m0/Y4SckNA21Fe8K8xGosb/CB?=
 =?us-ascii?Q?9KSoARkEXUtbzwservuRiZQEJzLeyi3y0vXBw6aBsY/JKULHNK0e6+pIgfr/?=
 =?us-ascii?Q?9q+LU3A+tqe8OkVoFy+HEOcUE/vYvPiBWrM3/MEUzebi3PzSR+3n1BXpm7Dx?=
 =?us-ascii?Q?U9pUDdOiaBeG6oyi2WLrmXpECsjzTr9JYgCkaQV+rHd8ioM8diNmlZjdiHsi?=
 =?us-ascii?Q?IGbYQY0sW3w+UOmiOIg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3873a06-7264-4ced-eaf9-08dd501698b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 12:20:13.7733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOwGztEsGD9Wsd1DQ63B0MzKQsCoSWTCAX6gEhTYGrVodcEayVn7RIbKazwFvuSl2tfsxZp3Pt8ZdbRuAGvBPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7441
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, February 18, 2025 5:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Fetch current power limit from PMFW

On SMU v13.0.12, always query the firmware to get the current power limit a=
s it could be updated through other means also.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 7fdd7190a0c6..f0a14496d2b2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2791,6 +2791,7 @@ int smu_get_power_limit(void *handle,
                        switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
                        case IP_VERSION(13, 0, 2):
                        case IP_VERSION(13, 0, 6):
+                       case IP_VERSION(13, 0, 12):
                        case IP_VERSION(13, 0, 14):
                        case IP_VERSION(11, 0, 7):
                        case IP_VERSION(11, 0, 11):
--
2.25.1

