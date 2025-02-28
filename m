Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C43C19F32
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 03:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7FD710E12E;
	Fri, 28 Feb 2025 03:22:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TEQ7Z4BH";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C46110E12E
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 03:22:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deBelkYYPimRYnmHIz7A4milZNvOV7olcLWxQZ5l1DBZVIh1gy870HZK0hxdavB+diXSaAum1TPgxeRBRgC7JbYWp/gABL/iAHd8fKOUp0UUj8atQEREo8vB3cfq6MA1ZR+6k5kN7FB5Lha5R4VTvr8UH89QOkRbfjJVo0DjojTsL7swduae3ZZr05Jf/0RQ6DIgwSQqG11+qxr1KSi7x57lzPwysos73EHq3djmlgbwDuXMyKnUCR1KxbdbNhj1LuIQIzL1fjmw58EYsNI25Ua7XQ6UHZSQjWb60gx3NUw79EKxY4hoQEde4gAf2nZ6cay2e/yYsg+T2JiMMHU5eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbygPSJ4irCUFXB2mWmKzEc0P1sQbF1QemejioWCcGo=;
 b=RzbLFZBFWPpgHXib6aR1KBDZYz074Pi1NmtcK+EEq4haKFwbTbPaxFtMH5dSUJL6MHVGqnH3LUdwNLrIPNKTKtN7BNDphuXI738PNzIXVlaql06WJxP72+7jItnNXk/ctwypAsILb4EPcSpSKNRa6HL29DSLrOcwh4+EAJBXZYvQUPL+YBlNxwm4WXp5NGy+TxO10Ib5Qo5gN3hulzjCrE+MtkzkfBWUhoHn+ib/BgNSC6RsNShe7Cat2o4zvdSEQvOBSC12DeQbUf1uWUBRGTVGLYU2MYpMmHkW3+HQXs8LbaHI90npduJ8LTawgIMxgrIbvActdYboXasrAmuoOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbygPSJ4irCUFXB2mWmKzEc0P1sQbF1QemejioWCcGo=;
 b=TEQ7Z4BHqRjfIX+2Cr3CtB0zI03zWxIoAtSGchdoF/BWt4voAm3JMeZ5FqX0w78olKOM3/ZSlKhPIFFLo5rFx2+c3AgZbD8D6PdvpQr1mU8mgE/Y8oGwltUr4o+iGH45ibrfct9TMAUB2bn7LPQgJaU1itFKUHZxIDGhFq8HxSo=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ0PR12MB7005.namprd12.prod.outlook.com (2603:10b6:a03:486::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 03:22:08 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 03:22:08 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Free CPER entry after committing to ring
Thread-Topic: [PATCH] drm/amdgpu: Free CPER entry after committing to ring
Thread-Index: AQHbiY6aSozyLhA1vUSUeizG1exe9bNcDCgA
Date: Fri, 28 Feb 2025 03:22:08 +0000
Message-ID: <BN9PR12MB52574D70F353804DF6DB1911FCCC2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250228031212.79557-1-xiang.liu@amd.com>
In-Reply-To: <20250228031212.79557-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fa6530d3-a675-49a6-a54c-8de0ccf81824;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-28T03:19:54Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ0PR12MB7005:EE_
x-ms-office365-filtering-correlation-id: da99be45-3ef3-4465-2a2a-08dd57a7156b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Dj0l0qdLLXeXqOLdVJr/3ExKQjCf424Ap0q5j5upkK/Aehou7BvRKLw0AFZ0?=
 =?us-ascii?Q?X8wxXxrLZ864/7TCYMiH4TwgEd5vdNwFSemXOMqR7BpynCLvoSJqeMshGKXk?=
 =?us-ascii?Q?+x9N9K0+Qius58WOs1IxLzrXK1hKMvL4bAB2s4Zlspp3IjDPvAGjhrehp4kX?=
 =?us-ascii?Q?76a2MZbkpaHHh8sESOhYOyqezam1HRxa/zRbFkQjGutmfXRA4CLJ/HzCFG1P?=
 =?us-ascii?Q?cFpJHmz8YjfyeMyYVXSCs+c92NUHgKgn4dU+BmY+1D/Gk8soVmUMCgTI5pHQ?=
 =?us-ascii?Q?wmgIotVzb3EC9j4qJuZ1hab73c2QP8vjLfcaAqXVup4pRCgJzRm58UAnw4ko?=
 =?us-ascii?Q?NQmwobIuijXzbSksdeO1DtQDaKCovtbuoucEfC5yFl+vKH0GHCszA6BBz4H2?=
 =?us-ascii?Q?orCtcYjho8w/AAbVATYIdRK8MMpV5SjwJzzuylfRGvhypTQuu4aY0fymXLmj?=
 =?us-ascii?Q?h5RNc9El5YAHZpoLgdtDEC3tG9TkxQF1uDP6hnPw1dLZklAhzg1ConloR6u0?=
 =?us-ascii?Q?IxN3esmT55ZeKX3kWGpfTWvPmv5ggcJRho72mKFaK+FTsJn2ttIDq7PwSpLs?=
 =?us-ascii?Q?Hq3UJSy0irxRVgrinEjBZ4pGkVcvRMtWAf3ElzKRySlg1Qu0dRHJj8ci5Y3P?=
 =?us-ascii?Q?rqQ0xEHq/lM+zipMUqrXWYywJS4u1dovP6wJbALfc+Gtc/t099pOlGqhXhzO?=
 =?us-ascii?Q?ywzFhxb2OPm7oV/TZOoRuQKGOdiqph170LcrN8HRypSHlQbaHKj3zLIXZ/Z2?=
 =?us-ascii?Q?w0yUy4C6pBhNiE9wjWCX+xa1Ymgr0Z6/8y74fq3D4Hd103EsAanvaDJddP9m?=
 =?us-ascii?Q?TLUGJ5rBIu8KCTL6vDEB8DF3nz/gwULDl5abl3tnXt0WFJwEyrkY+7e6Nyre?=
 =?us-ascii?Q?OqP0a58DIMJ3xG/g+hqOVC6Q98GPqmOZZvKuMlOAJV3BFuymjkZDigX8mWo8?=
 =?us-ascii?Q?EaM06iVK+EiCFlCIr6QTRaEfA1YRQ9JuxQSdXSBTDk1VarZVrJmJ0WdnUqso?=
 =?us-ascii?Q?VCUTNp96DnCKXwJAzFQdXzT69+LxNV2iAL3/vkDbIYX8cmLxy164f3Bj3DHU?=
 =?us-ascii?Q?kpTn2jJbhlLsnawpLcrD+UJ146LDP9Zkdaa5CahwXXNeGuBwxPH8YZPGihUG?=
 =?us-ascii?Q?mjQpy8tSHC7kl9YbWROo7V/0vz/wkXJSY6FdJJv0GL9cDDF4YuGjoazU2FNA?=
 =?us-ascii?Q?mEVJ8AErixLzazp8pnrR5RFcQDtVnhi0tpLZiKHqs06t3qXiLb8aJKePUlWN?=
 =?us-ascii?Q?g8s3At9PcUJ7stOZMfnW9rLnHtNXQwGvYMbrPDmLIocDsYhSc8T0h2Ey02Q5?=
 =?us-ascii?Q?FVcL/mXDrnB6/V+wkrsCzicoi/UetqpkhcIXqrQdsCDKgCsGNNO/47FvVvgH?=
 =?us-ascii?Q?rXvxvFlOYE8z2WaXv4Fi7I+hXqggnmMVQHPywyuXYF2BpkQSVuTUl39JCJpK?=
 =?us-ascii?Q?cPjqH6BSddKkPmrV5PjfeECn+/02WQa8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UXYavzNRsdPBhgxoDEShG0GIQ4UcrWUZXYOs9gRENDlsqrXlPmCF14DeCM62?=
 =?us-ascii?Q?6VeGb0Jc+JDsw+krCPNXfvxIqn5WUK5l+B2La/PyhSnoeGD6tbS5CZnJp9Qc?=
 =?us-ascii?Q?0TP47ZWFpr+oev2m8/Oqj7n1pL7H/baP+wCe52VvedmmYvaeGSYO1CxG5ZNc?=
 =?us-ascii?Q?Gejl9lnippu86AHl8un4TEmj+6hH5AZA5IZnboqLReNhJ0vKEeseW4+0KewI?=
 =?us-ascii?Q?K62ye15XaNxaR4/wMlxVrKxHohBq0ilA1wbUNPnPIkVPRQ/lRhBSonObNoqq?=
 =?us-ascii?Q?Jl8Xf1YJKreIFvVmU9uK0KsUp4MrvKP4AQYu8E9DubhjpvASSUuUvb8U7epx?=
 =?us-ascii?Q?wtvUqx+WEcTVsPaVJN4fH2X3q92YLxNCsPmtzayGqop/EdzY3Kq++1KceTAl?=
 =?us-ascii?Q?WBwxOaA+P/CJHCD8d+MdYik76LDdPEFW9j1STpUIYku1F2XJJ+d4xF+5OYy/?=
 =?us-ascii?Q?RygPhy/rRM5W/8q0Gz5FOvoq0qXyqr8bc1hiOF5KftfwuszGKESTQB2fazLg?=
 =?us-ascii?Q?ZgESRoINwhuBcXkjCPy4Y8/nd1VBOssRFh6GjSS9AcdqAqoOIExlVoTBL8pt?=
 =?us-ascii?Q?lzxvGp4QHSeILPDzcRPTNKM+NsSVDxvNMFwQ660+BW4kWDWhxNv/QQomqDyR?=
 =?us-ascii?Q?qPFVIZ2U263tq7BQiLcD3qLbYXMVm0bIyHJGzzLfiAUM+LFrW0YpVqajW9Cx?=
 =?us-ascii?Q?F4efVWhlgS+y1UBjtycbcqOEDzVsXOV/GCStaQQPRyp6rhxxSlLqZEoPl8cs?=
 =?us-ascii?Q?sXjJD28J5X5+fSc4Jl/WjF3aTVYcKFZtgt1bEAHvfHznd13WWdFYNzfTcKjJ?=
 =?us-ascii?Q?bc6Rya0w4hK5G8Rzs5M2XV/vUqpdUKrdRyof4mONvxMuXO/UcguCLZUG5ym/?=
 =?us-ascii?Q?DBNUJJHnKYY+C8XTG/ouN8pq5tLiDW+xOvOfzsVrNlNDkK4wKmIxTe5WEk6U?=
 =?us-ascii?Q?lkZW/E2Ge3hI/+Bl+1bQkTq0JF9DJCs9hc53bBQEpA41bw6ltr65X6/Itjoj?=
 =?us-ascii?Q?tzKF3vtcBW7Q8/5nYtQiyXwPpBlgn7gv4qP/P4Xy7fSlMn40swApDu4oSHOE?=
 =?us-ascii?Q?Cu8z3lFTFFce0dZU/gsKBfDXjOb3AT54mj9lE2iTP8ifPQof/YWjhiNir7Pb?=
 =?us-ascii?Q?td0nZi0rluzR/hTJmeTryBxutxAFMUmLXrrrPf+ygfXt2GYfm+AFqL0Ajdlk?=
 =?us-ascii?Q?wnODSm5wKQ8ZWtQZnaATAjwd6qYWQTV1IgQPtk84PkiIQ3EBwZnBJdE0wD/k?=
 =?us-ascii?Q?XqQ5ZgalZIJez16kq3RcKewyeG+P7bz55KJA6gp74m2x8KM5CiF/G9etslNC?=
 =?us-ascii?Q?lU2nVuzj68febvYahv1YTrzVejW4l/n4W2a0zrisllokJbhevvBev+MqRJGq?=
 =?us-ascii?Q?HwIlRR/Iki0oVjssIFBpU9Yu084G+o3+fvnoRo3w+CnBgyLdFC1mpqu6+DdV?=
 =?us-ascii?Q?UDnJJkbBCy4g+3nBp0GqqmicORaoT5AqkVHm53wl/caI+EOC40jQAQpWh8E1?=
 =?us-ascii?Q?1wC+l1Z8xn8GtVO+e8wsIOy84bryTCInTgVsgBwj3t4sk2RLkBca8isss/lo?=
 =?us-ascii?Q?gTnzJpA/1TGuaBQdt2FguA4d4uNc0k5WJ3R+4O3C?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da99be45-3ef3-4465-2a2a-08dd57a7156b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 03:22:08.6499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nikhqDYF1rPapRJs0hXBYUEZ/iivcuHGx0IU9Uz1j2uNyiNmt9B/H71O2HwvxVwN+XGw5EjVWbuhghGx5Zf9WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7005
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Friday, February 28, 2025 11:12
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Free CPER entry after committing to ring

Free CPER entry when it's committed to CPER ring to avoid memory leak.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cper.c
index 15cd0a007b71..0415ed222342 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -301,6 +301,7 @@ int amdgpu_cper_generate_ue_record(struct amdgpu_device=
 *adev,
                return ret;

        amdgpu_cper_ring_write(ring, fatal, fatal->record_length);
+       kfree(fatal);

        return 0;
 }
@@ -323,6 +324,7 @@ int amdgpu_cper_generate_bp_threshold_record(struct amd=
gpu_device *adev)
                return ret;

        amdgpu_cper_ring_write(ring, bp_threshold, bp_threshold->record_len=
gth);
+       kfree(bp_threshold);

        return 0;
 }
@@ -399,6 +401,7 @@ int amdgpu_cper_generate_ce_records(struct amdgpu_devic=
e *adev,
        }

        amdgpu_cper_ring_write(ring, corrected, corrected->record_length);
+       kfree(corrected);

        return 0;
 }
--
2.34.1

