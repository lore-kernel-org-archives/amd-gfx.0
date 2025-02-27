Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DD4C021B8
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 03:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83D8E10EA12;
	Thu, 27 Feb 2025 03:06:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dgIiO5w6";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B7C510EA12
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 03:06:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Doa4ELjDbJ9Pv/eXFTdjXsgFI/IED+Eu/ny8S8uUIbzco/P6gk1K2sKxZx5vx00oYIOEErpvR67ChiA2exYIkAsiC5tTxJ8JBoh804aFE12jGeJ1gv4wNwO1nF58WbOuSQifE7MuZ0xhBwXB9oczZNqivX7rNicKmVSt6Ur4crxZLx+OVn/ZGiDGCKMF8hhNSWWrHvAeH+sU8Y9Qze8ZbkxAmGa5Aiw2vriBdPL8405mp28360TO8348jvlQW5iH2Sd11XwyA99SgI9O5uokAlij2bTeTuq+BIBlCzjtaAIgjfgxMg7Ksx8SLDbI69S55Y2z23A/9Fv8UFSCtWCO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6aCxdALECxWMnrWjntp/bOS5HPaP1lmJzdS2P16EdE=;
 b=ThNl2CXEzYKHjF/GOTn2YEvAJ/mbt7kNlsx/R3tTknIKPUZUc8cO++B2VIj1hac/mW+h5s+6bk89nnkgN2CunJcBPPp/kigfRtNBDOpT0VDCBCe/iaaqCOkKLkjS3fOH6y4vKL6a2ap0T5ja6uu/MEC0BctX9AwvS3UojjjEcCXctIYGF7bEqf8oDhPgRPp2fRhVaZoYKRqlC6on0FvQ3JtFeqc6aJZxyVrGerom5Mho95/0FtfGyiRHeqV7fwkkAsdU0mI9DlOLUylJ0PHM/J/QOvWUpZNA7xCBjSE8pGsxLWsosxBa8PjBdsx81RpLwIsz6ysyueXS+1ZPDbmSUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6aCxdALECxWMnrWjntp/bOS5HPaP1lmJzdS2P16EdE=;
 b=dgIiO5w6kE8UhqBW5fPlIo20ivaC+CTyfNxAtNYox0wZ/lqMLuFwyj68dW5AkMoqLLh7Hxq2ioEM8zrqGR0KLd9kX80HYPCzvsx14XBRl1a+o1iS1ASFvHZynnL1owbkCzFzdAtGzfKaSffeTevArR1GS6V82HIKAys9zlZItNg=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SJ2PR12MB8063.namprd12.prod.outlook.com (2603:10b6:a03:4d1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 03:05:57 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%6]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 03:05:56 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: add fan abnormal detection
Thread-Topic: [PATCH] drm/amd/pm: add fan abnormal detection
Thread-Index: AQHbiL2CeE41l0hgwUyPl9jnOw0pK7Nad0EA
Date: Thu, 27 Feb 2025 03:05:56 +0000
Message-ID: <PH7PR12MB5997FBBBE98AC689FDBF260582CD2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250227021536.523386-1-kenneth.feng@amd.com>
In-Reply-To: <20250227021536.523386-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=75cd0986-dc84-4e76-b1f7-6dbac3b88a80;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-27T03:04:51Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SJ2PR12MB8063:EE_
x-ms-office365-filtering-correlation-id: 8e28af54-01f2-4f54-cdff-08dd56dba7c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?xffcPhrBbchTbT+CT2My4+eXwWXa21ljdtzaCMT4D2KhBb1H9rtXeSf9ihaf?=
 =?us-ascii?Q?DN9P6LoXBFnQIiFjbKlOb2Oy+lrQuLmUB1D/VDWMbk7Z7Ly+qo3VgDShB9Os?=
 =?us-ascii?Q?XuigAmS/QQC7F19aCRKhgSx+SggxRIt91hzxn3rTN3oz/VMbhurQGFW/yKVP?=
 =?us-ascii?Q?9262wkxCM+yFDbF9DPohEZChvEKsJVUCjD3nULlHj8Qi4CtcN4+uZoLD5kT3?=
 =?us-ascii?Q?qc+LOwuxNlhNIzKqSRRnHSSS0FLSTprD1Xdl4JRJPnvpPGsm29MeTASWVHpE?=
 =?us-ascii?Q?j+DqJ8zWNmDfTRXmt4jaOrz5xfb/nsXwazx4grI9p23TgyrQDrNiUyZn5OlA?=
 =?us-ascii?Q?hRhtoO3WBIRztL2pDIAo5YFinZdZW8L9cT1Lopor9IAaJgaedduXlhxYH54t?=
 =?us-ascii?Q?sQuTchg6zTNlUzag09X6mXucvkMWCVQrBpFXUQ5znas4bTtjhRaTluDppGlO?=
 =?us-ascii?Q?So/MdSidtVahLo/gSxZgsYBTDsrdpt8tM6dIt0IjxcTpecGumX8rxoKwV5zB?=
 =?us-ascii?Q?vX1YHtpAJoULsahvzfN6JHal1kARbjXLdsXIPaRxwgifu0j6WfZtH9h7FH8P?=
 =?us-ascii?Q?6HNjhCeYXddkr29fZ0RgrW/b6/7AYjq4xLuxo+ZerWb3IneOdOXdYQ2u5VDF?=
 =?us-ascii?Q?TywnBkPWK3M9ZC/QVQHaLeRm/0nnCEVACGr/b6x1GseKAXiCSy+xhf7IACn2?=
 =?us-ascii?Q?p3ky9PuyN1+LUxFh7tcUcVIyKL9uMhUQnCYN0eMmxLy3jJfEqrAFSBIIczFI?=
 =?us-ascii?Q?Jat7b23qwiAMZZfyD4cqtj9tFo2rgvK9hqIyCmQlKXk3G2DCyDlPy29EIQim?=
 =?us-ascii?Q?4O4UPtUSBwAbTV7twa9j5+MG5nvekMlkcgitwJx08cnS93uYH9tCmzSUHx4w?=
 =?us-ascii?Q?QDnvih//1BiyXAnRR8WlNrUOg21d7QlYG5Zm1Zht+7P2lHEGA7CTxihd0PU4?=
 =?us-ascii?Q?JMK3iTzX4G38xrfy6sG67t5EqUwVqYXtIJc3CMItiroKjSiyyHJxIjIrqDep?=
 =?us-ascii?Q?zlpamSRK+C+MLDLLhDdhUb/YkS3cUCbrWfI+/bNfnbmSOqHCq6g10RPQbGzz?=
 =?us-ascii?Q?nTsF2zeHhdbHunxJ4ZoKWsMEzWQM8wlNAbVJXWPeTsqQ1GEnzRoeVZjlMMFX?=
 =?us-ascii?Q?6FvlbqqXQiq90LZFFxe2ah/os7lFf+ytMjLksI8LUQY2o333qXGFmXdFCdsl?=
 =?us-ascii?Q?0GuCy4XNIPw3oBR4nk82GRWbGOi/8hBsUmFBn2OncVhovPZ9S6bFj2auQJyr?=
 =?us-ascii?Q?TjZS8VKBCfSQupaXG07VUI4oPTqJrz+z4MnG8yoWefJrex97BcSU0F8dG3M+?=
 =?us-ascii?Q?pfYu157LMYQQabN9tQrmgopBaXBja9H2JGy4J61VNelVZhchqSgqZ4Lul1HK?=
 =?us-ascii?Q?qI7sybnTxwuPCdWXPgDt+cluljlk6IE6MwyiLpCoyWbDPgokidSap2Qxh776?=
 =?us-ascii?Q?QrT6JiCF344U90XbhkXj4iD81Y+fDmPO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gDAucGSycYOHqLVLum9YAt6kU8VmAZFUz1jtZdZgY5HoNcnE0Kjczmrxq5/c?=
 =?us-ascii?Q?dfTdMMr0u1SVZ5cnLB01CL0uFaPWF4ExcKy02r9MqZksvUuU5Ba65TIwb/4C?=
 =?us-ascii?Q?lcFrlCaU1FcuYtIPfHwOA3JY6Id7k8FV8WmjgTeuaAta5Ynk11JEyw42t0Ib?=
 =?us-ascii?Q?D2pVIIiN7jFJPXm/a++dNFTjGkTqE2iJ1rqypd/ID10+wFmNnL5IgQY7986F?=
 =?us-ascii?Q?jjXqZZow0/GbpsFKooEXXpn5oHzfTqt5D3TK4q+L3dj7SyBBryjgj1LlsKTH?=
 =?us-ascii?Q?tCKDZLAjz/+DLP/+kzfPuKrQlefQwWpQdyYnzpVCJXPMKT/586UI5SyDQDln?=
 =?us-ascii?Q?EXenGAtEV2LVWAOGmcNt1XCrzlvaa+eE6niVSl9O+kgRwkErbyetsuSkArGE?=
 =?us-ascii?Q?lP4rT7MeaXG7yZ6bl7rZUUS2tZAxyExyrAEgGH0iuXsmJdjlQIvkbIbubGlb?=
 =?us-ascii?Q?Mn5B0fFQDEOIi3CWLNuxvXazCvJuu2Nb+AjqCtcF2d4UaznJzIyuwsgGlUM0?=
 =?us-ascii?Q?BqMbQSRBttg2uBVSKSpNvRDL39Uk8hz1bU4R4Bj8jvJfoD7DPi37IPFZnfNR?=
 =?us-ascii?Q?kAu+Ly/I1vkdiHiovaRPaqmTM62N8fpM1NY5dnc9tIVmPs6iPHwhlcA/sL4Y?=
 =?us-ascii?Q?/WgTpTBe5vqkehbvxWyvB0rSvSKwZg3Ux3xTP4dTfHs2v509w/WAh4zXTzfb?=
 =?us-ascii?Q?893X2j6k5nA3EE4F8xlOZxL2LbMU5/NzXs/67VEmKbxKiElbw8vywShXdURZ?=
 =?us-ascii?Q?3xv4G52+UoBfB/+5y1zsYcGrWUG3kllbgZm8fPrr5s/vgn3TCNAD4iEP5PW2?=
 =?us-ascii?Q?hRwmc5fohCGS9y03/wFa1M+XfgIMHV9PGmSJoi2oFhsbrO2MF4nnAKDfJkIx?=
 =?us-ascii?Q?HYEUKJGiZxuhpYz+sVTeOrSE0DytRt1HpCmJkkxtyzKL6Tqr3nbEpg+6a1Hr?=
 =?us-ascii?Q?WyjYb6w+KPYzbWUTGs9pOHZF7uneejvEsLgLsEb4nVUobs7w8Cs+4vWJCO9H?=
 =?us-ascii?Q?MbIOCLHbgWI1obt+ThDhD43OyEY+OlC6ej2In0BsZPhti1DpY6lUfWY5cOF/?=
 =?us-ascii?Q?h8dSsUyAqwSoQBHYa4CaIcWTmhvmx55Zm1Xq9HTu4k57bu+ltQubm5mPz2o3?=
 =?us-ascii?Q?cBq8xQVGueVfQLaU5UZteyRT0dM+MtPFLgwn99nDq98jANZbpXdnzagCT86g?=
 =?us-ascii?Q?oO8nC/Bt+CKpDqwnWGFXJhIVV8mkeKNcWjG5fgwOO4Bswys1TEZBwW/+Vvqq?=
 =?us-ascii?Q?jiFFgroHkEBsKaeOdKOIF2Vp+EGR86eGvBCeCMjbNaaptLbSmE3ELpyditSq?=
 =?us-ascii?Q?10B08yUACWn1+qzOwzI6/w53+FRCJnQ2cdmvWRdKaPB97KSxjptLhU72KrDZ?=
 =?us-ascii?Q?SN+zzLOd3zVueZv/g/iOwl21t2dhvK28SMOdrZeyf0839DP56TlySpvsDq+C?=
 =?us-ascii?Q?LnMmEMGcXLnCDzYsbWzi/0TGxnoSnIp6lArR0/77uSf2PwjhVxQTBK5BVAOj?=
 =?us-ascii?Q?71T66iF4m5NINVRXsKl6DPNmorwBOdBPqEHaRQRHROf74Xze3q+XdEGVvxzr?=
 =?us-ascii?Q?3dtvUZkv1gJNPykkoQk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e28af54-01f2-4f54-cdff-08dd56dba7c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 03:05:56.8793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: So9RbWOqum26UyFzL38G1fG4xOW8W4YAX6fKoyIHLl+Bphr3D9QMIaeN4NYrkjmU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8063
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Thursday, February 27, 2025 10:16
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng=
@amd.com>
Subject: [PATCH] drm/amd/pm: add fan abnormal detection

add fan abnormal detection on smu v14.0.2&smu v14.0.3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu14/smu_v14_0.c
index adbb6332376e..14a5760082b8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -950,6 +950,14 @@ static int smu_v14_0_irq_process(struct amdgpu_device =
*adev,
        uint32_t client_id =3D entry->client_id;
        uint32_t src_id =3D entry->src_id;

+       /*
+        * ctxid is used to distinguish different
+        * events for SMCToHost interrupt.
+        */
+       uint32_t ctxid =3D entry->src_data[0];
+       uint32_t data;
+       uint32_t high;
+
        if (client_id =3D=3D SOC15_IH_CLIENTID_THM) {
                switch (src_id) {
                case THM_11_0__SRCID__THM_DIG_THERM_L2H:
@@ -964,6 +972,50 @@ static int smu_v14_0_irq_process(struct amdgpu_device =
*adev,
                                  src_id);
                        break;
                }
+       } else if (client_id =3D=3D SOC15_IH_CLIENTID_MP1) {
+               if (src_id =3D=3D SMU_IH_INTERRUPT_ID_TO_DRIVER) {
+                       /* ACK SMUToHost interrupt */
+                       data =3D RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_=
CTRL);
+                       data =3D REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL=
, INT_ACK, 1);
+                       WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, dat=
a);
+
+                       switch (ctxid) {
+                       case SMU_IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL:
+                               high =3D smu->thermal_range.software_shutdo=
wn_temp +
+                                       smu->thermal_range.software_shutdow=
n_temp_offset;
+                               high =3D min_t(typeof(high),
+                                            SMU_THERMAL_MAXIMUM_ALERT_TEMP=
,
+                                            high);
+                               dev_emerg(adev->dev, "Reduce soft CTF limit=
 to %d (by an offset %d)\n",
+                                                       high,
+                                                       smu->thermal_range.=
software_shutdown_temp_offset);
+
+                               data =3D RREG32_SOC15(THM, 0, regTHM_THERMA=
L_INT_CTRL);
+                               data =3D REG_SET_FIELD(data, THM_THERMAL_IN=
T_CTRL,
+                                                       DIG_THERM_INTH,
+                                                       (high & 0xff));
+                               data =3D data & (~THM_THERMAL_INT_CTRL__THE=
RM_TRIGGER_MASK_MASK);
+                               WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTR=
L, data);
+                               break;
+                       case SMU_IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY:
+                               high =3D min_t(typeof(high),
+                                            SMU_THERMAL_MAXIMUM_ALERT_TEMP=
,
+                                            smu->thermal_range.software_sh=
utdown_temp);
+                               dev_emerg(adev->dev, "Recover soft CTF limi=
t to %d\n", high);
+
+                               data =3D RREG32_SOC15(THM, 0, regTHM_THERMA=
L_INT_CTRL);
+                               data =3D REG_SET_FIELD(data, THM_THERMAL_IN=
T_CTRL,
+                                                       DIG_THERM_INTH,
+                                                       (high & 0xff));
+                               data =3D data & (~THM_THERMAL_INT_CTRL__THE=
RM_TRIGGER_MASK_MASK);
+                               WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTR=
L, data);
+                               break;
+                       default:
+                               dev_dbg(adev->dev, "Unhandled context id %d=
 from client:%d!\n",
+                                                                       ctx=
id, client_id);
+                               break;
+                       }
+               }
        }

        return 0;
--
2.34.1

