Return-Path: <SRS0=PfTh=NJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE8AC432BE
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 09:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E14B460C3E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 09:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E14B460C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2045C6E514;
	Wed, 18 Aug 2021 09:54:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BE3D6E512
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Aug 2021 09:54:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ey4O4atk10A3KFJ/ueyRAEwNazTpmfpmSnZLGTy55M7OKtlEQ8D36BBVUBkKZ/v0mxaTW+Xw680jeY0eZN4WchxxgvmC/ZVUb/mJkpn/QG9IE82QzJ8S9XvM+LVqapKyS9jvZ/0G6s5kTw2MKhgTANidZoX69XWoHvHRq25VjKDqt1NSO8e1+ac+ndESYBfXaXt1ywW5hJvs97j343DEYl/qjt0HyMF7QjrBKWvMAr/WiosQegzfVAMF30PB9Ogf3hHM4O8N9cuyaPbzjxornS4WyNRthsx2r0llbVjmrHuiBV16zSo6ZDZ1Wwvhyg9QANsxcpAh0BsyvxU6weRZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHQ0ulHPuV5H+qwmxJ/bVKDDOew1vMGxB359azHOi3k=;
 b=HnUHdplR8XPG1b5x9uXAu5NLiL48ZcUbRx/9tikrYiJ1xOkVHewRmo0rRNOYI2FtlGbmFMa6R80XPaZ/EPnMYBvox2/erBWNzBqrb6MSwmJczVXDR/wb06Y2UOxlrPoMi6tC8MoUny6cDpZgID+NBe5OuZ7v9BqrKEXTJrlWtvhh+jITAJP78FCtbuQkGoDFpQSjW/mMPyGyS3le1vT+eImRFqxi+wvWrmVziJLuOKfn7o37UiL2IwYZfWjhy4sHSa2QsbKmApprGusoEpElxameo9MJqekFbY+D4gD4FXzBK2zW3MiscVj0lxTGcDDm3//Z4jR9GHv6Vy90pxuO0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHQ0ulHPuV5H+qwmxJ/bVKDDOew1vMGxB359azHOi3k=;
 b=lOSAotvOBJj+vEXPtxe9VOVPwuE9qm5qALMMRvTCQn7qW3074vatez7iXbIoY5OZVHUvatAzdJ4Cte4tarFDL+zmb6deiHdzb70bqycv6jF1tr6FQOAW8br+CwWi/3O/tpn2t2QJq30BjPlDWEO4p8pztbihEGpV1cuScEAUuow=
Received: from DM4PR12MB5245.namprd12.prod.outlook.com (2603:10b6:5:398::8) by
 DM6PR12MB5567.namprd12.prod.outlook.com (2603:10b6:5:1ba::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.16; Wed, 18 Aug 2021 09:54:13 +0000
Received: from DM4PR12MB5245.namprd12.prod.outlook.com
 ([fe80::74cd:6cc2:dd29:1780]) by DM4PR12MB5245.namprd12.prod.outlook.com
 ([fe80::74cd:6cc2:dd29:1780%9]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 09:54:13 +0000
From: "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: fix radv vulkan fps drop after s3 resume
Thread-Topic: [PATCH] drm/amdgpu: fix radv vulkan fps drop after s3 resume
Thread-Index: AdeTlPNYoVeOHL/DSvKqaEtc3toehAAek1AAAAHaulA=
Date: Wed, 18 Aug 2021 09:54:12 +0000
Message-ID: <DM4PR12MB5245FF55690413FB1BB0404CFFFF9@DM4PR12MB5245.namprd12.prod.outlook.com>
References: <DM4PR12MB52454BBA711B61BA2BD03033FFFE9@DM4PR12MB5245.namprd12.prod.outlook.com>
 <0a58b123-67bb-a066-2a36-fde0116a92c3@gmail.com>
In-Reply-To: <0a58b123-67bb-a066-2a36-fde0116a92c3@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-18T09:54:09Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6540b7bc-6f83-42b1-9708-a8c675235d85;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b436c96c-5696-43a0-6672-08d9622e2226
x-ms-traffictypediagnostic: DM6PR12MB5567:
x-microsoft-antispam-prvs: <DM6PR12MB5567CAA2B324A98D4BA74B58FFFF9@DM6PR12MB5567.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1O3DD76vD2d61+JUUoa8lQfcwqvpz9rjQnQFBFICVne7rb0Pg/UlfwNUm9nzE14ixtbROmPdFFnHOiEH4He4HTfY3wfHOvCQ4nDkPdbLllGQpT4kTTrr8L2qqYlJuafOy1Uo/BMCoBiUFwWw8RUJwkgyZZGi9f10DFG95AD06ons2msSHLX1Ut7rieQC4uxPYzoJ7oBWOuYWdT9GOqr+an9URHPut98jWZLt2ACRPj+wil1hZ+dwRscy2fUjacVxE2iEAb7+x6p1HazcZXmm3IdYc94V238vpkj0+gk/lOBhSyUfqZBnfVn79AOL3WOCK+0N79YwKaiqmdholiSTCMFXQzF5OPjhJrUXsloQlOTvSCf+HDzIjO5lgmUSraIx91MJb7c0B0Dp4TseVTQr9iaNZYI+XOmRETZv48eNI82nOqECiBmy5/KPruBYmZcoZa4Dq6x1jJAmFr5mTx6A4S2eOveDXqtvmChHWKqQP4RyLKKdHdQVtngrRYy4go/IHMagfxEOrxYr1iri9gt1juHvy0mqJYuYsBUyGDRgD5x4+6kKyVXjz5AvsmwjvlOZiX7ialfD9rkndn0p+gXUwZNk7u/GkymV7ZxkzNjZSlq8dBSf2jkGtxiJV8KON8g4TydW+gx7ehY1UP7zCp+UEjhMuEq0ShuQIWGX2JiUgFRrQ/mt1Oit5M4mTR7AhSVAStgnnEWhnrMB11M5jQbOWw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5245.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(6506007)(122000001)(38100700002)(5660300002)(2906002)(7696005)(83380400001)(478600001)(66574015)(38070700005)(71200400001)(52536014)(110136005)(316002)(55016002)(9686003)(26005)(66446008)(33656002)(64756008)(66556008)(8936002)(76116006)(66476007)(8676002)(86362001)(186003)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xkrp2bRFkurNT591MYLskHW4FBwF6CR2UA2JxK6kPQ0qRkjfQOFTWzmrid?=
 =?iso-8859-1?Q?XEXf4B3lMgPTmRQ5c0CuBKMr5kC+oaS7WjohNG73CqmgyK80mndeA2/37d?=
 =?iso-8859-1?Q?YYBv4nbHbbjqe5DyQzYMDfDoLGLg+gf64QtVpklADYJsnkKShd/GE8awir?=
 =?iso-8859-1?Q?OUCNtvBTBK9Scq9naukgvg3daeRYx8EJMysW6spIkSy2l2s42bdw1lgSu5?=
 =?iso-8859-1?Q?aVvlF3v9cKezlMnFVUn2lvJtMRcVID7a9oYc1pplXltDNC+0DlwnlDiSeh?=
 =?iso-8859-1?Q?dGtwkwYQLkbiZQRMlqjQI54tOEHsMI8QbXYLgQP0DhzPr3aRFujrW8F49m?=
 =?iso-8859-1?Q?OwbJeVlT156fDi9lY9lZH9FBYG18/2g1cAzzCcivfzxhqEUUurjIrrxMIa?=
 =?iso-8859-1?Q?KPvb3tLUG9pUOvNSp7ua6ysAcNLnPAza74519TBJtKIO1U5VTHVe92ZTMK?=
 =?iso-8859-1?Q?Orcik0QEaQluDOTl7XURIOqf3lPBSJR3hzaN9rpXC88xh7dStw1VQQnv5N?=
 =?iso-8859-1?Q?9Lzq5ZQVpBATlpOn9d16igNuiQfUo+r5xlgtXSWdtS7yymSk0BMBlAiUY/?=
 =?iso-8859-1?Q?V55nbPrMy0jU1duHj3cNi1/+8up0moW6q/ARZaHpd4Rnyn/pzFwccETJwL?=
 =?iso-8859-1?Q?kP91QEXVhgP05Mji1Dg/N4i/d+kleeaLHY2RQ4AF0B98WUEdluYM4R7iEI?=
 =?iso-8859-1?Q?dwQEcU/rqCBR6AuhEFqoY+o+e9zsptvrFY5yXtMno+rNxSMOAxv+CT6lBu?=
 =?iso-8859-1?Q?Eb8SvszZfK9uX+1pzDlYqzE9ObTMLhEFmfpm8bKSXpBIfZh/mzc307LRqH?=
 =?iso-8859-1?Q?+zCb0jfVT1yKavsa77NUuh0kH+XwBbzrZ19z1QUl0G0cEiuGqx8IRhvuDz?=
 =?iso-8859-1?Q?1fsmDHH/LDqOEK+5+hqqZD+N5wLJ/CvXz7uUB4AqcPBvbbATEFNVZ3xscU?=
 =?iso-8859-1?Q?BIV2MP8nfZvNIfsyt6WMZfugJ9StW+Xt70buaahs8uM2mkVmqbb4YRYkqp?=
 =?iso-8859-1?Q?Lcsk8zAFae8A6FT+VuePivLQWidQ2YcDeyhYEHau0YDAwlKGoi2PLdp0QT?=
 =?iso-8859-1?Q?+NIhSYtprs8/EljHTOLnLOkz0c3JgKXIvlsRqzgS2fexD1CI93KNNFGTYd?=
 =?iso-8859-1?Q?My0rp4bC4o3juJLSwAO69AqowxbRpy/QHUlHUtvK1FI1fUC6V97yF2lQ0v?=
 =?iso-8859-1?Q?9Pg4K5ozoSYMeMuRPoGab5hkO9N45pzNoIqEn04eOFbU2FQmU6AGGT9cfx?=
 =?iso-8859-1?Q?+EJLLzwigQjUscqlfDr9UyVEEptrvcaIPXyxi2Dw7s2qAIQP9+20Ho1XYX?=
 =?iso-8859-1?Q?jxEnmczVIqdsMcc/ImnwWDckQxWS2KOWT9E71wOpn7rZXItho5TAppaUON?=
 =?iso-8859-1?Q?NC3q18BnMN?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b436c96c-5696-43a0-6672-08d9622e2226
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 09:54:12.9370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hFL4RYmTgMtZ6XOHJzlFtjTL/4bIoSSga6F7/kC1LMhZXVv3BSfcHbR6a85u/c73wl/5cRrW44cmDDxIvn7MYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5567
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

[Why]
After s3, In radv there is huge fps drop in games. This is because
when memory is allocated using radv_amdgpu_winsys_bo_create()
with both AMDGPU_GEM_DOMAIN_VRAM and AMDGPU_GEM_DOMAIN_GTT domains
set, the kernel memory management after resume fails to move the data
back to VRAM. In kernel memory management, ttm_bo_mem_compat()
function returns true and hence data is not moved back to VRAM.

[How]
Implement the idea suggested by Christian Koenig. During suspend
move the data to system RAM instead of GTT. Due to this ttm_bo_mem_compat()
will return false and data will be moved back to VRAM.

Suggested-by: Christian K=F6nig mailto:christian.koenig@amd.com
Signed-off-by: Yogesh mohan marimuthu mailto:yogesh.mohanmarimuthu@amd.com
Reviewed-by: Christian K=F6nig mailto:christian.koenig@amd.com
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 446943e32..44ec59998 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -136,7 +136,13 @@ static void amdgpu_evict_flags(struct ttm_buffer_objec=
t *bo,
 		return;
=20
 	case TTM_PL_VRAM:
-		if (!adev->mman.buffer_funcs_enabled) {
+		/* Move data to system memory for S3 so that while resume
+		 * ttm_bo_mem_compat() will return false and data will be
+		 * moved back to VRAM also in case of bo with both
+		 * AMDGPU_GEM_DOMAIN_GTT and AMDGPU_GEM_DOMAIN_VRAM domain
+		 * set in bo->preferred_domains.
+		 */
+		if (!adev->mman.buffer_funcs_enabled || adev->in_s3) {
 			/* Move to system memory */
 			amdgpu_bo_placement_from_domain(abo, AMDGPU_GEM_DOMAIN_CPU);
 		} else if (!amdgpu_gmc_vram_full_visible(&adev->gmc) &&
--=20
2.25.1
