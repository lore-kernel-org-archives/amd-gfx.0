Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43092C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 14:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9527910E193;
	Thu, 13 Jan 2022 14:46:31 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2053.outbound.protection.outlook.com [40.107.96.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAF5910E193
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 14:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHCVA91THXbZm9UR7dym43II9VTMrvpmrDe2KHzwkp+FjR+3nxwHSiCna4s202pJ9GjSOiJoiYOMRYq5TKc6YozNR0BA/XMEzmJP4y1WwepPnnQXNpAV0bOOJHBfcg8HzUcdfN1OBDAZaelrf4+KHniQVA78Gs5ndzI2vERh5SmBCCtDI/2KnAIx9uIDaFDagqcC6rv6M920n5YyTQw0yTjvHd3ULrvTr2UwYkQWMe7CKyVA13+c+pNjIYhkUqcId5sRWaWITjLLhsu4LEZzAhMqelopPGAaiz8oiv8YhpjKpze3zHzSad3vvmSM36jt3/S6GHBbnbEuy/rirf7ULA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrL1TLNkmflLPnAm9OiMW1mXbouNM+uuSvPqB+XPDoE=;
 b=WOj4hobwwhW5MGEB43UhNfhp07Wkwircw21+Hfgx2PntJ0bwCzIFxYH5x4U/vGUPEXSJcD6s5Ex6Xo7A+TgVkCo4fBz/o6t6GiI8d3pe/fymYTkSuYGIQ14tCyeStgAeN+4/UFQqWhuFZcOcj4XeNd3qFwtJD6NRrXBK72HeAoUIkA6mf7vUaGHenh/HK8+s2Msu/LxTXFPDSFYQsAY2g80Rq2KP5XYct2hZrC25Eh0Qx9ZgJFeowXkPhF/RbqsdmCJJAF5RlzH7cjoru8r1YjD68TBhSBIrkis66kiAW80+MT0/OzwQ26JAvdxf/dgSIKFk3qkR2DmXwbHTVwEQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrL1TLNkmflLPnAm9OiMW1mXbouNM+uuSvPqB+XPDoE=;
 b=u+ZpJaoAz6nAqDf1zhGiTDtrMbekI2b7OSEVGQpwYZwb4ZJA3/taJEspqS1MgsF+GN/QL/MrLIeMJuymT7TmBVwW/7HDUeGRWoGJJJAxBH2Fr/R8U6T8Tosw4/IAmX7VtkvYaoLL/YXcpq8nHYAqhBsMbk0lYo/0/Sjb2OgDR7k=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB1449.namprd12.prod.outlook.com (2603:10b6:4:10::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Thu, 13 Jan 2022 14:46:27 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::1500:4b8c:efd6:672]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::1500:4b8c:efd6:672%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 14:46:27 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: handle denied inject error into
 critical regions v2
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: handle denied inject error into
 critical regions v2
Thread-Index: AQHYCBznyR1ITmabEEWJHqLV/ufXBKxhB8Kw
Date: Thu, 13 Jan 2022 14:46:27 +0000
Message-ID: <DM5PR12MB2469DEBEF7B5FC19CD38BCBCF1539@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220113012829.27726-1-Stanley.Yang@amd.com>
In-Reply-To: <20220113012829.27726-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-13T14:44:53Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6ce3b282-f96e-41e1-a6fc-56ad6df12118;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-13T14:46:23Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 0f5cb092-194f-4cc2-a967-ba39b5bab585
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a3de5b7-c9ad-433c-7fe7-08d9d6a37ab5
x-ms-traffictypediagnostic: DM5PR12MB1449:EE_
x-microsoft-antispam-prvs: <DM5PR12MB144965B3FCD0DDBC1BAA430CF1539@DM5PR12MB1449.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:254;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ieQr/SovS6FpT1uAmgS32OTyN1uWh0wNUWASusxdjMdE1pI5q5RdatTD59SQi3OBijAfXC7i4PEw0zYEa/1SJSfrx8tSSMu5ABAzSOd247TBBqJLkyDd1Zjy2VnDCTev61UX5XmBNT2juNLHfCziaolIiefwtvvJOCRim7Zx9uwIENY+i/WTmiw0T05Nz8+ssNtDjPEhrVSf3zENX5DhE4jw64C3lU3I0PBhBAxHXMPFrliATu8ALfgJCTpXqKjaOXZAIIOL/pT2nQzXf+LzOmmqZpeCERTIZ63p5YfP40G0yN4Bz7+ScihMquib8qACskx3HaBZQz8aMhC9sa4FJ/KoYujLrSKHgZ15BOwf+bBZSbG3Tv1G/UJKrX0HrKn27zVuVd/U8UVdwnBROnG8OEqQAR6/9AbpxyQCaUDGRQvlqBFuLl5uQ/7cMMKvkXtv+aG7jx8UDBEOBuDKL0iyi9Z7k2zArdpg2NFGBdOi614IXi4ySgEcsqkLr1AkKMXOol9lhMJn9QqDwnriM4dDU+VSGns+26lUf5PGY7Ot3+56uW0S/p/dODpqkYGB8GbS8Fv9qJaSyosxKUeNVIoWKBD/GojF3musvVvC8y7PYRVQJUhvJ/S48NH1wRCrLyKoR/YLchR+JK1zO2aYsTAU3mfLtkB3z1ftpzYPDTyw9ojvBIJ2R+BEvAFBK8aZiYeWygfeYqF45X4YCDeJYbA4fw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(52536014)(38070700005)(86362001)(66946007)(8676002)(4326008)(508600001)(9686003)(76116006)(71200400001)(66476007)(38100700002)(8936002)(55016003)(54906003)(5660300002)(316002)(83380400001)(7696005)(33656002)(186003)(122000001)(66446008)(110136005)(53546011)(26005)(64756008)(66556008)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PARG/GtKWekTbtNX7EFnEZ7xlQBcs0svL5LZh5ukOu6JDfLa2MNPiJvuYYcs?=
 =?us-ascii?Q?JieTg0HcxHUNEjM6nspq1+E8DH2ZK+nmqLG1Tof/dhasoYzg1VVINIYWLtbZ?=
 =?us-ascii?Q?p6f4ygqtbPSXeDhweygOZdaIkzPN++LufOvja0TdrNkH4ZuEL45fHBCNy+Mu?=
 =?us-ascii?Q?EMzuCYT438QzGfVZG/loFxfyQSZGlMIaYY2KQtx6pvEHRewdborukGljlkFR?=
 =?us-ascii?Q?7eDj0rgJCRryHsacobGFAkPJ7/0MZk+BghfqICEOKHtthdvf0IFrBKU/xoOf?=
 =?us-ascii?Q?sHcNsF3RaKj8e+r3waiX6N0aEakIKKzC9oxSiaWiF1SXfFURPH9V50iaYtOi?=
 =?us-ascii?Q?UWceYfNKFSKyTgM3pmSwz17kMbK5ZDGMkbDlDmbx0cvHT+1nJjgzDUfSIEsD?=
 =?us-ascii?Q?lGR7YhZj6M7WU+pnSdOoBTewouXQtHwN5EzoIv8Zw7YB/CnzKJnUlqhAKipB?=
 =?us-ascii?Q?cUCFl7qDs/TQkze4m3NZxSqkDgBM6czG5aTtvpC/flEeJLk/D7SAftagbEaf?=
 =?us-ascii?Q?k/PEGStvMLWFV6TV+LzPc6zIa8IvVO6ac3bH1MmsqZKkroKKCWKSJg/9LekC?=
 =?us-ascii?Q?US7/uhDUtzywapvPrHA0C45RrEHkUqCo0ihtGmYs8SifjtsWu0gFhVxwRZY2?=
 =?us-ascii?Q?taEOGVBYR8crssDQmP0DnImJLhlYgms0lFeHAv26b/CxIraINe3C3r3hSU7L?=
 =?us-ascii?Q?xe/bYE+KLoa8AsFWkRcy2fp7Ln/k+gB0fyzVCez37og+RfwKEvV+iLu2hcGB?=
 =?us-ascii?Q?gm6ymAkWKMWA7ZwNpE2hGteJeEtjoq3Wb9Rjx8Iiz28MeXQU70rwxFr6wM9m?=
 =?us-ascii?Q?+U5iNcvoI4pPU92LqsRySbwMkn6bOj7BOpwq/+1uD+LkEJZWIZqutu9YbhnR?=
 =?us-ascii?Q?nXNMhrf9fHWj3JOiCUMIrFNO/Agp4GdxD+NeWy7ZsS9TqiirBHZZS+BNJ3Nd?=
 =?us-ascii?Q?N6AdMk5Vqb13aYvt/DWK3RXL6zvToaWhpvEcutTgWFzcZo5Tv46STIGXD8BM?=
 =?us-ascii?Q?I9eNiw3ztxZIiRGCSTTUPchUAOh9IoE+cVD0LPZbqRm1dV2tTaf8cd+OXHrD?=
 =?us-ascii?Q?Y/JgNwK+lZsThipzW2oAYCBqYolGHmcZKB0kvYtRwxDAFFXX378eaoTDalMn?=
 =?us-ascii?Q?y73VNLf2mbUT1gGwfN83Rt3eswdXgpYJ+89MwT5cQodAe715H+C3+FC74UMa?=
 =?us-ascii?Q?ByVhODGeOl01YyKzhEYV/mG2EvcMXfW9zSBCAPBWZ1FiuGjQeiHG091O3Rh6?=
 =?us-ascii?Q?syU9WMm2DF9hf9Tbmua0aoYxdmrtVCnveSCuFwG1rO1zE3FWfexDt4nZSEBN?=
 =?us-ascii?Q?izYK864RVj1Ll+YlGvJDQCBmSOT60ilspxRmGe+gZG+tbs5Hg8387aAo7EOz?=
 =?us-ascii?Q?9IYuz6cuSUggmcod/ZIsaJJ4HFxLGi4hcRHyLwzUSKWC+UMR616TaVADIwLL?=
 =?us-ascii?Q?ebtczVq2pm/Uo4L2sRjbWOKMnO8DlNqqPIlNDgjj7oed0cM7ARU2lBXv2IM+?=
 =?us-ascii?Q?lKLkRPEODWy5DCq/Ys3BUowSD3+fcATvu37ZqzFpA8lfMJ71waAk8JThaC+V?=
 =?us-ascii?Q?0TQ2HhN+GfzQVFpWHTFdr4iMEd2l1zaJeVNykqw7SNo3/1RDzqRgKv3cb4/H?=
 =?us-ascii?Q?hErQ2Ca9EPJEmOClM7SAk/w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3de5b7-c9ad-433c-7fe7-08d9d6a37ab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 14:46:27.5895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lDZvTV4jkJiAfBD07+be75i01iQWYlZuQdBRKdaygbBoX8RONRcA/K5TuiJXd9GPWpbkjzOl4KPjJxiZtjCxlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

I guess you still need to add a commit description in v2.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.=
Yang
Sent: Thursday, January 13, 2022 9:28 AM
To: amd-gfx@lists.freedesktop.org
Cc: Yang, Stanley <Stanley.Yang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; C=
lements, John <John.Clements@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.co=
m>
Subject: [PATCH Review 1/1] drm/amdgpu: handle denied inject error into cri=
tical regions v2

Changed from v1:
    remove unused brace

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 9 ++++++++-  drivers/gpu/drm/amd=
/amdgpu/amdgpu_ras.c | 2 +-  drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  | 3 ++=
-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index c742d1aacf5a..144176779f9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1309,6 +1309,11 @@ static void psp_ras_ta_check_status(struct psp_conte=
xt *psp)
 		break;
 	case TA_RAS_STATUS__SUCCESS:
 		break;
+	case TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED:
+		if (ras_cmd->cmd_id =3D=3D TA_RAS_COMMAND__TRIGGER_ERROR)
+			dev_warn(psp->adev->dev,
+					"RAS INFO: Inject error to critical region is not allowed\n");
+		break;
 	default:
 		dev_warn(psp->adev->dev,
 				"RAS WARNING: ras status =3D 0x%X\n", ras_cmd->ras_status); @@ -1521,7=
 +1526,9 @@ int psp_ras_trigger_error(struct psp_context *psp,
 	if (amdgpu_ras_intr_triggered())
 		return 0;
=20
-	if (ras_cmd->ras_status)
+	if (ras_cmd->ras_status =3D=3D TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED)
+		return -EACCES;
+	else if (ras_cmd->ras_status)
 		return -EINVAL;
=20
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index e674dbed3615..8bdc2e85cb20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -449,7 +449,7 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct fil=
e *f,
 	}
=20
 	if (ret)
-		return -EINVAL;
+		return ret;
=20
 	return size;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/a=
mdgpu/ta_ras_if.h
index 5093826a43d1..509d8a1945eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -64,7 +64,8 @@ enum ta_ras_status {
 	TA_RAS_STATUS__ERROR_PCS_STATE_ERROR            =3D 0xA016,
 	TA_RAS_STATUS__ERROR_PCS_STATE_HANG             =3D 0xA017,
 	TA_RAS_STATUS__ERROR_PCS_STATE_UNKNOWN          =3D 0xA018,
-	TA_RAS_STATUS__ERROR_UNSUPPORTED_ERROR_INJ      =3D 0xA019
+	TA_RAS_STATUS__ERROR_UNSUPPORTED_ERROR_INJ      =3D 0xA019,
+	TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED          =3D 0xA01A
 };
=20
 enum ta_ras_block {
--
2.17.1
