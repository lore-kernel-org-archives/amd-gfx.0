Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F16C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 01:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21D1710E1CA;
	Wed, 12 Jan 2022 01:48:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C59C10E1CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 01:48:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4kzm72FnOKaauAvL2GDYmIHdjJ2klKInOeVgNKhMzMfEkA0HDJa8lZpT9nObmuJiVvcl0Dqm+Hq+xG+fUVAMQ6AoNWHxsuzk/WX8dPauFaf+uS5jZ6ddivWF5gC5sRTf1P7T5Qm/c5GQoWKMOR/hfuob8IP7tg5lJ61Q/HCcy8hCqG3P/l8KDnginl/bl+3pgphaSkrmED44020wfOj0xByyVauOwmymbodos+idGXXHLY9Ziy7gvGvPGzxC13fOCZ4S/qxBDhJVvFtaUMKuGkbYPFjROyJBElbz63VQY15NAdxK7vysxihn19UZ0L89iotOy4FbVetbrHs/XG30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5+2eZEgdLEqWa7J5jlnHNDTPgBegCdR3mw6EOQUtLE=;
 b=J+p8HwRusbzyrl3M2c3Rn3XVhxtJCrDImOZ4BRGkeuyZszWyGHVZa5LK6vjTazzTm85N+hmk4rKpkRE57MRBRLFwiDcc8GHRy09PbvLslmtY3PVs9lAt5QnStRCFim5HzhnU4ki3llXmKqLI6p4uXW/qpBY+hjcxXsPhIaMYlMNtX0Ij5mQuhZ0zD+qBUk5CZLPl0KUqsrFvWpf+DhelqGI9fsDF9qEkjur+NpybceBXO9ctPH9ReddRe4QUTxuB65uw5vCb5hFL84aa11QgWMeJdeY/qJojgWtLMypxCWXPZJpc0dCtIn+YeOsLCnPYcKFCqp51YH8Sxx/nmfNu2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5+2eZEgdLEqWa7J5jlnHNDTPgBegCdR3mw6EOQUtLE=;
 b=voVPJjM3/tTO+NVrVrc+WAAwDAeHRrhp6OtNsovH8/65VqLupooXfv1Tox4vdkaUU4fscQZI+l1SPTEQrhjy3lUmDX0+16wuHBaa6NtvYPRdANIY9sUgik36sjxc8jhmOeCIZZaRVIxje1ASG9rUQZtoqv7CxDntaYias6S0hGI=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MN2PR12MB3598.namprd12.prod.outlook.com (2603:10b6:208:d1::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9; Wed, 12 Jan 2022 01:48:06 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::1500:4b8c:efd6:672]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::1500:4b8c:efd6:672%4]) with mapi id 15.20.4888.009; Wed, 12 Jan 2022
 01:48:05 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix ASIC name typos
Thread-Topic: [PATCH] drm/amdkfd: Fix ASIC name typos
Thread-Index: AQHYBxEN9uwR4zHa/02rqCtZEd1m96xenqiA
Date: Wed, 12 Jan 2022 01:48:05 +0000
Message-ID: <DM5PR12MB24697313F30284279770971BF1529@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220111173105.699766-1-kent.russell@amd.com>
In-Reply-To: <20220111173105.699766-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-12T01:47:49Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d0e7a8f7-26e0-4a43-9c0e-1783d41ed4b9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-12T01:48:03Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 04d4e052-513b-4bec-bfd2-8b511ba2a394
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d7df6ce-ea1b-4850-d189-08d9d56d93ee
x-ms-traffictypediagnostic: MN2PR12MB3598:EE_
x-microsoft-antispam-prvs: <MN2PR12MB359834A6E0E9F82AFF27FA74F1529@MN2PR12MB3598.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gl/CFQeNHiA5FER3pKUelCVAaNgrIjH46S1Gjr/9sWoOgByj+Z9Y9+21Qo92/neVrSLYPUV7RAYfalY+B6lWXDvHznjhkn4juu7kJQkBerJMo2bkjbPHTuTsJQvnIWuQ7PstiF1++OoiPzXDdSH04iJ5+bivjQU2171mp6vmfHe4mVvd7hb7hRJvRrco6YmoUBMeWiRA2BUQZqZDyPzhkpS8ih0JWzZPlVozicMjoI8xWt2b723a6yH+WGUdjPNdoCz6FRCLG4OktvaIBb2VWzg+JBIzRz41zgT0Pl22zb4excuQxV9cS7Q2Pjlf22PIlVlQdpXLOd7yBk5cVV91qyKwGM+xXasYnchyaYvNNhIcERNBuHCk7eIrQxkz8CukD2v+wrQsl04l+J1BlyoZcFV6V0OJ2UsT7eQpIAcUg1U3jcHn41hFDYSgyMic/FuI9ZsggDGdv2YlYxwUmzRszJfvq85YFxsF6UYEaGAB9wjfDzfluGtpyr9czc65jjcZCrVPjG6Y+4fTIuAJ9ZleLekbGH7uPVFwhchh2yThca1ZoLIJn3yBxS1MmBwF/6n/tp+DMBoA8YNWv8bvIHshP5yA03S7uDhwpXSaEb1PzXFuwJ8SgPyvn7p+usBrX1Nn9zdmDmWUyKMcySx0RDWH9SuTLJf/30K/9E+ghVf1ToTGMa3Q0GXl1thx22X4HEOh5Dz7/XLPr+oWUGf9t/ejXg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(4326008)(71200400001)(66946007)(5660300002)(7696005)(38070700005)(83380400001)(66476007)(76116006)(64756008)(66446008)(66556008)(186003)(8936002)(55016003)(8676002)(110136005)(26005)(33656002)(316002)(52536014)(2906002)(38100700002)(6506007)(508600001)(122000001)(86362001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6XLY6caq8bksLcLhsQ0ImSAhK1juyUMaohfJhzGJQoZ9WAU7SlqeL2IdlfvD?=
 =?us-ascii?Q?jzHE1N6z4UnKwceLXTvT9VSPAZ0Fq73gxAn1XFxK4mFL/WR/CTKpU7MmlbPm?=
 =?us-ascii?Q?roxYNFz8pDBHuFZ2GkcnDTtdRf03gQpI3EwQqWzc/hbtEyAcbBWPoezqm/qI?=
 =?us-ascii?Q?1QoVtl78TGG3Y8zc8TzDxQX/8V6iwj3VupZL88NvcLQxJwFo8Fz9q+G9kW9T?=
 =?us-ascii?Q?5X8eFUlJappkxZEz+AdhY64aRPeec/FsZJHGpWkf+NJ3z0AOT9A3figTumEm?=
 =?us-ascii?Q?6XtJJBU22BFg7rsRkALRuvCTeRWEdo6Mi3SzSFEnoPof0Jb2OlP98geGfvZ3?=
 =?us-ascii?Q?Q7riYmFv2t2c5Fxev0XZ6+PbcmA+meJDGxrtvZZgLFOVQQ2+OmnWcyBWrl4U?=
 =?us-ascii?Q?SJLQsHUqTvjYtQ0TW5pT1sQ2PdbqKDtQA3T2Hu3lh4ryB+xLYGPItrst8U+V?=
 =?us-ascii?Q?ajDXDVGO+XklesoNQjJizwVPU6wkj5WE5WOi/5CFwKAFwF/k/EE/6qR9TvL8?=
 =?us-ascii?Q?b7+gEAEMl4NtfDRJExehU/ewN/QXmIBD9RMezPbNDP3vhOA1V++aSrX6phGg?=
 =?us-ascii?Q?xHh2DD3KPBhWgnPm8dKfnS8X0NWgt3+tCWCXQhHsEmMej5AV+YSbMPvXir76?=
 =?us-ascii?Q?XGUJe3ydaK/wlFp3AVX8XLdJeOU9mFClo845IcbymR8up8OSC4rTlETbGHpt?=
 =?us-ascii?Q?KnFpZw+2BbZzPm0MVYsOF9WEPwWZzy2sTi7NpwjOZMFywpOcghPMbPljlPrS?=
 =?us-ascii?Q?2JSwakffoLvGitBcFN/wx0Rx0kyqUF643mNFTsILwu1uKSOuHfVEGkArFrmK?=
 =?us-ascii?Q?gfwhkdTjlgDcXZK1WW7+h91dgIyEQOJHiucxoNpWSzNPTiumbUjljJ7XE0IF?=
 =?us-ascii?Q?zFCcIpJgBT6XsY38MgUb1IXWmxlsrLaI1sVdpcO2fVW8Xwztlp1PycD/Cr+t?=
 =?us-ascii?Q?qnxHSG5zojTdVUUD6vWxXpV6VTlhXFs7plEiWmqUfTZdvjRF8ujM0lMYSYTl?=
 =?us-ascii?Q?IZ6LQirjVK7m+MJLmt1SWmnO+3fRgx2j8YIyT1+L/OEj0J4MVUrez5COwbZG?=
 =?us-ascii?Q?/0ZWbreFYxwART0RXmEJ/pF7ulVYLtsZOdIqcvarvJil7zDXwo3SI3ls4k2d?=
 =?us-ascii?Q?Y6cGZzBPNQU3HMssWplgEsRDia220zAqgvWiS2U4C2Hufzh56UrpiKAPGJqW?=
 =?us-ascii?Q?jcSotKhAeLZNTuihOWq5x1QJkpZljvJtVQdNZtn1G+9+cfNZmSpQTnxsBPLH?=
 =?us-ascii?Q?rpKrUzTP06bxhae9nFge8qliXOzeaOCX7LnfJNz7Hy+OQa5JHkQNrlTd3DfT?=
 =?us-ascii?Q?q2RA8+lKgCKBxCtzCsFFo3bZoVJUk2ED/6fQdLi3A0xAOARHTCAzbqxE3QTg?=
 =?us-ascii?Q?995YdSbKdnb+NkTx49RKTqfJcuX2ZMi9pKrQz7q3kckE/Ob7AKDlH40AEOPu?=
 =?us-ascii?Q?6Nny00O4UeI9UbgbL1c7mzV1v3nFDFXZqOiCgTmZ6spwnNPAhxhs8olOQcK7?=
 =?us-ascii?Q?LurTSFtYpTNY3ubHpzALEO15zhhOF3wGzPrUUEsQZTZNO8NX6vh/UxuLXvOK?=
 =?us-ascii?Q?azb4i4rSYS5Wi/CVulADA/58duse9I2eIebYZnAgfOKjYu75e01ER/H+4/qZ?=
 =?us-ascii?Q?+Y2S0P03B/Y75vBSxCzvGz8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7df6ce-ea1b-4850-d189-08d9d56d93ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 01:48:05.8439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 87kPydH+6dYwJuF+NiSlya+xc8J8EAop4Iju+ZuhwrRO8TsGYhEWLDnuGlusmBc9CoMl93Rsncz/LF0rY0aa8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3598
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
Cc: "Russell, Kent" <Kent.Russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kent Rus=
sell
Sent: Wednesday, January 12, 2022 1:31 AM
To: amd-gfx@lists.freedesktop.org
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH] drm/amdkfd: Fix ASIC name typos

Three misspelled ASICs in comments here, so fix the spelling

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index 127d41d0e4f0..2b65d0acae2c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -68,20 +68,20 @@ static void kfd_device_info_set_sdma_queue_num(struct k=
fd_dev *kfd)
 		case IP_VERSION(4, 0, 1):/* VEGA12 */
 		case IP_VERSION(4, 1, 0):/* RAVEN */
 		case IP_VERSION(4, 1, 1):/* RAVEN */
-		case IP_VERSION(4, 1, 2):/* RENIOR */
+		case IP_VERSION(4, 1, 2):/* RENOIR */
 		case IP_VERSION(5, 2, 1):/* VANGOGH */
 		case IP_VERSION(5, 2, 3):/* YELLOW_CARP */
 			kfd->device_info.num_sdma_queues_per_engine =3D 2;
 			break;
 		case IP_VERSION(4, 2, 0):/* VEGA20 */
-		case IP_VERSION(4, 2, 2):/* ARCTUTUS */
+		case IP_VERSION(4, 2, 2):/* ARCTURUS */
 		case IP_VERSION(4, 4, 0):/* ALDEBARAN */
 		case IP_VERSION(5, 0, 0):/* NAVI10 */
 		case IP_VERSION(5, 0, 1):/* CYAN_SKILLFISH */
 		case IP_VERSION(5, 0, 2):/* NAVI14 */
 		case IP_VERSION(5, 0, 5):/* NAVI12 */
 		case IP_VERSION(5, 2, 0):/* SIENNA_CICHLID */
-		case IP_VERSION(5, 2, 2):/* NAVY_FLOUDER */
+		case IP_VERSION(5, 2, 2):/* NAVY_FLOUNDER */
 		case IP_VERSION(5, 2, 4):/* DIMGREY_CAVEFISH */
 		case IP_VERSION(5, 2, 5):/* BEIGE_GOBY */
 			kfd->device_info.num_sdma_queues_per_engine =3D 8;
--=20
2.25.1
