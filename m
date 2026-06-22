Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A005CDB46F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 13:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6D4810E636;
	Mon, 22 Jun 2026 13:05:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vrMLLOZg";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012057.outbound.protection.outlook.com
 [40.93.195.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC13010E636
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 13:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNnDZP0whg/FSYNBOVbqsWq7++gFXbPs4xdh58baWWKd7XiOgKG5uzNRxSShA0prDLQXfi2dQszdD6epoKQll5h3m417C8iS4wVv4/Rae+t2oo6e2nLzUlVGdk0zl6Un4BLg5EdmV7lun1K0kboWT8GNRrl1ouugWFahD2ffAafZMrNhdoBKG68yaCzGSr06y+LDviYv/vTtNCkx02wN0sp5hoxdxY1EVtFuYZxk5Oa6Yjx4uovxyVVcgRlidW/5cIAAdIlQWJX0e1QLzn0IbQyJK0X7O40IGKm7DYfPsYQf49VNcX0R5EhTym9rjmJTdIEHW2rQcwN3WDHiGcaQpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7NIijeXxFU3uC4zCXGn7q6/fharba4rzWnugoyEv4k=;
 b=Bc42HkV8q4zuW/RZ5iavHSxkAZZuuMiq4hxjRRVJ48X51NgdMZ0vFwxDGtUK/Qrw9vjXHHyoQIug3mAeDBep51/4hyfyI4uTcjbGlv7PD1Xy1QSK3x0pnZHSoG9Yg9GEoZpzxKSfGi+WiHUvgv0mWNdfKNHG/1Sflbeb2NJYJ9hgXQLHYfrE2afJ2lwAyWW3GpEpZzqQitO63TxHnahi1An4eXJxAXeNdDqm3BIE1wkn+naFmT/lBFp88Qrkqk5e4GA0gGJo/T+zzcmQgWrRM/fPMkCJaIfM2oQzyy2MF0Cb4yitIPI6AjLceMGmohAMjm0HweivIMXrcYA5KS792A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7NIijeXxFU3uC4zCXGn7q6/fharba4rzWnugoyEv4k=;
 b=vrMLLOZgb8Z5kx9GmCb84yUC79UGkfHvotsErhtf/O2MA4Kj000Absd5msBDgJgoJPPzNkhUE6L+JfQKEeI0b8dndT8WJIIy+bU4BOJJNRwnAJkRBS9HZNMJDhEcpfhStpTDKj2vydaRInMyIpfQNAGZ+u0iEMBfEsdO21EhIIs=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL3PR12MB6545.namprd12.prod.outlook.com (2603:10b6:208:38c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 13:05:03 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 13:05:03 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH v2 2/2] drm/amdgpu: re-set ClearMcaOnRead CE/UE in late
 init for uniras
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: re-set ClearMcaOnRead CE/UE in late
 init for uniras
Thread-Index: AQHdAiBldJhw2bfsw0eaECS6qUpMwLZKiyUQ
Date: Mon, 22 Jun 2026 13:05:03 +0000
Message-ID: <BN9PR12MB5257D98DE2F6AED168614612FCEF2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <6396c0ca408e0d8806a0f06467def1d69bf0bb75.1782116341.git.cesun102@amd.com>
 <4f4a3348cabace3a7a192761b6c89aa1147555d3.1782116341.git.cesun102@amd.com>
In-Reply-To: <4f4a3348cabace3a7a192761b6c89aa1147555d3.1782116341.git.cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-22T13:04:46.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BL3PR12MB6545:EE_
x-ms-office365-filtering-correlation-id: a1104022-a689-4257-8686-08ded05ee00d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|22082099003|18002099003|11063799006|6133799003|4143699003|38070700021;
x-microsoft-antispam-message-info: 0QjQAEgN4Rh9OPoxoXVN0CrF15jSNTkNv3V9+67EwY4IgaVxYUW8dymbAdECkaGRZ4JhkQrCkWCCsqBnMNkfDK0/ak+7KO7T5Pr2jaxTdZDBhioxlTFMOnNX6sENdxl9FhQjDbSDBkSdZVP2jAQjSZ0U5Xd8Y02os+n3EUhsXGl1MREjk0S7w1d5Qa+BLCtoNyXsqi5SVzU+q6fMwQMYSrM4kT19sCHG6ELfUOO+2AaRQG/U4mGGjsET6fFXJtzLierlTFTtI3WfJzC8czoXjMzLGpi+YvvIS3ZSkM+kS693kAojznp6nnxlgNoxdUH8pbdZu2dNrmjTNivxZ8G0Y6WIJdXegL+M1gVx+lIaH8CNx8hocKQ4U5zOndgsQNVd3nldyIEnQcOfwbysTMWqn8TwA6uulNHUC+P0nqD20LfPHbSaql8i3rI0k0l+Wnwpj3eIL3G6CkjCqildB8Mk1mXILVseAlxiIiN6mmslDsg3TAgfzwR1YPIIl+L62+SQzgO0VRPxuMKMOjJx2bqOhtBbuCgaIqkdIOXX0PDXbuDp8bwasZuCwqM8MWQ7e/Q+VNeB6qzf0/lEVzy9dVFjkE+lJDsO/YmUBDMEqkyBpMEyj3rP3IMBS5cFhpVURbKOlixn4dVW3VFMv0vB5RfCVymmmMayhyz4eK5UkL2pg1trulj+HIhEu/K4hi/QnDB3K93OeBpP017mDikatnL4wVx5ClLBsm6Rsq9D4hlwJo4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(22082099003)(18002099003)(11063799006)(6133799003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v46s0CYIXPWrLK8IgZjpQ3UzLDtbhXXqRYsyjNpZTnRnXg7yRAWhtcYiKUrb?=
 =?us-ascii?Q?zj3F3OFxceNiQmMbdOlAOufY8Sfv30ZojZwpHQAkhREdTqbkCNlJIq+54ZWN?=
 =?us-ascii?Q?1udwV9qFGy/3Bp+yiBE/s6Wm905wvswLd2aWmPoX5/2JuKE3DAOZw5FDVe4O?=
 =?us-ascii?Q?va2jtB59gdwo8g2v3M6Su8O3/P3onnAOPo7lzdx+MLq0myFHPR4t35nQcJQt?=
 =?us-ascii?Q?uzel67guzu9eyKWoYjSQFK01rwofjRKM9cdVRbZUTmGX3hy8PvYvQHMqA/om?=
 =?us-ascii?Q?2yHB0nC0F+9Q3fiAS05JiFDPtkvrkj41QHjk61SBufUfVSN/YBnXjAMwamA5?=
 =?us-ascii?Q?UR4cRnT3skRdCuXTyNNJPIpC3bjnU/YBm1+TWmmCAVjSFroaZ+sKjTs7oJv8?=
 =?us-ascii?Q?e/SzxSuuLB2+eeQgceVwdm7/19gLJJMSMNgINTBWzONiLLhefhy2x+ZJ2xt/?=
 =?us-ascii?Q?csrz/I1MV9rz5C35v1wt5ROwTzvy9uuyChrRs6FEjJIXyQj2186dZD1dTYlk?=
 =?us-ascii?Q?z7nJWCDYfa0iHoAXJGk3acb0sGdm/pShh3EM298eu4pAHhyz2C9HjC/WflmY?=
 =?us-ascii?Q?QR8XgBkh1XZ7iMEt3kKLHH8fDDnhXreSo9Ic0XSPMjOoIRWRV+YEiBeTNOVf?=
 =?us-ascii?Q?yNnR5refRTsVyrZT4PyQX8MbemTqXHps4pNVFQT9qBKffJ2KmqgSIIVRRfr3?=
 =?us-ascii?Q?yyDjizvh6vjkZjxRvS6A4TqPMyNqkRUn1QmggxQylnQqRYb5scW290hlxzYa?=
 =?us-ascii?Q?BKinyekAZewsrJDWUI13LnRgoG+ch5mgAEhURCw8+oF8LQojo/Z5cNv86Jmz?=
 =?us-ascii?Q?Xr/MxdSpPJ0RxLbB44WfteT6iNWmt0CkYyH72b8b2UiSnQVi3ZpeO1SKLJxy?=
 =?us-ascii?Q?BIYd4oGg/GOgIPbDh2n/LVb4ZDigodKXfCzYSb8EtOaxmUrdMhhxXbfaL4Nt?=
 =?us-ascii?Q?wOUUIFy7wj/vv7i2HYSS9Clqiug/bZjHRbF1L8IPI7aXfdsVEEf2FNorMzbw?=
 =?us-ascii?Q?Nv0Mq5jOKahq7PdDN0w9iuv0A0T2VWdT5LD5FzFIjkmVQo6uCMirGzS1BtsA?=
 =?us-ascii?Q?xSyXuJp4SfxyYxgSL7yMlRSB2kQkJPlLLuHOoynpEXbgLb5bGflP8NUr2i0U?=
 =?us-ascii?Q?GC/5mvINf+CX5ziqb/JEX0ssLm6C+JobBtHcl42K4dh4c/7fDoPlCZiiRm8Z?=
 =?us-ascii?Q?lG2HjgYhu0t09aVW1t17oceah7P/eyHWGoT5ACRRNmcLoERgu3ZFV9PqYnud?=
 =?us-ascii?Q?snJ/sGk0gucq6Zg+yn7Xe9dn0TYvYDOlmegdXI01rromojfx+IASbzjkCXEB?=
 =?us-ascii?Q?pyr21Lb1t5JwYB5ORuMmS6G0DJvlDvYC4HH6rxiNP3odBLYsmTqBsl0jaVeu?=
 =?us-ascii?Q?GYwx4I9x9cY6pBJ4p6j0/vubMIK7vXwusG+m8k0z3hqZvKdJtux4lFkDxmWA?=
 =?us-ascii?Q?RHtl1h0SK6vXQzW6YV9xvG0YxyEZnRQHdHj0HM4uAPyBEAW45Qbr2QBWklRn?=
 =?us-ascii?Q?vMgwT8AXJGqvYAYn/HD83BOaUba9cB49Ue3bngHGQvi6hkK4F2UmpRvF/rns?=
 =?us-ascii?Q?MSY7rmrQQdhOA3iDxZib7yqpm/rp0BK0aTTrKQDvXFO3019bvxEedzznRBbL?=
 =?us-ascii?Q?Uoi5zKQUxMPviHOSSMpjlQC6FNZPggqGv6lTzkEivixmziAaM6RS+rPVbtbn?=
 =?us-ascii?Q?qF+WiV16LB0viDnpMxUnJ1mvC7ytSkCjGjdbBd7UQ8e+wrAS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1104022-a689-4257-8686-08ded05ee00d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 13:05:03.6825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kwfr/x/gpnH2/B0h1INuRc0vLs2sC5xroT0vDLNi9ThSUtufp8KZCotZrh3TtW1WW7NsFWdIRjMX/6HSE6dwxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6545
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

AMD General

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Monday, June 22, 2026 4:23 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: re-set ClearMcaOnRead CE/UE in late ini=
t for uniras

Re-set the ClearMcaOnRead flags for UE and CE errors during RAS late init t=
o maintain correct MCA error handling behavior

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 465f82c660f2..953a35ec93fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3903,6 +3903,9 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
        if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_ras_telemetry_en(adev))
                return 0;

+       if (amdgpu_uniras_enabled(adev))
+               amdgpu_ras_mgr_set_debug_mode(adev, false);
+
        list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
                obj =3D node->ras_obj;
                if (!obj) {
--
2.34.1

