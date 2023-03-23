Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDDAC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 08:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D95410E356;
	Thu, 23 Mar 2023 08:47:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EEEB10E356
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 08:47:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROQkiVWZ6zWv37lmkTxIbD/KLPTLOku4LD24x+ijpe1p2EBLhW7DGFZweCaX7JlEQ/NK2vVOT2i8u3ALaqy6gaeek61IkSZ4qsik7cwcytPmSAUG7w4BrJKUnjK6zltxaL3fdENH9g04Xl3c5BZZ/j6NJ5nUWJl+cIJgbMDO+IbwBNcPGB45pQju4+fjHIQQXjWkOaVI3Z5ukUefORC5g+kaZXSVMDH51mArArsb1fVmJhbnTDRCcXQ9ida1qnU7bBIgVk/lcPt8WC6VrXmeKu8SWT6hbhHRF0QbBwh5Qegahr5eZUnppCzZQ9sm2+yPXqpml9og8AZGEFfCDO6MdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhN+eAf4tt0h/jJVe3dAFzwE8KHNXVzNeBoOMKjr0gM=;
 b=BcrsIQqBMLPXSIcL/Hhs4mtEgkdoBqNoLbzUJRDxn4ez+ggmnjBeeSirPCzM7LIrBeorp3eLhm5z+M8+GakPHpGUxhgH3Un7oCCN5tP4JyaJYfJx5GErNuBf0EX3qrxMeW+pLDZersCfDJ6m0sS2i8Am5MrdQ6pKNq/zgQVVipN70PN0plOwhVc7kVsbMPlrxagi5TPVQi3nNGKtvkKqaf7hqjPc6+++ut5Co5MJxbrEeBeUJ/N9ytiOB4mNSjrUaHwVU+7gN1PlYQkzxJJlOSVgkrFd0ltPHHV2GIyyVD+NeZv1vxO2vSgxxOzLMyYh1bO+FLlfxL1EcHJ0+/jb3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhN+eAf4tt0h/jJVe3dAFzwE8KHNXVzNeBoOMKjr0gM=;
 b=HvWYJou2ZK20K8D0y2cm/J98ZRH3YcJB6m+Nb4pIYmnGzBZyDU0vo4QpN/1z/PNk+XsXXlrgK2H7gYlczHEEkUzzjiyLYoDA130cZ5YLIe33oHYCnBuiBfZPHaD/YQkTXMcL0SPeuL83KR/BBU5AAhN80A67RwRfB46DVq8Bacw=
Received: from MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5)
 by IA1PR12MB8221.namprd12.prod.outlook.com (2603:10b6:208:3f0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 08:47:00 +0000
Received: from MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::54aa:5d2d:a4b3:eaec]) by MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::54aa:5d2d:a4b3:eaec%7]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 08:46:59 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: print ras drv fw debug info
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: print ras drv fw debug info
Thread-Index: AQHZXWJywb29R1tiTkOwdjCwc399/q8IDQIA
Date: Thu, 23 Mar 2023 08:46:59 +0000
Message-ID: <MW4PR12MB687519AE2268929106F484FD91879@MW4PR12MB6875.namprd12.prod.outlook.com>
References: <20230323083526.32021-1-Stanley.Yang@amd.com>
In-Reply-To: <20230323083526.32021-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-23T08:46:57Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=568f4f86-565a-4728-a802-58217b08c4bb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-23T08:46:57Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: d6debe85-98ba-4b47-8cba-bd1cd058235c
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6875:EE_|IA1PR12MB8221:EE_
x-ms-office365-filtering-correlation-id: 2534e157-0c90-499e-940e-08db2b7b2a7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u1Ji9F7Mu6mUP32AuJL7wfH/sEPLBsGVQjPvopaaX06DxUuR3XuDGZv6GFu1LoOkeBW69lYbCqSm8Zl49NvWwnYMFFOISwo002NT1R4zqekw7yPx+chDeg6cWlM2zpX3feJDQPYuWJV9bsTFCyT5Mkg2BRjuzvKf8iw6BZjwES9l42jZaCksZVk5Jkfh1Jdcihn0Zwfi++Z2Wn5U+8dzLdlcZOa/DGc90YvnpoFhn9NoLKzYJDy344Oq2eodMUDQ/52zjRkn3lu9tu0oNhOviGnm48JDr+JZomvBU3UoFPsWWToK18efEQTWK/DSuJfPkLRYCp92+zYvP2x9Utnf4mHvXzwf6I4GDaS00DChk6RT5oBE6OSwpRPpMi7x4hEZf3/8Iun0H8fqQGDzQL8y9eMLvXB0N3aww0hILVPNs2Ry0eS36cExiWvEsfE1+pp7Hy7AbTCBDpfmcPszyyI2/SKj0gsZL3TAeNsqlv5cFwgtiFlMKxOFZGuijCRJY/d+LcSBQ1/sVkAt9SqETXRhaxAEAmeWmc3vGXncZifZialIL1AZObcUw26W6T3ZB+aY+hZc2IU6N0+zmfxsAJd7X88t6RGxaqhIMLFaBF6cyxu/B9g8khHbPLqramMzjrtnnls95opTt2DO5NP7maUH+3sIGDitwHptgOsPdtRILFfR7q3WO3jM5rs9KVBUhUjV8oLzXp5+MZlZeQYrnCUCwg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6875.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199018)(26005)(316002)(64756008)(66446008)(76116006)(478600001)(4326008)(66476007)(66556008)(6506007)(9686003)(110136005)(8676002)(5660300002)(53546011)(83380400001)(66946007)(122000001)(2906002)(52536014)(186003)(41300700001)(8936002)(38100700002)(38070700005)(71200400001)(7696005)(86362001)(55016003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?viGgaglM05queQHv5mlxQLLUv5AnRdG26eJCjvNOQ+M3aZXDZCL/NcejCpeu?=
 =?us-ascii?Q?u8S2645Zzv+ii8QU564wWflLstmxtMa4kaz7HNX5aWX1g2RI1SqMeIZsPDd0?=
 =?us-ascii?Q?S625UcvgbaisqBxIivmpxUXKn4IlcEQyvfcf2LH77vCqZlNs0vPSRtAlFAuQ?=
 =?us-ascii?Q?zNYiY5qbljf/JZ9dTjP6WXDqXTqaqWZRLBzN+XzFvduPe80D/MUnf8aYvDlD?=
 =?us-ascii?Q?AQzlDavmlyGWZehbprooPLAV0067PNDGSpdIIKsH/JIFQq3y7MdXI1wQ0HDM?=
 =?us-ascii?Q?ZSi4WZ+u8gfy3Hm4b234ZMZfPBxs0g3A74zVLS1JIV/YtBMY5gE1whGC1Np8?=
 =?us-ascii?Q?G285+HLuHGU/IWbBD8/uljmEHgYjjFzy1NeeCmBV9SG0hIzJasa4lFd8Zq0g?=
 =?us-ascii?Q?+AqXg37fK7WK2J3FgralhOn2/tat002bp9Urtq6/VDQ5D4M5rCg5iRKFTLeF?=
 =?us-ascii?Q?I8KOMGDKhb1wIe67A6B0bII6PofZ8vRbJAxUUQV43K/OWOq3a0BNx/wXghaP?=
 =?us-ascii?Q?1IrMtDQsKs7MmEB3BVPtfRHVKeJDeuF8BqhqvKf5QoiD7K++keiFdXXIKPA7?=
 =?us-ascii?Q?M7J41wm11pq1pKVBaBNQwoNx6JjkMxn5Flr+6EKdLrk8bHskaLbBT/4bSIqo?=
 =?us-ascii?Q?REhBO5DDiqyp6TZdxYjE0ltoSjXDkc4IxUrS8h1iCH6fgAjZ+4xN/AmhoOfY?=
 =?us-ascii?Q?KaOyfdoF+yRewEfKWYqwDZ8vs7945iWjAC1Udsl1ifh2IZDynaHOTx0j26UG?=
 =?us-ascii?Q?xspLnDOWu/Hkg3XQRktQBiq7ZeYw9n58E5+mJVNdUHaxrrb71OJD3dh2KJPC?=
 =?us-ascii?Q?AT8njwyNbBog9dAUw9YniyLWvGFGbCyYEjf19TYvbi8Del2sJIwBZvcMvu2d?=
 =?us-ascii?Q?9kTIwgJEpb/AflL1NgzDyyKaOgw/ghPN7dC3hyH+UP08yTM/dl+csu5ghKjp?=
 =?us-ascii?Q?igWws3B7vXOEXWZ09e+U8m3ddC4hvkOIsQD19CEt9cCfbx638rJUTUOj3Fx/?=
 =?us-ascii?Q?vpJQbHgHVsTAT9LLHN7mswG//bw/TjXkw0uXcLGgXyIexVcDEwDAsz1bM3Wg?=
 =?us-ascii?Q?M96PsOS8fnmg0L9Kf2Jp4Znhp1ivGn4x8ukrec0A10i3XiHKje92kGFMZ6RV?=
 =?us-ascii?Q?tY0XO1lj/nJbwNLSY5mIU8eSRtUOrQc78bXDr0w5HFfh1DmYbq9msjHxNslS?=
 =?us-ascii?Q?jJnpu1YeXXy4G16LCtXn5OG8UERzCZMuj3pp2s8Vpv4txX8f8ARHHJ60SOZo?=
 =?us-ascii?Q?V30x5C/u7pLDpFR3KXE38YPUKfy0z+6Wy11cClcegA90NXU8pbmnEyvNoa3c?=
 =?us-ascii?Q?J/d3bhv7umaGyOgH0x1AbBzy7ohzG2BT4QXbNBO1F8zy3Q4+vvKFQF0l5Za5?=
 =?us-ascii?Q?YoxNFZvc+XCsI3Z/2/RUP9PZVnYdTbCCCYql4ELAZc3XOxPVgeZn/eg4HzYD?=
 =?us-ascii?Q?9Zdfj8BbQjzmzCr1jSubM1WJYDFmEJ26jNRmY35ThnBa9SCXM9Qhv1s1Fwec?=
 =?us-ascii?Q?EC/uxev9CVgBo7T5o1sR8xBwQV+33CBDftwAyFCG9NgrWJhLKHgcu+USLqmU?=
 =?us-ascii?Q?Cis3JJkDaFZdEo5Itp0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6875.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2534e157-0c90-499e-940e-08db2b7b2a7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 08:46:59.6146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nVbM4ChQiL09QmcleyJSddv//8/prpPWLjr+lzzEDcqitTIwfhEJrVoo4LGvSsrS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8221
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Candice Li <candice.li@amd.com>



Thanks,
Candice

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.=
Yang
Sent: Thursday, March 23, 2023 4:35 PM
To: amd-gfx@lists.freedesktop.org
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: print ras drv fw debug info

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.c
index 6d2879ac585b..f76b1cb8baf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -459,6 +459,12 @@ void amdgpu_ucode_print_psp_hdr(const struct common_fi=
rmware_header *hdr)
 				DRM_DEBUG("psp_dbg_drv_size_bytes: %u\n",
 					  le32_to_cpu(desc->size_bytes));
 				break;
+			case PSP_FW_TYPE_PSP_RAS_DRV:
+				DRM_DEBUG("psp_ras_drv_version: %u\n",
+					  le32_to_cpu(desc->fw_version));
+				DRM_DEBUG("psp_ras_drv_size_bytes: %u\n",
+					  le32_to_cpu(desc->size_bytes));
+				break;
 			default:
 				DRM_DEBUG("Unsupported PSP fw type: %d\n", desc->fw_type);
 				break;
--=20
2.17.1
