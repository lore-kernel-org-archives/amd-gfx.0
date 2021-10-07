Return-Path: <SRS0=WxFm=O3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1515C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 14:09:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5293B61075
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 14:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5293B61075
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D87C06F49B;
	Thu,  7 Oct 2021 14:09:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A32C26F4A3
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Oct 2021 14:09:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZpHSNSWJC4tEKGBProLqEA7YgCU9Z1PfWXN7RGO5+zDHQhbe0tkGWVyzEpbcQ5iLLNrszRbH7s9i5FW74MW06LeGbl+l+TETdEEJyw1bWna3EmqRHrUUElU2zyGAOIFCZRexJey5UDPJEOkqMY4B7iTblMjlnK+PEIljbsl14EdptQpGmL9DHX0AOOiiIlGJCLXOBOKGc4WM8B/T6itgfE5kX34dTOEmxf3JvrK8ch/QG0l9sByAgmTqjeoM66/sCt41WdeXD2DGNgVkKBa1wWPr46euBk4GmjJBHy1WdVEWgN4dg8LlcwqgcxARYx5sTxypoj+UXyieIyF/B5z1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IO2vFyCW+cohpLca/r/F06HEhjRMvrl+dwv7t+uim6U=;
 b=f9iIKnRWPB1zDa6ZRhYICn3wlIzo4++qEvsDtRtE0FB8hfVYXT+UhCcEwsU4KqHLe6yAV6NA26BkZP27tgGGkDwTdwYOJz8d4p5XTO//EOYoMY1TzTeJoQXWBC2MMvVrqzkaOs0u2GSoC5uWmt+tnWwB8UEaRjq3uddozs1ieCCmFelRmRF2XAGzRpWXxK1Y2SK61FcLRA5QqKF+CY3d9helJxrp5JX3vTVvlISujIBFHNhath/OJ/Kb9WWzT+dHEpbS4vekqc8eoXmEACMk7ei2xLhK5BfrNTGrqQsX9bAAmuO23CeBeSSeh2QB/XbOran4uiYqnAn6h+yTjOy+9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IO2vFyCW+cohpLca/r/F06HEhjRMvrl+dwv7t+uim6U=;
 b=ImbeNuWLfnRnDqx93xwg4rWjR52OQrLiOjkG9EkKmPPCBcTBxPI9HErNnC+AOCYow06A/YUMlBkJTA6ZUoqcTCGHaD2t59H0gMMk1DenqoGayPiC7TbYOmVMHkvRYRnX1VPrIYhbA1yeDJV5I69eNugPeGT87G2Y3E8K8dYltK0=
Received: from BL0PR12MB2465.namprd12.prod.outlook.com (2603:10b6:207:45::18)
 by BL0PR12MB2339.namprd12.prod.outlook.com (2603:10b6:207:4e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Thu, 7 Oct
 2021 14:09:45 +0000
Received: from BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::3d65:6448:1d68:20dd]) by BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::3d65:6448:1d68:20dd%3]) with mapi id 15.20.4587.018; Thu, 7 Oct 2021
 14:09:45 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/discovery: add missing case for SMU 11.0.5
Thread-Topic: [PATCH] drm/amdgpu/discovery: add missing case for SMU 11.0.5
Thread-Index: AQHXu4R4T1c932VsgkawEV3CpBjzsavHkrvQ
Date: Thu, 7 Oct 2021 14:09:45 +0000
Message-ID: <BL0PR12MB2465D03D2A1B2A47287DBF81F1B19@BL0PR12MB2465.namprd12.prod.outlook.com>
References: <20211007140540.223897-1-alexander.deucher@amd.com>
In-Reply-To: <20211007140540.223897-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-07T14:09:42Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=02181ca3-75b7-4d02-bb57-bb080667f0fb;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d133c258-ed5b-4f59-6d9e-08d9899c1d66
x-ms-traffictypediagnostic: BL0PR12MB2339:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB23394FF1C4E11624C1E65DF0F1B19@BL0PR12MB2339.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5reYjY3K4eJbfy+6ijFvlXs0rrTzj0axwNPOZoAjrpNmm9m5sRxPXIkZlmucKy2ahPZK5KBl1j95/+zyipBtlWKsDQu+aU0qtQ+aPd181RALeMxTqe8j+etP+i+IQ59s3jNcS0PP0maM5000dj90kMQ/e4I8W8tFtMywaJ3hbYpwrxhjzNfuF23iHpFs2jAdrkz56dqwYb93xg8H1hUcMtbDwgrowBw2ylyDaGc8RT6NavMYMcTYlldA2/qtrFbLOdK02mrhQCx1EU16d3O7adyfJPw/pNrZvRJd5ZT2H0FGzwWnStBzx0bnsOCMO7Whxofgm594jMFISnqfQVd1NcYse33uHe1xWzhtlkJa7VSWPnrRUqhSG8w9ebxjiendeV7Ipp++I6LBtC8VWwtRt41RTqIn5SohgbcTdd0V7DZYPxc5EIDiH1ABjrqjYB49pyo/z36O+lgfEEpQzMwOAq13KhqtpOtVQAZ1p8fseNFiO2eRgsPYkI+fqFXa3tEfFVsjHWVvXdhh+16OFs34UEBNOnXJrmOm9Rb5iV3VIdJzRF0uDN78oLdbfLDuOISNxMW0bcZg0o/zcVFoh5R2NIBLTQW5ghGxOq52178m47JBQAirJne79VinsHOzsPy8tZ1mPh+8C0ybF86D10+3pIB4rtjfJ8n6AHulMf8PQZsvykw598lGS82SjsdHxSoh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2465.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(2906002)(71200400001)(83380400001)(4326008)(7696005)(186003)(8936002)(8676002)(64756008)(66946007)(6506007)(26005)(76116006)(52536014)(66476007)(66446008)(66556008)(53546011)(122000001)(38100700002)(9686003)(33656002)(55016002)(5660300002)(316002)(86362001)(110136005)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/R3EUcw8Kbi4moZR68wi+dtTEkKXcumkRTh8YOzbnxlV3QEQt47qC5ewGpH5?=
 =?us-ascii?Q?TsTCGzkhoOoekXpdwLxCG4QJbdCzHcT7bt5AZIM6nEs0+y+wHdrG65sU3sPu?=
 =?us-ascii?Q?72Ov7OBxSnqtf6AKdv9JrMnrFpEayqmwBE95VEylrMkbC01sSIfYpmVQwGvc?=
 =?us-ascii?Q?v2wAePamB+5PQIbhbzCvQvnA90ZDQ8U3g1n6nDL4SAlgqe1BeyP0gMnHqffh?=
 =?us-ascii?Q?RjQjN1w1FFtYMJcw2S3QOe96dHsAjw8h0Bk+FGHWdM/BDwpwJLZhVdNdt25P?=
 =?us-ascii?Q?jhmgj4L8JWRjxW5xMVmsaA5G3V6wol/DsvLo+qpw9Ashkux1aW7JWcK8tJbw?=
 =?us-ascii?Q?OW6JpDhGPQFi+iz8EeoSdfYqyzAHly/USUMOteL5nZmAbBgDaLR3kqQEiiex?=
 =?us-ascii?Q?s0pqlnYLOoi1kbpJGP8tTMXnrbc+fgyJP/M8vG1t28pqkrs/cytuwiz2COkx?=
 =?us-ascii?Q?jo6UE5Yajm/3aQ4dRHEU0UYx6qEUBUUd9rvw/CHdy9fQ2T9pdB3PyTl1J8tG?=
 =?us-ascii?Q?UY+vVMjlbxjuQaE6LqaslQiOUnweKXCdR40tuLraOsavrZBOkBocmXfVac4D?=
 =?us-ascii?Q?PzhAE/9F9lRL+x5StDR19KwfoasWcub0bIJRUY9TOGUMQ8WSBGshdivN5NXp?=
 =?us-ascii?Q?Ny7nQt0VIvz4FPVgu2d7klrxA27CxOvhwde1hqHihQVkFxSaEeRFLBRDFZ/I?=
 =?us-ascii?Q?er0o9eZ555RBlIgRb1cpAY5q93Di7xkzlaKEgcWSlND6r192nOkDF5L42zUD?=
 =?us-ascii?Q?+OEspDo4GsHUqqPlpvzYPq1PiwwsYGBMj2hyz5GjG13LWda4bOIrs+m9G8iQ?=
 =?us-ascii?Q?QMOKs3tsaHkU8DUoPVUsRV/fRl6lvk85jIqELbq8Ek9/nFDFLGV4yUrEXtAm?=
 =?us-ascii?Q?BLe5UC8Q1Dbd8aIya9OzAeVRCe+e253VBn8Ty9HGTsCnC3sgL59vsmi15QgI?=
 =?us-ascii?Q?Id1ZV/Vie8Dc1wMKeOzmMVY55I81HtQxwqTHSiNZfgGyx5mkZZB8vwWUzydz?=
 =?us-ascii?Q?lTAiZkOQumeXi/M6UVyo00ICPidP/W1YbsmaKdU+amwnR3x4asd5yTZKpZDl?=
 =?us-ascii?Q?xvS86veAAK2WI0LP477f7bh15PtOByuiIdC2IGY+ZbXQC34xUjdiTxN+NeEp?=
 =?us-ascii?Q?bcDjkKFUtBEMFXY62Hi3dWuZ/SpewLBpF35maN2g9YDkvQFeGh4xevcMY+Hz?=
 =?us-ascii?Q?pCE01g64QpEMzSxzXRGwC7nCQ4pr2mArAz3M4PIKIq7E2jhpYuSrYkcumu40?=
 =?us-ascii?Q?/9uuUJS/9kPDCPHI0BdIDyUOVbIks6hjxRHK58sj5oi8QyBvJMFOkej3/2oI?=
 =?us-ascii?Q?9LWS6SClmoQt6Oda8apXwXTc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d133c258-ed5b-4f59-6d9e-08d9899c1d66
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 14:09:45.0391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hDerzbDU5KnpdzaURGghPV86bc29jIRy96NN5jgLFlCAFuwAzT6GmaX+WtAO5rrWWkTPRhVCyYxQf10s8KZVng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2339
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

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Thursday, October 7, 2021 10:06 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/discovery: add missing case for SMU 11.0.5

Was missed when converting the driver over to IP based initialization.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index daa798c5b882..90d7de17d81c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -700,6 +700,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct am=
dgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &pp_smu_ip_block);
 		break;
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 5):
 	case IP_VERSION(11, 0, 9):
 	case IP_VERSION(11, 0, 7):
 	case IP_VERSION(11, 0, 8):
--
2.31.1
