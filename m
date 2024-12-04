Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4482E7716D
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 05:30:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6365210EBE1;
	Wed,  4 Dec 2024 05:30:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q1MgAzQj";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE69A10EBE1
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 05:30:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MngAIIZ+78MGm12D5DDCFPhPwch9qe+SEybsB160SY1VQLNiuVctuIJEO93COaf9cDDFIa4JAnJvGENo4zkpfs8EDTmLDHe0DxFJQO8S8s64gmT+DHb10CpG7MhThnAd3g0WLhjREaB5096JWS+IMcjaDPnOgrVzO5O9QBdAIda1sAeCA0dmy9+5WtQz9QLoWbqCgBRb4fMCTMP2HZHhe8Jk2S6/+FX0anhBYiFj0dcQZRb7sBxcftJkvyaReL9eXUZNTzxJvH5uIZynzeXz4MjqAp2B00Op7Lvcu9lrlHx6oK+xYeOA7yL08vGB7b76JjOsm1bSCJpnlFggnI/cgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8W+iO3Gp3K5iN2X6DGeK4As+G+HajZptqBHorZuiOc=;
 b=mhi5QxtAaVWiUCNxtcLJdVGue8Ed+5M01+gto2RAwu5HwQYD1P3698r2MGcf49al8WPCSSlrPNAy5MuxT3BtVrP+w6sFwSKxWdn4J0tGJwLqwgyGbAkmVBA66fdq/536D1GgHa64pCiTbelqXo6IalL1rgVAAMP7pCW79VfwMG+sp1z7i4/eOCA4/UlHtdb7LHu+roTgJLKV0/mw1NJ8pb1zsmuGvtDGxjVtvmpCvfl6gCLSLP2drqTflZfVu2lYWRo0kX9t+VFSWGoDnWpIFuRT6od6aF1FJtcO/zlQDgfQ01PsbkNU97BMStl+Tsb6enFCJyfdlyuNl/ShmA3jEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8W+iO3Gp3K5iN2X6DGeK4As+G+HajZptqBHorZuiOc=;
 b=Q1MgAzQjQabdrLSaXXGcsfZVSce6XT0kjNuKTyjbBwN6rHra4MSuBbUvsUNA+qZn/cRc+DsaLZWWAiM5uwLzrX2eAXKtUMCPuDvlqegnuwTuOQznLLoEbk+hrobsP41wL4Nw88rTqzHskUt/JpdJrYpuDCKOwxjCopWG0z+HIFg=
Received: from CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 05:30:36 +0000
Received: from CY5PR12MB6081.namprd12.prod.outlook.com
 ([fe80::4d96:5711:76db:6e37]) by CY5PR12MB6081.namprd12.prod.outlook.com
 ([fe80::4d96:5711:76db:6e37%7]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 05:30:36 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Increase FRU File Id buffer size
Thread-Topic: [PATCH] drm/amdgpu: Increase FRU File Id buffer size
Thread-Index: AQHbRgQbrOuzvFZcAk2FZnXN53H2xLLVjzKQ
Date: Wed, 4 Dec 2024 05:30:36 +0000
Message-ID: <CY5PR12MB6081A6092E9445E5438F4AF28E372@CY5PR12MB6081.namprd12.prod.outlook.com>
References: <20241204042155.3494660-1-lijo.lazar@amd.com>
In-Reply-To: <20241204042155.3494660-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8413e4ac-c528-4a57-be42-dd9da7a42265;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-04T05:30:22Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6081:EE_|DM4PR12MB6496:EE_
x-ms-office365-filtering-correlation-id: debe279c-0aed-4653-bd60-08dd1424c81d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rb9uo4n8Zj5z6airyURbiIEe6EOZRrQhgRcWafNV+bGKCiGO3ytniiZXI2IZ?=
 =?us-ascii?Q?7r/Hehvh5R0GepVHQ/xZXYzgCChaFwRNfPr8vPE33pw+UYyL8U9fnusO0VX8?=
 =?us-ascii?Q?TtCDf4j5YNe2iC+gdOBCYYkYljpniQykHCumthkp3st+/VS6k58TLajOzmoO?=
 =?us-ascii?Q?YNQYT75iebMrV7aN0zfl5TXNsFhJ9VqF4lJBUgskssabaY8een2lQGNNY9q9?=
 =?us-ascii?Q?rxdU5k7tz2k/FsijEUZRtgk3NPySjY0DRqOqNHCsqRBlG7PAxZ66FOO8P9Kk?=
 =?us-ascii?Q?BnEe/PTuETvuQh6trC3mDjia73ofuygQt0ES8TWQegTpioKbP3fUOXLxN8h3?=
 =?us-ascii?Q?auE8D+mV4UBn7jA9TTuPDojRWn+A/zv93IwWeQ6CK5gZx+924EYbatSItglp?=
 =?us-ascii?Q?guBA6tIauL9QOUjxD+xBRsSj5n9GBfUX7p5M2mqDeMXSeeqI98aD2pv6aUU4?=
 =?us-ascii?Q?S1C6DH9sjp3IOTUgKsRg66VguKR8nwyvmm/lo2qZKFdCt3lNywq8FdaBWyOx?=
 =?us-ascii?Q?bYUpKActVLuhdt0bMzFyMHs7f7cqC90i7TTi6u4XhY3dAWveej0Bvz8wqEOA?=
 =?us-ascii?Q?Ey65d5PpeyAh1SRQmwe4OjIz4dY1SaxHtPzPZQqhyU/+wBx8j4BOt3C6DWIQ?=
 =?us-ascii?Q?GnVKjAPuprouFKfY5JJczVhnJxZ447Jj0n0snDo6IFdXFcy4IXjTy3xAsZoO?=
 =?us-ascii?Q?gn1IdQHMzRGmWAAP8e8y1QxdyulC3p68us9BV10wWF+6IgcaE0Mb00Z+uG5F?=
 =?us-ascii?Q?5xWHVk9A8DoUyKJtFcsFq33pFEQJle9yZowAfbIcF3qqOuW/Y4n5l3gkaPYC?=
 =?us-ascii?Q?oUnU3YPOMIotvLv3wkqYK2O0eOWHjpmNaa2MszhMUuJ+F2s2Wx/mpqVDu7fu?=
 =?us-ascii?Q?NJzdqUIvLJqVj8N+RlmDi05cfh9HMBs39PLYjzsCt5HQLIn49RNovrXT/1vt?=
 =?us-ascii?Q?I71/06kMkQ9Y0s8Wt3VHO240PqkeYtIXI23wqR+9m6H9EVkcyYLIh8FOr5K9?=
 =?us-ascii?Q?FPR1bwLcvNeHkKiOBZDZ26waEvNiUHPVuEmIX902wVCvcQcAmsEws6E+26KP?=
 =?us-ascii?Q?9TVu7w2B5ZhPOFxBVNQDyeRaL4UIbk/s8OOcfp3P4x3P8YZv8u0cfqE0C5w5?=
 =?us-ascii?Q?tJeNTJ+vKjGdxmqVRG6C3U1hk8ya9aq+mx5BNECMI9r/1C7gFNVtE+mZ2BO1?=
 =?us-ascii?Q?M/aNdcW1h2ddxmRP0ED3fRdrPhgJEW2Z4QdPA0q6Xffac5L7nGLFowWlkPwi?=
 =?us-ascii?Q?CRy7Y72xoEG1Izof4dx6osGYgTvBYhlE9faoEwMW2GjSJC9PcrTbeFyugM+k?=
 =?us-ascii?Q?NM28wCwQf1sOfZCK+3lrlvAmVD6lonwl28E1U2zfiJcUy6PsvQ2ugGf7s4Yw?=
 =?us-ascii?Q?SXRtcDXk/c5EfUy7eG4baerkiRuNy6+yRFwsshGhM/8Tf+p0PQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6081.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?loDLc5Fu7nzpwZLXNDOeWajd2wj636M5gqnXAIUPI7A/GKNeDjCZiGqHDHks?=
 =?us-ascii?Q?P7NIq7VME017mU2AU52rvBW+tAiWIiRv8A7+nz1GldiVjgAjrPXCNRW+/fOQ?=
 =?us-ascii?Q?yO/rfW7N0pD13df82MYBuPol37LZFfPravBiD0U10qYKuj6k/ZQG54B//aTO?=
 =?us-ascii?Q?r7Zjj5yD48ZzhsrgKL/vWFdspeTFDfWOagQ8CzirG9TI1/7UsLGDdmOJDOR/?=
 =?us-ascii?Q?zxbXrtc7WwHPArTcU69IJ6fC2cCslTP95iibdOu3FfDjeKun/anPkDAXS6H6?=
 =?us-ascii?Q?G0rkPIel5cK+JE3uov6SYzSZVlvhqRAHGpMveyxVIZgwW0GMZc50p9JkLBDa?=
 =?us-ascii?Q?Uhu4LJ4CbEE4hJNseJBA86rmAdClIwqExAG6CoG4QDxjDixxPRUyowBpSUVT?=
 =?us-ascii?Q?DwGfMrZaakoHMiJKJL8GQh7cBbi6cey/ZaE5vZB6vT1Tik2BHgT9pzCtRBiy?=
 =?us-ascii?Q?uFygyrf2wxcvTpp6Pnh3DKIGu2zOHuG0ZMnoN4AlrGu+2n/Dd3ytqRtpBIVD?=
 =?us-ascii?Q?7WxK9aIf83F/QUwhSeFYY7SE+LFFuJ9l30MGhz6LRx1/7lTaGT7nra6OOm1a?=
 =?us-ascii?Q?ueufq/qTl/33p8OzwL7tEoykBBZ5TuKWeJkTxkSVmagHJZr5pTGlCXIK2liE?=
 =?us-ascii?Q?9z7sgirimbecvUYWrIjNpucSJ5UH/Pk08Jk7B/mFXf8rQq0TNizJsBBuvifQ?=
 =?us-ascii?Q?4JhQ6qRLlcOaf1iSf+Dmj986ydGR+CIBJCLRdcaKO5XLjgvukIxuqJKps4X8?=
 =?us-ascii?Q?iaha7F56cINMUTveoyHwYdR+baRVc9miO6Ed3cOa1kT5bs7UY/HT0Th0OC9G?=
 =?us-ascii?Q?h+A/q787hbXNl7T8u9Jui28C3o6r8XLS2uqDSPCQMNXUirWJKMsU6PZoUk6w?=
 =?us-ascii?Q?sTw367Ete+DKlJM4VNiB8VMe8KwsEHfC1o2j5o2wDX7hDnLUGbbUrBi1G4Vu?=
 =?us-ascii?Q?JEqm/LMKwWGjo8/r96QxG1wpqJFq9mrJJaQkVJdW//OcxKKILsIaOjpBqCBh?=
 =?us-ascii?Q?vaqzsFJ6noJLR7PmHLMuF9mgnh5hGk9j2iv7I0G8HOFTziGljmQkXkVTJKeh?=
 =?us-ascii?Q?uGLsAX+AuIaDLxZ0O0xKMCIgswiUMq8BO++xppuwPvNgyn9aiNFw3W7ONr4g?=
 =?us-ascii?Q?GghxmOT4RkTcijfUQTZzSbY/KUDHpVAqfvoKbNX16t23JKM925/MuYBS6B5u?=
 =?us-ascii?Q?wjvh/Ytpr56pY2lZctKc2e0jOW3Ecx1YVJUU1OpdCzXThh3KLqsqd2/ihGE5?=
 =?us-ascii?Q?bINX6oMKwXdoX7KvHuXymd2hYyMOM6YbA5zxMt0KxWk691gXMLt7OKCzOZRV?=
 =?us-ascii?Q?aUw2zruMNzygvJJAqyyYe9PfkzA7b2wteNZ+e9I91FlSeed9Ru7lRebdb9nn?=
 =?us-ascii?Q?kY6s7HLiTQSXvUnQCOfZ0a0/5GvkRz+dijCRN1zzSN96+tWZcjHVDTfCUG5A?=
 =?us-ascii?Q?FQiD9RpwOSzU0KYBdAFqjbd1cA9RBiKiEJt1dlCCW4t7cOdRxZoAAIoYfwgW?=
 =?us-ascii?Q?OhX9rlpQWbZZMXaKh+pPibvADQs7aF8QpmLzhEnfv5flLan/4+GH+O+0vfhA?=
 =?us-ascii?Q?K4By0Rr3y5pnSELlwok=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6081.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debe279c-0aed-4653-bd60-08dd1424c81d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 05:30:36.5187 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XV5Uz+uDWImWcJQ2+i5mcGH2zWuEBf73T1oIRRBSiXBGsfYllAQxFKhN0knBQTJP/Vzw3oDqHI2Pxpbsx2jTUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496
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
Sent: Wednesday, December 4, 2024 9:52 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Increase FRU File Id buffer size

Some boards use longer File Ids.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.h
index bc58dca18035..98f3196599ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
@@ -32,7 +32,7 @@ struct amdgpu_fru_info {
        char                            product_name[AMDGPU_PRODUCT_NAME_LE=
N];
        char                            serial[20];
        char                            manufacturer_name[32];
-       char                            fru_id[32];
+       char                            fru_id[50];
 };

 int amdgpu_fru_get_product_info(struct amdgpu_device *adev);
--
2.25.1

