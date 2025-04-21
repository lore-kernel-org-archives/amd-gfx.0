Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E1BC369AB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Apr 2025 12:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C72D10E38A;
	Mon, 21 Apr 2025 12:31:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bofu5wdT";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 200D710E38A
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Apr 2025 12:31:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukc7XmDDk0iVC2KPSHHuv2kDJ+Gwo+mPB6DzG09gxxox+d9qqDAxtZmvDslNhIakUK50sfD0R5VSqMLf1N9JDDCLhicpfG27PGyRAcIbc0pldv52ZaYb+FgAt9/gU5Xf+1c0ghI5NduztFtmOw6NJpJDoKI9+Wfsgg+jDyU1KUF2Zs95VxhorkDSwYLy7CV+lZ54UtuTDtGd7DhSrzuo7s2jjnyHu4zmXyme6vfkEVj/Z4YMVKJKlL7uVq89pAOkFcVW/1T+eeXLBlWr9voXQPTE0xIhqe1c4MO6kgkrHSA75/SmW0Uks43BjWZwgoxRXJc4mSNXIupFzK8L0ox8FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lN0wamnY3k0WMVcOh5KA+mYKq007ykMbDAe8XHYf/6k=;
 b=anjt8ureyrDIo89vnWTLnEPbJbWT3cS2D/iIAXg58fCp8lVVby4dikXeOFajrm8a3gjnYDFap7TM0CmSfwtH0llJvUKY7CHb4s/cwpiEnk+0l8q8uHi+ooXZ39cu9hIW28h2hDn6NEq6s2LTW1nwHkXRYLs2hurOOkEMt3LhXx7jSKRqN2/UqGB3cEgx/DhSX4Bt8030o8MACG2wqMHLfrGeZpUWIaH8dA1eOtuOJnCDf5rqgvpd6uCXJQxrJXCs5Sk50hlPlBOobNCG4beXyYX0oSk4F09oETPciNPpRp3i3w9FzPERoX2KcRG80Wcip56691V+TNS/tJ7ArEx6dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lN0wamnY3k0WMVcOh5KA+mYKq007ykMbDAe8XHYf/6k=;
 b=bofu5wdTJQkaE0sMVuJBv7yt3unJ+Axj4WTGzrUh1Pa+XNYh02jAVP6Pk3Ikd6TWEmH0ZKimbcxTs5QzbMwr0t9NpfpHoEXlUdH4R6ttPR3VBRRzDuAGgJzhS1T0PkMeO/uCIayNL9AUGSiE/14E9NchJ2lPjJwmUtesOmSfMhs=
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH0PR12MB7981.namprd12.prod.outlook.com (2603:10b6:510:26c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 12:31:12 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8655.030; Mon, 21 Apr 2025
 12:31:11 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Yadav, Arvind" <Arvind.Yadav@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Tvrtko
 Ursulin <tvrtko.ursulin@igalia.com>
Subject: RE: [PATCH v1] drm/amdgpu: update fence ptr with context:seqno
Thread-Topic: [PATCH v1] drm/amdgpu: update fence ptr with context:seqno
Thread-Index: AQHbsrfg6HGJS0GIDUaotu5nBTyLKLOuDOTg
Date: Mon, 21 Apr 2025 12:31:11 +0000
Message-ID: <BL1PR12MB57533E07F96B44E74806210193B82@BL1PR12MB5753.namprd12.prod.outlook.com>
References: <20250421122100.725187-1-sunil.khatri@amd.com>
In-Reply-To: <20250421122100.725187-1-sunil.khatri@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=18c475e4-a50a-47e7-9b47-5dc56e737e31;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-21T12:30:28Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5753:EE_|PH0PR12MB7981:EE_
x-ms-office365-filtering-correlation-id: 50a5fdb2-3f75-449b-eca6-08dd80d0668e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?4+OH8/X2aeU08gC9uMyFO7peRw0xPWzguJh8TS4Jsr0bBRNRY6nJccuumZSW?=
 =?us-ascii?Q?QT48FvPNTL5C8zOtWHXhfW33g4NMWbt9vw+Ilem/l25eK+eHu/OBx8R+HQ/O?=
 =?us-ascii?Q?dLzEiG8d8s1Sx4ihMZJ7pvdo1ZFx7YmXnxW39ZQ9zybkEZ7zqKSkekShCaGI?=
 =?us-ascii?Q?JEFJLq5agkl9DmUGJsBU61Y8PTREayrmiT7beIqX7qdH7XZ7EQ6UCuLtewEt?=
 =?us-ascii?Q?e4m2PxlU8t3PGKNmW2sfQ8bWJ4jLw5Bh2CdAKa1SxLJxsU5tu4rogPeYcJvk?=
 =?us-ascii?Q?xlGGuwXkt9VbBJFon9icfKhfNYtIp93zmMw2wc421RiEndHyfEfKxmjJc262?=
 =?us-ascii?Q?laJgn8Ys/CdUu77N4chGpX+rvfWtt5GNVXrM5LarJ38Uu0G2fOCZGwgZb9XQ?=
 =?us-ascii?Q?jI6ahD9a4M5/bznCIija1ashMzihnHq3nXNDfRG3OuzaYp/MoMcBtR6rJl3Z?=
 =?us-ascii?Q?Oyu/DcS0mw3H9wVDANwxm7MMpBQgnBmuUMpvDXTd3r0k7CV3OnNW5yG/ETdD?=
 =?us-ascii?Q?LEV15k4xdP7YwqUiBFvC8L1g7KTjYJETo5bt4/SkHz4mCvYyJ5wyZ/Dz+ANS?=
 =?us-ascii?Q?iot88Ci5LvC6rH5yswi1eGX+8qOVuuqXhJS9USnoee49tTnd64jqX2ezwyCA?=
 =?us-ascii?Q?at1LwMUo01MujzmxsYFyeSIcSdqwPzHChRlTer6fLEjhBObmJ+8EBu/qDR6X?=
 =?us-ascii?Q?JJ6CBeCDkNDKmtX2xjcSbdhZui1TP1YDPuFOpX4nfgv0RHEss6irfRCfq2uV?=
 =?us-ascii?Q?j29XDAp2GoyBSfFdRBnM7iZSXtBijtZAFBxs5qVy273nr8VQ0G7zsUBqrvO7?=
 =?us-ascii?Q?IBJXAV2uYLjfW4wRNJKwr9djkX5gNHum+JjimVbdRYP3rPUqkRpfdP1uFsUY?=
 =?us-ascii?Q?1YbCvjOfoNdU9W7WayZFt26QdtujLCSzJDFx6PQMxGx+QUwILPf/LTHbKCSt?=
 =?us-ascii?Q?LFPI7WGgTy8tDeCpSKTgHn3o9d/uM6pcAPBJLlpiM/ZfueW3rh9UpoGqhjDH?=
 =?us-ascii?Q?WUzwhVu0TDyFgwwJX4mS61lp9wRpFqb5eGW1dfnYl843ADMPBZuL7tPM05Hi?=
 =?us-ascii?Q?p8fVR5ciDfEHAvRLGevJM6jB4q8VBxMU43THV4Nv7VpBSH0m6waQN5G4Znoa?=
 =?us-ascii?Q?El7v4FMeTQlfe8KKWLVhtP2yilnUUp42I1mTWXpwYfsfAgR47oqYRLwn4YgX?=
 =?us-ascii?Q?Ce37Np8ng1f07hGzYJtO8ECJrdYOBGDbBpo19BprTDe1WPu0WNiQz0rn2F0h?=
 =?us-ascii?Q?UhbnxwfpieJYLCLONL/l5QgQ9+e9aaKtmN9Kqc+zmrJ/Vvc8nhxd3yXaLNw8?=
 =?us-ascii?Q?7oTTz8SgQuQVOIOs4wAH2DMtrp2/gv/OHVYZj9j6MHWy9Z4wKpjfGdxu1owg?=
 =?us-ascii?Q?COg2JE+AgZa3vGmiXjBPE4VdCdEIFXlm1OI2lcjTV4fo1K72DojvegBAyG2N?=
 =?us-ascii?Q?J26VXEBG/HjzcH4EP/G/u6KtJsyKU52xyXr3UtnVz0SQ7ndo12BoCyX8oJSF?=
 =?us-ascii?Q?6k37+SW6OQ2+pzE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h+A/7j/1lqlQfL35XqprmpY/ij5IFaBryDSKw5gFD4v2EW9CbBmtoBx7hCQZ?=
 =?us-ascii?Q?OKXFFGdDqo/yRLYsDyvkSjV7aS39TNx7/hvSh7yWTiULPtPSa9KMr7ynn7C9?=
 =?us-ascii?Q?wkDdgeqeZsKgon9oqRdpjL922Ga5Si/ARS0d0ZiWiFWuuKvz28R3t/EClZo2?=
 =?us-ascii?Q?AWZfIyCSMnEKrYKfjZFQilinsAvnup8GvCMhSFbQVA0CavcB/yhqZpyueaE7?=
 =?us-ascii?Q?jzzA0ScfLazxbXyIXK/rF8U+HK4unCdV8EUTkg2210Ji5NdIBOzMSuOWYLOl?=
 =?us-ascii?Q?HW6s7S51LGX8EF5UZ0m2qdObE4mygAAWLenirqp60lkrn6b3CBzWjASbBj7E?=
 =?us-ascii?Q?32jAN5oCn/wQb93uouXr1leoIO7I/TIsLaDn4mfFXzbhHld+PuLfaNc2FyXu?=
 =?us-ascii?Q?ucxsFOm6fqXG9gWO2YTt48/6uRAnDwIyahfYYkdL+ljH1lGN3oUgPJhJ5fla?=
 =?us-ascii?Q?Qp4TsOAeohlemVZsks9g9pwxm9g7z3zMRe19L92m/iulJHFNcA5XdE4h7f0t?=
 =?us-ascii?Q?CLhDTRDMyBj/dRfaVBwmw4CfJRpu5jDqnfNswT07H/9c8Ru560KBG3UoOX9i?=
 =?us-ascii?Q?53qjPRh0tdcjl/k9LgIQcTvcykPPQXQovM+Rq1jZ1fy7ClN23EOssPv46giX?=
 =?us-ascii?Q?ub+6wq+OCG/tiVoxHNAnA++Y0U1LklTZ9NfJQv6e62uUBllNts1cwm+yk+da?=
 =?us-ascii?Q?Y7yYY4VBm8vuIKo//sZFDwVItPbG8I1pD+2rLgYsDAVLLICu832qctDBguum?=
 =?us-ascii?Q?wvxXbej4HzynbZX6+L9dGTTxVGnLS5GxFmjlM2PYSv0YevdDigjLYixVHPXo?=
 =?us-ascii?Q?Lfvy+vAb+WhF8MzLC3bYqAun15GHufqedqGBztdiOqfmcV4zwr/0zZRBDkO9?=
 =?us-ascii?Q?BCa7Az8Dk7pAgIVIPWqLdLmHyXe+5VklqmEgnPqevqsOUOT8BMxxJ351HgQy?=
 =?us-ascii?Q?NpSaGmfWtBOV2McUzzKyDtm1c0s6CLs66uMPQ97xOdtH87OF7UM23ANk9/v0?=
 =?us-ascii?Q?StE6KW3ehLUZNSolaTQyoyrCXhFLYmYJgLuZ5PoZrt9VQmbRNr9O31lueSVi?=
 =?us-ascii?Q?IiVYPhxAVXLiqVIOZe0vFFPqUJfnb7SV0+lmb7A0Wa3E8g2Di8Jn2KDabluF?=
 =?us-ascii?Q?hj4JK+e7xYEQJEpkWiiHE29g0v1hg9P0WvIKCwnaZyetTD6mDvFF2/ze8bSD?=
 =?us-ascii?Q?1aEoGUlW8KHycGk8BBM17FVRKmPVp5xzLvpnq3Ln/tZUJ5/ixd2xES+x19UX?=
 =?us-ascii?Q?B9fQOSu+Sj1muUS69jKAGFjQ6GzDfjlGWYBZT1XPk0AQUO0P6raD2urP9d9t?=
 =?us-ascii?Q?lcvYS7xmbjtpyRZKptEkQsjBjIZHi+cs4b/WRTApRK4jAXjavc6tPj5ABtoV?=
 =?us-ascii?Q?0Cim7j617xUXOS4PmL72aw1I5ITRFdYXqxHv70d3buv3MYBNcig9gVq9rgfX?=
 =?us-ascii?Q?sf+WAx5lUMICk18yXezQJhdjIQzA4kfvmAXfKkC7vz661ge+Mepq1e7QFfiT?=
 =?us-ascii?Q?6DhGAW4TF/qvqVzI39M9Cc2AcQh5MDiwhlPwfX0CNRg6aoXRh/p6QZa6cOUy?=
 =?us-ascii?Q?9UfXiqJZPo1KjHTVcZE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a5fdb2-3f75-449b-eca6-08dd80d0668e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 12:31:11.8160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v7+00vbcUUZDt9XNOWmxd2Q8BIWxjSd3Dkg1FN+B1swBaN0vOIffZ6LdgGHCc9fcNOA/oJH83i1rx+JQuXc6KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7981
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

-----Original Message-----
From: Sunil Khatri <sunil.khatri@amd.com>
Sent: Monday, April 21, 2025 5:51 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Khatri, Sunil <Sunil.Khatri@amd.com>; Tv=
rtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v1] drm/amdgpu: update fence ptr with context:seqno

log context:seqno of the fence during timeout rather than logging fence poi=
nter.

Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.c
index 4be72bebcf34..b0e8098a3988 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -94,7 +94,8 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr =
*uq_mgr,
        if (f && !dma_fence_is_signaled(f)) {
                ret =3D dma_fence_wait_timeout(f, true, msecs_to_jiffies(10=
0));
                if (ret <=3D 0)
-                       dev_err(adev->dev, "Timed out waiting for fence f=
=3D%p\n", f);
+                       dev_err(adev->dev, "Timed out waiting for fence=3D%=
llu:%llu\n",
+                               f->context, f->seqno);
        }
 }

--
2.34.1

