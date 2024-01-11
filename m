Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A19DC47077
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 05:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8B910E070;
	Thu, 11 Jan 2024 05:41:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D1AD10E070
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 05:41:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDmRhY70phgvxPt32qVZvWg6VTZVrAlLpug9YOtNLlAx47qZEjbD2gxRC46t3iER+I2U2u0xQME7G72DDXWVImL+/IQs17bireYZY/Ys+SR3Z4ATfnml+t7/DlIEYBmpfCdPAvIQaB1AK/FJFTOl4WEPaP/fJiWWaVN2uti/MH52qvks7Xzp0O4ydOkrXE2Hu91G0lYHWTF39DR1BCNuPwKs0Zt1pkgMBdERtguD5QpsPqIduexCZ8UwFYYV5glWV8QbDIZTJDZFrxJEr0Ti3P/otq26AeZDR15EhVqekOxfQyHWIxJZ2FL4/i9glBuGMhRT5Mt80P3zwQF2a4QtkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hD1XgaJuXl70hp2N6IWcNOm+M2xvDFzoxej3SBeB2nM=;
 b=MsIP4a0NKFA566qwm1OCoBoAw0BL5nw44ea0SB1DRyZfLwulV6C8GH+59/2sddQY837hZl7C1NPpBCGa7ZjHwmU1mulHWh1cRFSJgsHRnwuMWxejL+JqtYyg66cdOv3Hr6UAzJccCVWxiM1gV+3CzfZgMSEEY4G1+WfurCC9CAX5IoZnVPZf3Ct737f86GkBN0d/xmLLr5KpWLm0WJqHyGhBShAb9x7KvvniskorF7zxU3oGOLfW+mcSwRixZzAKSrDqACJ5oUOPXG13KImB6Kz1hqpHlT5kmQ3jUc889kBePUS8m3FnXpbK61Vxm04zQZQ67B++IJtG5wbkklFWYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hD1XgaJuXl70hp2N6IWcNOm+M2xvDFzoxej3SBeB2nM=;
 b=uD9+sB2TAq4md2UHRK0rNJCMTcBUuc/OdmaBzsI1pIAAiSjNRS/0ijiD6Cg5xvbzPHONPJm1mLFM3Jq5nM7O6nPLtn84i1X7c5tyreaj1Xa9df91V+nkF3OKw1nnzPF2Ge+Zxq05j1/8mCuy9UA3bUepbWJi0q67e1e7llHJgA0=
Received: from CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15)
 by DM4PR12MB5151.namprd12.prod.outlook.com (2603:10b6:5:392::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 05:41:30 +0000
Received: from CY5PR12MB6081.namprd12.prod.outlook.com
 ([fe80::9238:11b3:57b7:41b6]) by CY5PR12MB6081.namprd12.prod.outlook.com
 ([fe80::9238:11b3:57b7:41b6%6]) with mapi id 15.20.7159.026; Thu, 11 Jan 2024
 05:41:30 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Add error log for smu v13.0.6 reset
Thread-Topic: [PATCH] drm/amd/pm: Add error log for smu v13.0.6 reset
Thread-Index: AQHaREXDjKZBpS/NMk+XO40LNU4ewLDUGQeA
Date: Thu, 11 Jan 2024 05:41:30 +0000
Message-ID: <CY5PR12MB60810A9138C710414C48AC3A8E682@CY5PR12MB6081.namprd12.prod.outlook.com>
References: <20240111042148.120887-1-lijo.lazar@amd.com>
In-Reply-To: <20240111042148.120887-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c12f7fcd-23c7-404c-bd21-7a6faa9bff4a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-11T05:41:12Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6081:EE_|DM4PR12MB5151:EE_
x-ms-office365-filtering-correlation-id: 8e113e98-1239-4552-cffb-08dc1267f647
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T2owbS+Wicg7pm7zoPNm7FqGpIEnQmkyY7b+KxaBBX8inVmMr6RvnJ0lkb9ctNAuHwr91s9I7r+w+n1zJOqD7hxrNmiNoSebALBGZ3/OaSsyHx8MKRGuMktGlTIsEv0Uqy+oImxdJVChwwYoSP3zPd4RpJCtSWv73kLIWfdo+nXdYGobAX94YvWRbCBduHtwaazZGlYm86dXxqWZtK2aRK0zHIS01DJ0kSEla7U4CKtjKPBUVZKcrVMGARaF4J3jDFMLux8gGqqk5P5ucTbwQd/qedoG7EFELr4NQnXIBdvtmFez3qmF011ExwSGt13Vbe2asolJB8w6djMfnGWfH3tlUTJMFkzX/nqq2ZF7MLx5zDCIVG2ukqK6lLSf/gXkTO0HRIC/mNmHt+Q3dfMsln9x895DdDRYw7Gus90vcX4M0VYqo2kIgb6nB/pUqhFdFCOGL8LW0JO7FfxpDjn3JB1te5mvJUWhb4iHIgmLcq+KB5hX/A2tYA5VRzMoATXG0s3680My1YjpdNFb8nx49QFBKw8GzppJVDwfhUOgmrQ2AjrKKzHFQcJoIvsQGvR8vPAfdKcN1wq1+FD95w+maJoyA9CJmgXxt/xdxAyffFBDk78wZzUYXbNHkV1wg+pX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6081.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(2906002)(5660300002)(478600001)(52536014)(4326008)(38070700009)(38100700002)(66946007)(66476007)(316002)(76116006)(54906003)(64756008)(66446008)(110136005)(33656002)(66556008)(71200400001)(8676002)(7696005)(86362001)(9686003)(6506007)(53546011)(8936002)(41300700001)(83380400001)(26005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2eJ1HGHFXbSnXqiIZW4q32qhofeRM2ru7Mc+fHDkrIESGoNuwE3LR4TCqUgp?=
 =?us-ascii?Q?9y5dNL0dFSkO0LjejH8dcDbxNMc7BkSVXvNsI7wmtlePUksAZQoi8PPgiSoj?=
 =?us-ascii?Q?M2Kyo1BIn/QTMsW8nV7Cgi527pPeM4fbVCTa3urCfNak9W0a9/EozOW40txk?=
 =?us-ascii?Q?4xf4NfqHSp5RsKz1maTk6fMl7KROvLKcNdan1fmQKXDtDVYC7XNXKcI4TyOY?=
 =?us-ascii?Q?Ebclee6eWgRToS9XS7dDm2sS0aJy8shQReg9jXhB9VJvxd4HPO7Jk1UJvsEq?=
 =?us-ascii?Q?kjcXYln5Ibc0cZ1ePu+FU35cfrWciXhY9NSMxbVFRZkT4DQr117LbFDE9Fj/?=
 =?us-ascii?Q?aB5BQG1Pc35dDpo7DusBKn+vw3MGPLqvTRnUI0ipE6pm+ggFBgYajp+FmLDI?=
 =?us-ascii?Q?HYYE6rI4nd9meKM2daxJuR2T9HCB4EN4zP/st5PL1tpnlLghx4k1pIlmOtXm?=
 =?us-ascii?Q?hI6v0RWA+gRLDVATaZTrzh+YlqHJ7nJ1+TfyBscAihIowHys+GNydiMBGQjL?=
 =?us-ascii?Q?fu0f4M92OlUXh/iVQeOjJt8Oca14UWCy8R1NxUOnU/mxxjH7K2umTOpYNd3e?=
 =?us-ascii?Q?+vBbZqDibkTNsD2CW5JXHyF8IYuZqlgj0k/p742MSO08biLjQE2liDfE+5Bz?=
 =?us-ascii?Q?47bQw8HECJZ83H+VeUmNg8c9PwHmX/O7plSLyNHfex70ZNZqz0Lo2urdokQJ?=
 =?us-ascii?Q?c2muEDebfg3f4mth7hYKIc8FEygbEvS73q8ZsxKmnHikyW5hHwSCqnHRMBvo?=
 =?us-ascii?Q?g8G0esIUE8mb3crEEuR01PBudTPRsOEj3k1CnRRRu9M4roimFd7espVCifUh?=
 =?us-ascii?Q?qtjQ32zA0k8BvTVZkBDNYqc2qxFeLAyLHNRzJu8Ymc0ToudrEmMaSF1nUXGe?=
 =?us-ascii?Q?fQrKck02NKOjCYzyzoFZ55KLSW/D3cb39tgC0surk9wleK3H90lqNp5ZRMq9?=
 =?us-ascii?Q?wwkBthZxg+gjaf7v08g3QCdVDk4sTStB6cvScdZKcofpmA3jXDMf8vxUXXeQ?=
 =?us-ascii?Q?3ix8WzwUROZ/D5MzdAeRoQ5Vryy0oCHzODQ4NKZkE7R42cni7hgisf1tMEJp?=
 =?us-ascii?Q?eEmO7hYaVgK7NLrFVZSyZRFwkUOP4qT3lpKvb9XzV4Q+9mIqxg3d3s7UrWGv?=
 =?us-ascii?Q?zR/FfWQJ20IkXVXldAEGJQ4ZEDqMk483WPtWgc+mvahFihDnKTJc2TRHps7x?=
 =?us-ascii?Q?A0+w88NcdIlWU4syi6JwczAiq5yy1xoxxy0QsapaaYqbkWFkcsHsx74QwY66?=
 =?us-ascii?Q?qggeuK4PKeXudZwl3f+RlO6LUvKUML3eM61LSxwfU14scc89ls1PlE0HHi9O?=
 =?us-ascii?Q?Mj2m9XRxRGSpRtmpgbOI1fBu5mNSBipJLv///GTtD35TU5+aR0J9aUKv4HFu?=
 =?us-ascii?Q?TrhkOKs6T2rJwyNJOLiKJJl6gUMtt82qFbaq+ezOX5elR+ONyf5BWea+VwcQ?=
 =?us-ascii?Q?rnwQKSpUIm+Kv2P37xqi47BVBI7MMlm0WzMrnI6d3/40VfsZ7njyLyayxLX+?=
 =?us-ascii?Q?eQaStKOlVbxgZyhZafzvQDR0qkcXCEsBUY1hO3DhJ6IsepwYYsLCL7lVqT3q?=
 =?us-ascii?Q?nhil7D6s+qt0UjivaCg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6081.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e113e98-1239-4552-cffb-08dc1267f647
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 05:41:30.2470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JlewIehqmrYNpVeFuj7rXkXmyTjJlZbt2H6aF9794HYwP/tPrDT6vm6j79V+egkoYbKZ4UcxoBIur200/R8/ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5151
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, January 11, 2024 9:52 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Add error log for smu v13.0.6 reset

For all mode-2 reset fail cases, add error log.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 4ebc6b421c2c..7513d1cfeebd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2235,17 +2235,18 @@ static int smu_v13_0_6_mode2_reset(struct smu_conte=
xt *smu)
                        continue;
                }

-               if (ret) {
-                       dev_err(adev->dev,
-                               "failed to send mode2 message \tparam: 0x%0=
8x error code %d\n",
-                               SMU_RESET_MODE_2, ret);
+               if (ret)
                        goto out;
-               }
+
        } while (ret =3D=3D -ETIME && timeout);

 out:
        mutex_unlock(&smu->message_lock);

+       if (ret)
+               dev_err(adev->dev, "failed to send mode2 reset, error code =
%d",
+                       ret);
+
        return ret;
 }

--
2.25.1

