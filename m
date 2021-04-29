Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCC8C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C47E6145B
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C47E6145B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C21A76ED0E;
	Thu, 29 Apr 2021 07:50:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C39EA6E1A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 07:50:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxCPsQe5nDaB5s9chWHICZIqECDQbg+KNH/K33vGUDKK2cVbqQt9Cdoq/hye7Gc1On8T7l3M4SNmovpvXkK97XuCgw6cvWhx9rr7lx6sYf0Ll2dpkl3yhIJEwQlYdlEpmLQXwavj1OAyKe2xtBWQf5Js/ak8idlvmLehNDXeZd+CXhnhqsE4SEQe6wG+IpzNfazIC2X31rhHt7gS/K/nwEFGY65qRWGMCpVoEDn3hDWf6YNJ11w/pyWUp6M3QbjoDqFeIm8BFI1ukYHxMS0FCdBtgeM/oCb46Bdm2QeTNqi5eYBPg3z/Nb7SdVzUoH2MRUrFi0/0TjLJCd1K37oqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLd6zSsJRRys6/dvtANOtyQix+5tZdhdHUxrZT+1AAg=;
 b=i3ar7gK2/QEjP7kDu1pmEKaOGEG0cQhfX8r9PGzpxP097V/C6HVT9eoQHmbzSFzvpTz4rd4n4ljXw+0NmkCIzs+0lC956lvfuud4JqaAjpNyt/L4SzmbtCe8WiyHBzxX08/IFoMqwuONbnyklz/QuCsJ6sTqGmjwbnN2tHZYPhAYe26cMJjDPatZxzgS5cxNK4H2HI+eKFoBJaq/+3novSuaxdPPzDLhzKLQkM33QPAO4oECCnSGQ+DJHr8gDo5HdUlA4qCYYq+FZQHdqHaqU00nfDukk4MXlJ0kLCbMb5I2MzRdvUJgp6az9E7ndTY+DjPHIsrlWYJ2YQwN8TkGPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLd6zSsJRRys6/dvtANOtyQix+5tZdhdHUxrZT+1AAg=;
 b=q13WvswsL+vQZviWzfy3CyL6sZf4mLM2W9gikl6drpQ5V392+HHPxAkT5tBN/7IuOT9y9x3BuJT/6tgU5kDJwjH7svaFwbDXbtLPCwMcptyylABrq4ZfvAX3hTXaAKoSuQo6T4eRwMw7W6VqUOYmMHOAlfmBFlVyjRoMKhIptIY=
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 (2603:10b6:910:1b::19) by CY4PR12MB1863.namprd12.prod.outlook.com
 (2603:10b6:903:120::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Thu, 29 Apr
 2021 07:50:47 +0000
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::8452:74ae:9106:ed4f]) by CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::8452:74ae:9106:ed4f%3]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 07:50:47 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/7] drm/amdgpu: add hdp ras structures
Thread-Topic: [PATCH 1/7] drm/amdgpu: add hdp ras structures
Thread-Index: AQHXPMCD3ntdDcG0w0q72BeJ2wKLCarLHxkA
Date: Thu, 29 Apr 2021 07:50:47 +0000
Message-ID: <CY4PR1201MB00727565190E90D03D0A58A0FB5F9@CY4PR1201MB0072.namprd12.prod.outlook.com>
References: <1619677546-2630-1-git-send-email-Hawking.Zhang@amd.com>
In-Reply-To: <1619677546-2630-1-git-send-email-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-29T07:50:41Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b85aaeda-d71e-459a-997b-3e6d6b6d777b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [240e:38a:845b:7000:43a:f4aa:d777:f395]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb3faea1-e807-4c24-9ea9-08d90ae3802e
x-ms-traffictypediagnostic: CY4PR12MB1863:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB18631E60186CB7E26E22DC4BFB5F9@CY4PR12MB1863.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:431;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZgvQsUK4Gc0S6gUz9LUQNWWQf8/r4BMafLfdNyHvr+bNyusMwR0riT1GtZAaWuWfit+5FKJhrl6tFYK4kOvQhVU6nSZo5m0MXQnheqVZBhTqMgAbX4aOzgRcv+ckStICPzdbShqXEv6s2WJMaMepNGT0DK1M1uvsIN81XWcMKBxJaLHi4L0Z1HCqdhKC40GfRCctsbD7vsdUDk7N8zYOL8+trYPzbzNJRuKWTqLffd1Y0wS7QHMOWcGtPlz+Vm51DlGb07jB4CBEFfCiOIoOFrVb6iW4gzzEcI7TCk19sL4cpSlt1JJ62oWaPMBlvAB0bffEZ/kVrCROOD8nxokycTCuIvH7dYJ+6QqfA0NdLH6u0EtaR1YP6HwdmiXaFrwc6cNW5KDPTfT+2D+cuieZ7wZvoAUFrC6jTy/AfkN/+3Rbqat6SuuJoYA2hLPZOOce/kP72SCSyctZsK8lhiD3ZAXKqf2dKVlwk+9g3TEpOdFV3I2ay3Ms5X239QP24NOv7WTHJc3IIqZYH7gbiPLaCV2r04/vCiXVFDB7slXtxoQswPFVjo+dVIgA9IK8LbadlBZ8CmSw5ZFTimXefi601S8DYpQRjHquflWiYlYRTB4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(4326008)(38100700002)(7696005)(83380400001)(316002)(186003)(122000001)(2906002)(52536014)(53546011)(66946007)(66556008)(478600001)(66446008)(66476007)(86362001)(64756008)(8936002)(76116006)(8676002)(9686003)(55016002)(33656002)(71200400001)(110136005)(5660300002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4YL7kEMKxYadGXSdRsBRLwUyhdk9+9Chxy9b3lWZjzrB4TkrjcvEB0eNxP/D?=
 =?us-ascii?Q?dGtL8N7vwCLdu5Hts3uf969iQNGCN6ILf9+U9pE5BfkFHxm+C14Pmf9NQMPD?=
 =?us-ascii?Q?U6xjogStKQlXFVPojHfOQjzxlBetxoyKvycWhWEduJFQodNj5Pzb6vulOwrr?=
 =?us-ascii?Q?Nf1APVX2XKERCEPBjhZloK1kSrD6bXja5ayd5Usy9tqVM+5qo8shtatVFRH0?=
 =?us-ascii?Q?GRoCdvcvnHmk23EVKbmh/9zqqe4MsK05TnQk2kE3Jc1Nh4m8XA1kzdF1YetX?=
 =?us-ascii?Q?0D11tgUD3FktIQCDgf0ilB4CfZ9TynTNhE1rg7qKn2dcOd0QS7DxD11ZvZIn?=
 =?us-ascii?Q?Zf8F+r5A1mFvP9/rmm/17gDsJQYIxtxjvHsni0CKJAwAytxTT/u8cYWLqGkp?=
 =?us-ascii?Q?nFOZ6ks/l/jH32d5X+/Nz6ZhVo17bd9ZrALGhK72SMu4niBqGdny1UBzQGN/?=
 =?us-ascii?Q?zYG2aS3+Sc8UXTMTuW2ypa91YM5E+yKgor8HR0n+oiVJC/ZEHKcuOP+U/4NQ?=
 =?us-ascii?Q?nSkRYPImVeMpbWpYeQzqzOhGoVWnZZKH7N+j64jQmpIYQ7bnyqbEb2IpLhBw?=
 =?us-ascii?Q?P3G/Pt9nQc43IbPixbZir/uDWBaVBisSN6QTIEVTO/UPbDBjInN9VGuH5xN3?=
 =?us-ascii?Q?xTQzrOzVRnTWnv6IFUD3sLMroDGHu6Qefb3MshdLSjJJkrVtBTTapnT5oB4F?=
 =?us-ascii?Q?kzH2OIgjLEsoyIqJOLRFoRrjtVlpsKvxxCemEPD+GSF/0YtjGGIzfyWGZXtR?=
 =?us-ascii?Q?SRIOGIn7O/f7QM9PgfM74wLAWvBlzc1Z60k2FXepXf+9Y1w9lvjdrY6gub6p?=
 =?us-ascii?Q?qZp7hBw44hpTSEACS1cRaJpIQcOa6c8TKs/AR5ZysZjQZeb1qLI97/Qeby5j?=
 =?us-ascii?Q?HNPqd+eUmzj1qkaID+1UQ/lWRNWlR5lXunguioXS5eT3tcybZKCYn7Y5uKGJ?=
 =?us-ascii?Q?Xeoj0aASdy6KEkzbh4LAeMOfl4dlhgV5TWlgxj0d8M3dah5VIaXfcyORqbzX?=
 =?us-ascii?Q?8kuRdLrYgD08UA7fQvSZ8PRgB/clNFHYL2/0DMG2L6x9oXL5v3F7h1KbbbyZ?=
 =?us-ascii?Q?Vjg0A5m10lfB9lsT8lLmsb2CRieCZn5SSG03RpElGvPCAFr4XUbB+pggEfcn?=
 =?us-ascii?Q?kTtgKT/0E/RIYBgMtExXv9pBmeE6I2Pr0LU66BhlfAJzWG8Xm+/q+BfSRtXw?=
 =?us-ascii?Q?LDsiMaEw/fCS2YMGxQPek7OjByXSwrBBH+HEdiiTuT3RFZzqRzS68C6Bzu5D?=
 =?us-ascii?Q?T8vA7GoCglMO7o/5vlwaFJs+beu5b+Ud8vhaJxJFCG1TRtxyC+u0QL7XGpGu?=
 =?us-ascii?Q?BVsW393VttucGfSIegX9NGe0yUXTngIsMe4wSO/N6bYDzAB9FPQx0XXq+naO?=
 =?us-ascii?Q?XLwnKGUa7NFiHJp5g4mC1vqaVOdP?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3faea1-e807-4c24-9ea9-08d90ae3802e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 07:50:47.2889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dATxNwWtcYqEpTq9RY+fHKqaW1eAuV6Y6MEi5EDOqR/mQlwdm1kojKzyAnF6BOEb9/QZfl+zpgTnwmV8AmrQiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1863
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Series is:
Reviewed-by: John Clements <John.Clements@amd.com>

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: Thursday, April 29, 2021 2:26 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 1/7] drm/amdgpu: add hdp ras structures

centralize all hdp ras operation to ras_funcs

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index 43caf9f..c89cf8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -23,6 +23,14 @@
 #ifndef __AMDGPU_HDP_H__
 #define __AMDGPU_HDP_H__
 
+struct amdgpu_hdp_ras_funcs {
+	int (*ras_late_init)(struct amdgpu_device *adev);
+	void (*ras_fini)(struct amdgpu_device *adev);
+	void (*query_ras_error_count)(struct amdgpu_device *adev,
+				      void *ras_error_status);
+	void (*reset_ras_error_count)(struct amdgpu_device *adev); };
+
 struct amdgpu_hdp_funcs {
 	void (*flush_hdp)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
 	void (*invalidate_hdp)(struct amdgpu_device *adev, @@ -34,7 +42,9 @@ struct amdgpu_hdp_funcs {  };
 
 struct amdgpu_hdp {
+	struct ras_common_if			*ras_if;
 	const struct amdgpu_hdp_funcs		*funcs;
+	const struct amdgpu_hdp_ras_funcs	*ras_funcs;
 };
 
 #endif /* __AMDGPU_HDP_H__ */
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
