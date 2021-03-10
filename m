Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52845C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 08:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B99E64F58
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 08:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B99E64F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 983826E9D9;
	Wed, 10 Mar 2021 08:30:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0B226E9D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 08:30:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxHEFVpdzxtfH1OV5QIDNuV4DiYtnrg9YPCwwduDo0i+Dxsg1FGMkPh8XxCIYrhRFFhytgDlUqfXdoYM17qB2KXCvy+hDNikZ0kJvEYZAVDtuNeZhkeknV4MvtpVuTVUragY8yRnjlQhHvxZmGD+WEwaHcpw2nZemikcibGIdAVJ8xxuHDnvqmuvIo+Njjl+H0KVglye6CsDyDLvHSBL9xZ0QOEdzuwp31KMQ57v6GS7FprDfJQuk6xNyFYWVzUb526dNjKL651i49jP2JnE7NtudOQoz+NcTBFJpcOFJRMKLG67Y6rw/3+SSfTXCJoFOkbIwUwMjDYTcIV8rZFblA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBDnC/7kM+PZI0hlot1mUWcoNlUh088i+FYamz08ewM=;
 b=Y8kaSxGnJLSctyc13hnVeKNd6IkIza6H7ZpexptvaJaVi1/vJRAkcxIALV0WARsQeDMzi7N4rXlw5toq7KDMKwZdrKYBpmt1bJVscapS5rtib80tQdzWQonwh22SQ5SWk7K4zLAE89AHK6ubXy9kgIez6Hs67vsOTEaNEPawo9RJhmXZQSlHSM5qU0s4W3yEZuo8F1FAoEHOwxmyaC67aGM05VGpH5lP0uNDilgcxa32EheVQFsj66CyLfAbp0KNSj9Neo9YEmZTtHvTZvjDeGetAK6T0IJQFXUd/g3MzQguHpHBgkxjbCivzLoLyP1uE4Li8BsJIfQ6SPlrkQFW9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBDnC/7kM+PZI0hlot1mUWcoNlUh088i+FYamz08ewM=;
 b=TuVelMBHoNsk3B67m0MQrye6f22qnVo4Obk/0zCnYJkN35RgVEje63PeU1Ss0Stw9qn2yTPkyrjMIRy2CzJDrA4ETK/E3zQthDXBzSsATGGD8RtMGt1gSnWAzXz8LQapcTKSYN9BTAWxJmWQM/e1OyBtj4pL53HQVoxa/hmrpjA=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB3936.namprd12.prod.outlook.com (2603:10b6:208:16a::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Wed, 10 Mar
 2021 08:30:01 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%3]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 08:30:01 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: correct the gpu metrics version
Thread-Topic: [PATCH] drm/amd/pm: correct the gpu metrics version
Thread-Index: AQHXFX/PMwNXJyzls0q78Cg6McfqWqp84vxA
Date: Wed, 10 Mar 2021 08:30:01 +0000
Message-ID: <MN2PR12MB45495F650E92B60E00D7129097919@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210310073401.815536-1-evan.quan@amd.com>
In-Reply-To: <20210310073401.815536-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-10T08:29:59Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=115e73c6-e00a-4a14-973f-4ef5d71023ab;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b21dfe2a-6b10-4f2c-a99e-08d8e39eb27f
x-ms-traffictypediagnostic: MN2PR12MB3936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB39366456F8C26DC0B0E0F31097919@MN2PR12MB3936.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d8DFj14C24adinK6uRPFSvIc6uRhAF+rlrfix0yBILQsDbvCiUTrFKg194HeJg2oe3OdivZodV4AZdnTDQc752Urr/L0/J8trUyAc/L03wjNrLZLmNHbgMaBN0T0iqlyuVPb57b6NbU+LSB5pRJ2m528GmAID/Jm4NGLvWQxVpWR5A90hwUbS0i3vhvk+xtU9Jp8B3ynyT4v75qHES0L7xR9/Our+2YskKn0NXl6XAbC40gPs8vbxBFOvk5deMRZ6SVw947TK4EKc7otBU6So0oB1rNPAiS/Nh9r9GR21DOaLHFihB3PXkz0GxmfWPEUVDj5sPQJugVLwawKyyy51iIOCdBXQHtVPCN/QI0JRwmWyJQLsHjeeMV1K8sdAqEAsuyzdpKAER3eiV/XXmnBJnaur1oc2+MoO+XW3avZS7t7D74MZOn1ejhQAeOiAuSzg14nlgZ4A/iYPmHnG+Fq06Rd2h1m1W77T+wwCuCo9w/gjbNuvSA05pKY8/GINNu6w5TmS37WaMAv/IkRAkKsKjUxfnU0+SUnSQedqIWt2g6b3PVu2RNplhAiy0zyNHUq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(376002)(136003)(39850400004)(64756008)(71200400001)(66476007)(66446008)(5660300002)(7696005)(33656002)(52536014)(66556008)(55016002)(9686003)(110136005)(45080400002)(54906003)(76116006)(966005)(186003)(6506007)(316002)(8936002)(8676002)(2906002)(478600001)(53546011)(4326008)(26005)(83380400001)(66946007)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+Y20clrsDxMe1XOYxG91XcfMK8a5QI1MCyjcGxEivcAOLLX5uvoQlNo25KM7?=
 =?us-ascii?Q?7zYVL3xfS2pwPqt1W1dTZK/YUeX00tNpf9ziLxd9rmLQAzbx1GeFySYxY54Y?=
 =?us-ascii?Q?ql40Zcwo6DQleKoUuCa0Zfa+33ez9VBekF+ZIyQlLQcUxbjXfVFFjIlm5Kl0?=
 =?us-ascii?Q?sqWYhqZp+PSXCnY7bWEamzitaPUSfQ3gCc7EMBa0AErWm6fRU4e3apnP+fT4?=
 =?us-ascii?Q?sugLnFBGDz8F17wDSkYFyUmY+pvtBDjuJ7fIUtmShJuvxoh9kwzDxbDJM/pi?=
 =?us-ascii?Q?nnAMSUNsoXtTU4qqWIz/HkjAsBm4nFMJRNRF0/E2ScAWJ244pR0LbDbAQX5H?=
 =?us-ascii?Q?32Xwyd9NAWF/ejzW9Zr1KReQWqIuepYaFcqbxuI2/7osEENiNSug8oO3IX9K?=
 =?us-ascii?Q?ZQb3eCUzw2Iydow+1C38XKVtC8EDch2ea4dZmZUOHrr8lLT3VtnFvOa9eE/P?=
 =?us-ascii?Q?rwsnnU8qqHUCHifi7j9UgJMzqOZ7IRaywiAkGSpXtZhePSZVG3A7cTdk80dv?=
 =?us-ascii?Q?v+fEvm69n7+IghLtcL084BSnmYjZVa0KNXEQSvmIqEEHEetq4U/+nBwLm/Zt?=
 =?us-ascii?Q?CZQCVqheu8xn6jgDz8O3fwwtHE4ozmwhfaGEq9uMsbK9d+6lUQ9TZJ7YGgTV?=
 =?us-ascii?Q?daB2oRaavszE7WgYUJyVthglkovi5K3/YUTYq0F/ppUDY9cLm5h9fcL2uUEl?=
 =?us-ascii?Q?3IjVo350OuZgAx/bbmZb0owdvmDn2ZgKKTz1N2MKW5xFZ0SLdDVECEKfufKc?=
 =?us-ascii?Q?6BLfJm/qFXMoZaBmStUk3ccnyCABuT1q6Rm/oPcGS9U8xja0KrKaFPccmBRP?=
 =?us-ascii?Q?auYWFqoKX95DfRqi6+S6WNrq7p/ORqjtKWaE1yp0xKEXnoIPHEbHY3OM4ILT?=
 =?us-ascii?Q?01K+shkNbVFQa6LsAcHh3JZOEsrR/HvJ19UnXUvOBRKQAcz/PBnrFtpdEojx?=
 =?us-ascii?Q?ydLpaw5o1FX3al7HX3sXON73ZpnRwJ8t8Pnowo+i2Yi8WKQeSN5nde37EFxS?=
 =?us-ascii?Q?cQTJaiSvj2bEtlfWIn8g4x1zQxaJEM/92WBFDM1mN3yWEkre9t9bz9ZWO0wL?=
 =?us-ascii?Q?OrvD98HUZm0uOzTnGwc1c0VDzpNghrBaNhKH6JcYv2agsshg6te0zS4InPhP?=
 =?us-ascii?Q?/yxAhITXxxo8S4WuZvdsHdD/qZsYLVk9hqqoEqyX4upKXpodAK1nOSvqX7DW?=
 =?us-ascii?Q?c2FMeH89/I9JSGLUHzIJeMb3GtsyccM2T1miA56LnH4VJDrHXYpan5lMDlEj?=
 =?us-ascii?Q?1lb1XvvmxmLIntQRKKtjgwIddD+6LuNtuHwv+zfD6oz/5yhooncB9VS/hmxk?=
 =?us-ascii?Q?a7Qs1SoP2sFfS+COuW4KWbW0?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b21dfe2a-6b10-4f2c-a99e-08d8e39eb27f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 08:30:01.0709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VWBs2oWbgKafpnKE18pXxsVTtzFOu/g0w09G8KrDTuzQTchrMhkEnsDsNUa/4E+q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3936
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Wednesday, March 10, 2021 1:04 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: correct the gpu metrics version

For V1_0 and V1_1, they come with different size. Misuse may cause out of memory access.

Change-Id: Icd06e673b9259d8d381301c145f0e9eff3408ee5
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 740025ee7f78..9b0bc570d31a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -206,7 +206,7 @@ static int aldebaran_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_0);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table) {
 		kfree(smu_table->metrics_table);
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7Cc31b1fd942bb40c1588608d8e396f111%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637509584723831600%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=prot8ng8SzxzQXj2bjcmwU0X1OtKbF1SEnc14ia%2FD5M%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
