Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CC2C369AB
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Apr 2025 09:07:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5250B10E21A;
	Fri, 18 Apr 2025 09:07:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="osoGgd6w";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6296E10E21A
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Apr 2025 09:07:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKGOLjrXvIyDufv2QklYjVK7qslyISjP6XwZ7TzNjvcKdVSf8WVZd3sg7IjAUD3Z5LNm834rXZNaWgotQCbfV76XKQ0DrppipaORmCrRSOnOsFIKGljpzjXF6LbX9qALHCpE7ZRB9PlwLb4I1UewdaYsHWLlfP+9A7i7+gahHRXzzW5ort0xPAQ/KTJGZmldE5n/8MImSgXwujCzM7mELvzzoK1FVgVTFkLR8K+Zfla0d7nuylKOJADpgMfQ5cgPTyD+RT+z8cyvX4QhoB7Q0rPlF7Zoga8B4xxppHlbo7a5TUezQ3CA7e39aG4T8WRbcEVoZ8fJvmQWuDRAIR9/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//G0ZOgxyP98GGjEkeZSlXQoShKnntTsoeRuY8CazEw=;
 b=y9o4ex0snpuABsQ6wUkZU+XT60EWhr97LHYd0yE27bRF/cvolA5u2UAV6lx80uLpcSSwyJc0EUtialbpRL1MU/z9NDMRmDFHQ/QcFqYhUt1wxZPl/3gQ88NQcj9PVTN+QiRd+bczez59Tyfj5r24QrAcJZDalqsj9hYQfgVElVNu7JjC4+pcdUkNvOiC/WzZWdTG68wBJyfpCHhRqU1HTtAaVNckfLBAQE1leDuPL5nj0zCaRcMmT+vYNqh51qHv9u2kCe3paOROu8cIYXs4JBn/SjgKS6s8VzJ1SxffSfbpy6aXnoi/6lPtNfKiAEaJudnB3K4vXLph0B+UsORyWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//G0ZOgxyP98GGjEkeZSlXQoShKnntTsoeRuY8CazEw=;
 b=osoGgd6wvFNYgWl2KeF9L2F2uKwA4YeqKg03ZcIBtZWnJYy64XlywuH66QZMIxzoLSoHpJh42Yc428C4HiQMEy3cKnUsLRmtPLzaBuJh7FZBAnK2nXlaqQt3g8pr2IhzEkbPECwpNC3WXCUFoF6WCa3SnXFdsQlXusOC++jEgVw=
Received: from BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.32; Fri, 18 Apr 2025 09:07:04 +0000
Received: from BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::eb1a:4c36:7d9d:6176]) by BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::eb1a:4c36:7d9d:6176%4]) with mapi id 15.20.8655.025; Fri, 18 Apr 2025
 09:07:04 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Print kernel message when error logged by
 scrub
Thread-Topic: [PATCH] drm/amdgpu: Print kernel message when error logged by
 scrub
Thread-Index: AQHbsECEHzTTyUIGm0+a318MObHWI7OpId3w
Date: Fri, 18 Apr 2025 09:07:03 +0000
Message-ID: <BL1PR12MB5254665F0537040EE3383B90FCBF2@BL1PR12MB5254.namprd12.prod.outlook.com>
References: <20250418090127.122831-1-xiang.liu@amd.com>
In-Reply-To: <20250418090127.122831-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2a80d618-aef4-46b9-8684-74d158f9ae74;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-18T09:06:34Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5254:EE_|DS7PR12MB5910:EE_
x-ms-office365-filtering-correlation-id: c57e630d-ce1f-41e4-12aa-08dd7e5862f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?NvR8/qTbxA5Na8xNi7IzOO6vKp9L2SEp9nAHhHjs4duXMUK1LJR5AMs4ppp4?=
 =?us-ascii?Q?gIFDQh9+RNUSQt8SnGEuqCxJ93Exa+kODA3rI8+o+eXNOIVI8/48ljBWa7Z2?=
 =?us-ascii?Q?zVZWooghk+T3sl1K9A85vkBVf0WX0wMjtYv0YO/eD9Ojp8s8TCTyJYDqQot+?=
 =?us-ascii?Q?8Pahrebji/ddO4ZUAy56afZfseVMsJ8eOIo3fguSVr07k4YvLnYG333APih3?=
 =?us-ascii?Q?UELfGqckUEDH9iMRBiMAkT3AkvTIZLWdV5Up2zLysJgcHaAxM4r88VF3ZJA+?=
 =?us-ascii?Q?Gqb+wOvBw8zCvrJju4OXIj7zJZ/so5Zlx9BPx7suGSHMwskf5MurHjqdpoxq?=
 =?us-ascii?Q?6BkHdMJWhbz3CnCkcCT1jVCI4L2gPGt+Xuc6b5QP7czPttimlcTKOrdyfQEx?=
 =?us-ascii?Q?9TVLF+tMyA2t6Dj1sdKlWv4VOQtnY5VKLy+fIaknbdR871av/hchjS68TVhS?=
 =?us-ascii?Q?irpr48kaZSuc37GIvS2d55Pbqqloi01t/qBzUVAE8ZwEbONYn+W5VzUOrBSw?=
 =?us-ascii?Q?UHSMr4be94uu6bV4jBpPFHk1tWF9yIY4u24ZeEHbSMDtGGhaWyoFXWivnwys?=
 =?us-ascii?Q?VosGDErypr8o7bkwP3OglDZPzyAK/OI3GZjJdmr2Grwq4qHCsSLepEZ3NqWK?=
 =?us-ascii?Q?D494DH/KhF4Pu+plB3+c+eYMQcTNzIO/rvlkL/3wWg567LSyIegFj+KB+q4p?=
 =?us-ascii?Q?z5OTluXvTD/NfPxy14s6SAHMDjcM7ReQ7tldE/JK/QJ6wsu32elbsnb8WI0q?=
 =?us-ascii?Q?Zxwfcr8SLY376Ci50AZmu3c/rn1U9lRYFhNAsE6hTDnosujIIF1C/M3fG0ym?=
 =?us-ascii?Q?L35X2fisjIDOQtMbOgDrEIboBEZ8Zf8PnAgoCGBfPBBaHbrp8KszfHJSFLPP?=
 =?us-ascii?Q?7sasDyx0mo1ZBtC7OijJ5WFWsJRq7UkJWXOSW4btDKikNOX3Hjz2rj31cv91?=
 =?us-ascii?Q?L4sOtijpRrDGvJI/bRKmgXB7G1q6mSt+DRMmwof6T1ZdO3TGzQWuyh/JRE9l?=
 =?us-ascii?Q?bZqJEE01/EJEpwqzmgSu0SNC/3WGeyUL2MT3b2MyKP6/a61/SRlSGlwhcOoa?=
 =?us-ascii?Q?cCsWwWc8jDsu15s8rUUOipzzO3v9V6nIWJRyXKluu/JWkLWJCP7kzYzvf8KM?=
 =?us-ascii?Q?YJ7LBvRSwFTuB0r4H742F3kJyu/Pb6VAeMHBTUfQ9/jgvmEML6c6aJtmiRVe?=
 =?us-ascii?Q?sCFFQgAvC+D5e56R63kFpW6WjHlUFAnv1g5CoNtL8STttCRL5xqvnZbDSh7g?=
 =?us-ascii?Q?LX7Wje2sXLRnNWtxmjg3k2oeP09gFCn7pxtOdYhc4xs728kyMju6eUvJUslS?=
 =?us-ascii?Q?RXcsjdxr0zyAPT7g7LcdQgAAKqEuXf4xcssN+kbtoyeqC87F0eMb5HXSrm+J?=
 =?us-ascii?Q?ev8gnBuiaDPeCRy2QFRZ1/kuZOz7K9ZOaKFbRj6SQ6rIWwi0W4/Yorcnjuf/?=
 =?us-ascii?Q?ZrovZtvUMuVP36gufHjuD/WJ3TLuDHixDnSI8tC2MvKi87/rW3t8WA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5254.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N0pgopzjwQvQam0CEeeSe1sDyNPfOfn0QS52Srp5F48h51DYc+3zfK9OL775?=
 =?us-ascii?Q?Ehp77Iltt4MNHBh0/tiQrJ5xNqnoyVuuPfhtO2w3BrQfpBD5cBatFFOC9ECb?=
 =?us-ascii?Q?AuKQ8KcwaAgTGOoTxzPlX6pBpJ/HT2zhSUvkISRjaE9wNQHA9rrADJKnzxNp?=
 =?us-ascii?Q?o+is8kmb9B2RphEvuStK2/ZW19em3BZAxRWRglIn/pNaNcTrWfsbsMpTMIQG?=
 =?us-ascii?Q?unZhkqVx3asB3rJyCkA0ujbGt2lO8NlLJU3QFVIasrkUiFYJKxtM25N3YgXx?=
 =?us-ascii?Q?Tpozv6cMPXoXkoUdG1MALqnut7+MXtDZsj5X+hMmygdlf6nscWeyUOiTXb5Z?=
 =?us-ascii?Q?La2mMi7BQo4EtAeMYXPSsrqP9fsM9TMOSi5kCI7pJI/d8sg/V7e+E8WhiJXj?=
 =?us-ascii?Q?wmkJKni3QRkQQnD9/EqcKIj9ang0zZ3zOcJqMesPysR9JZ6EIfEIbHE8jD6r?=
 =?us-ascii?Q?x38fH2gDMP75nowB+7kd4GQYmEX0hBHS8o7xbqpaxmIYA5i7G0FVjYFRHApq?=
 =?us-ascii?Q?yqZ5wraY6n3u1qHKE7H+SypE35ZUds4sCIbODcAHyWrdTGD8mOq4wmtITPTt?=
 =?us-ascii?Q?iNZfGkBMsSBQv2uFImUwhmQmNPmixVpMzz6x3UOa08E0I27w52qOCreMlwjY?=
 =?us-ascii?Q?iwVBexr/dRKp4DkZvBr/hmDvwZOr3TCevyiyHFHVcXGqCfq/DPU9Spc4gpHi?=
 =?us-ascii?Q?ImAkpdIIsHYQTHGo7IWhfJG8rgrLiSz0pu6AtRVzxmiBB1blk9OiiziTJlwl?=
 =?us-ascii?Q?suW74pFztsVInJUdtO/FANDfgTrgj5PpJXc7xeYc4mdaSdjz0cWVFU0o8K0g?=
 =?us-ascii?Q?H72zhqgZAhqnP8vMiixKwBk9J71YA9HEh74uWXQx6jWEHc/wakNlVRVfO5bU?=
 =?us-ascii?Q?GExK/GO7fyyHK7abdGKfH+c1vLSx45Me80WF6tmtIWIWF/ovKhseBi3UJnUj?=
 =?us-ascii?Q?oR3imZDfIbpPhxAFYkjiU7++PMzQcKxZPIOdM/0/uJ+eYnHMV6DyjZLtWV0b?=
 =?us-ascii?Q?oXC8uRNSW3qQ/w2DMkptO/sJ2ooMWVxqWv/FhHYbRbeA/HDF8maML7V3OVMd?=
 =?us-ascii?Q?yvpcmOKQhcYq68VKlxcbSz+k6F55BVlI6rFtvSMsqA1fl4EBumfNe9wMr6wa?=
 =?us-ascii?Q?0gWljAftHh+6MWzm+P2mcJB7/QOMr9Os2M9a9saRd4RrK7KulTvKl3P/GO2W?=
 =?us-ascii?Q?EdCrQsEZdgH19YoHePufFJ8C3dSVDHSEq6luRcwZ7TYAchaCHx6kINMMVvrS?=
 =?us-ascii?Q?4QAbF+g5Nro3/pC9AkfVsFWX6vLAc9xBm1v8tfGB20sE2w9vA6pv1cDkcYLs?=
 =?us-ascii?Q?GPcoPm1k3w5SGIbZPJ0L83a65A7Yr9ipbX1DSZciGU9dH1+dEUdrQ7zn757c?=
 =?us-ascii?Q?prTkHyCEaJaBWvUpfQnuhy1ZQrg7KB2rTPQYaZR/bSInwTb2+y04eLcRseUN?=
 =?us-ascii?Q?zNy3d7no117aj8WXpXFItXeW5Ni9367ODzLMbMgsv2nODNhd11sVjsw2uYtN?=
 =?us-ascii?Q?uYCEbe+3s56jVg1wl7OT7AvUoreOAEH76kPCzJCaf9rV3+JfsQ2FWfEJ0TT5?=
 =?us-ascii?Q?26sNjUaXjMZGV7Jh1ro=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57e630d-ce1f-41e4-12aa-08dd7e5862f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 09:07:03.8603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WKmXkl/KvtilLRuay0qVhwfF7YzBJAul7EPUi5Wq7lTZEcZRpMNNQjWB9jQXN8vxqWLQdEq2Qk8zqr77t4fCHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Friday, April 18, 2025 17:01
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd=
.com>
Subject: [PATCH] drm/amdgpu: Print kernel message when error logged by scru=
b

Print a kernel message when the scrub bit of status register is set to indi=
cate that errors are being logged by the scrub.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index b4ad163f42a7..3835f2592914 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -120,6 +120,9 @@ static void aca_smu_bank_dump(struct amdgpu_device *ade=
v, int idx, int total, st
        for (i =3D 0; i < ARRAY_SIZE(aca_regs); i++)
                RAS_EVENT_LOG(adev, event_id, HW_ERR "ACA[%02d/%02d].%s=3D0=
x%016llx\n",
                              idx + 1, total, aca_regs[i].name, bank->regs[=
aca_regs[i].reg_idx]);
+
+       if (ACA_REG__STATUS__SCRUB(bank->regs[ACA_REG_IDX_STATUS]))
+               RAS_EVENT_LOG(adev, event_id, HW_ERR "hardware error logged=
 by the
+scrubber\n");
 }

 static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum ac=
a_smu_type type,
--
2.34.1

