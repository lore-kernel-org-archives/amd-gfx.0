Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC04CC25B78
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 23:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E26D10E336;
	Mon, 13 May 2024 23:14:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u+U8QQFI";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D877810E351
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 23:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bubxO/RAZl1TSHidrR1NJUG6/meiZkt++xabo6CHNkBxGbWobCPsMUtjZH/JEIK/X/ElpRY5hMUhxynNq6oWJWd4Mn418iQV6cuyCjvqckokq0CjmYwguTpZMGabc7in4TkZQLXPbbkVHddAdlVqowEVzfEmIqJj7kVfAckNHW1JkvYpzRFPga6kRwOM7cIrV7y9WgAjpbeoUd6d2nOXuZy2vW5lUxo0pGwKQm6vMuDbX8TcAE/buVB3+DKp/z1uoOqW70WOtW7hFv1+XYrX+0d7pCGW0CsEbBOwGceuMHP7R/JVc1e1EzH23YI2SbXHzZ2kzhx01nsJoeqzn7mpRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDyRB4k2dKGMUPo83QFDpjsj8bcmAMvw0/YLuF2aKGo=;
 b=V37kSbRMBBDhehsD/6Yot1HduAG8V8PbsV062vcCE1dMqU3lUXyZSmDH/M607CWf6EK508GoJsvQaElIVOgN8U8+HJHEFCK1o14MAUWBxxQS1x+3Dj7SxsGPGcFiMcozT5tNoKej0mI/36fg4cyx3fsG66iYB/jl8vRm6TJLGAnFmHgAYKg0PzLWX6ENDo96I0M4UfJV/qGOjTAKqiRQPTPWWBmtOJ3Jl3MBtg9e6KWw/+zjskcCjUqg87SaNuhDPlS32Al4BW+N6Zb6uowmHKRdcP4GwqqQ2/z8m6pFSlCZcV5rQ7Kkx093sZz9VzBk+EOwfgQRfzE5b63oIA6kjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDyRB4k2dKGMUPo83QFDpjsj8bcmAMvw0/YLuF2aKGo=;
 b=u+U8QQFI1O8MqFCxegvwMtns5ComY//YszL5+YmjOzJOVQ2PNqm2sRtSf26eKF+D4OJaiPEshn1t+XEzv1zWzIKq6HDxH/urx3HokzmEXTNihWOyVN4yKiB+VgGd1MR9wYnLopFx7ZVpezMX6FRRVIDOLY+LS/4SJpPwY66m6dY=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CH2PR12MB4053.namprd12.prod.outlook.com (2603:10b6:610:7c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 23:13:58 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 23:13:58 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 3/5] drm/amdgpu: Fix null pointer dereference to aca_handle
Thread-Topic: [PATCH 3/5] drm/amdgpu: Fix null pointer dereference to
 aca_handle
Thread-Index: AQHapRN8aAk8xM7IcUidRvtpIwZsQbGVyjqw
Date: Mon, 13 May 2024 23:13:58 +0000
Message-ID: <PH7PR12MB5997912FE549D642FE2AEE5782E22@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240513085616.584249-1-Jun.Ma2@amd.com>
 <20240513085616.584249-3-Jun.Ma2@amd.com>
In-Reply-To: <20240513085616.584249-3-Jun.Ma2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a821cc07-7b0c-4288-8eee-a844da640b7e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-13T23:06:30Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CH2PR12MB4053:EE_
x-ms-office365-filtering-correlation-id: 29143986-c965-475e-f3e2-08dc73a25e48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?8UJ//c16yQ341zQqkYEzTVljVjh9FkGSo85BiOSZzEH7QADcj5d1N/4nGUj+?=
 =?us-ascii?Q?4gn9SFbWuEjsovUOFf6T0DRKm/trk+QES4QvJ3E2nxcKvT7wnN5HsgiMfwXW?=
 =?us-ascii?Q?87nhEI9MlvvwkZZRfvyA64DgTq6PkMuue+Hszq0lMt4LZ0WE+8Br5MJtEXn6?=
 =?us-ascii?Q?/nmCLRg/mNIWKQCN5ggHufJRpkvOrAHJ6EjNT72ghVwFtXgUT2tNEhrLB36o?=
 =?us-ascii?Q?iT2d29pOXfgHVhFSKqOQL2p/IJvG8bhhmXHIWOWVgJUXsVlcsGWTkMam8A5Q?=
 =?us-ascii?Q?QKTpMGVaZSd9DZ/Mhh+fm3SbFQeGvbz+k7qUDVKTUPDKgjYl7em7mLH8GdTu?=
 =?us-ascii?Q?MpmtbNwEIpfXp9icIhdm/TGAz3kLCRz0x3NPGevBhugihP1zFF0PsOEb+0li?=
 =?us-ascii?Q?at0x1QW5UBPPTxACwHHZs0hd3vvbRiTku4GYl8EXy0RhSOUeJ/SbjFovMmE9?=
 =?us-ascii?Q?7E4Ba8rXXjt3U7iehvFjkKtUDIhy1CHf2eQc/Aj5JWSdi5WE858iZ+sd45jK?=
 =?us-ascii?Q?nVZvSLJShHknt2C18dfbuvAFD8HbbCWlxTBsWbZI+uqyr23ewaCU6vVY/VuO?=
 =?us-ascii?Q?rT3GG18KORr+UXUn3BDHHNXB+8GXHINCuUo3m2fnw2cQ1tuVeb89FV3bLndg?=
 =?us-ascii?Q?UKzAsXqiRXnR3ZlnMx6hvkcPgaf3RHGp6ZzX/ZuNdYAYeoYauE9RSf2828Gi?=
 =?us-ascii?Q?Vng2+7tieJZBF7IWiMs1niOUq3f4sn5+9O5QL5DPJlrsdf0w0YhMbTyXuF6r?=
 =?us-ascii?Q?nMFOvXZLxI4GMya7rscZ9ayBCbPq5sboaFbxYplzQVEUHkj/lhI+Ivt1x7RW?=
 =?us-ascii?Q?6jC01kvG0S0pXXIN5rE7aghA3OmNZYgNFyjHR4CYJJI5yHQoRfB976kGEtYS?=
 =?us-ascii?Q?tirGpnufeee1H5X2bXC+iLsatpzUQlJsO8YcCXEu3E2OTwvOIr1/Semkv4Lf?=
 =?us-ascii?Q?Cg19QKq7QCq8ezWLbTj5Rxxb01LM6SV35964J0ZK16hH3JwLg6FjZMfgQMzj?=
 =?us-ascii?Q?88+Y26W/psZubZbA/+4fpgOU7Vpz8SfADYPniUh9BsQUvmz0AL+L/2/uZNFY?=
 =?us-ascii?Q?52fk80Yp8HHm/N6QoC6ftE3RtFFAINh8sYdPKqU2i2JzAbxNnyrfOzzcWAX8?=
 =?us-ascii?Q?pKgwENsBnWyqLCS3nT1CDzTX1F06VOYrllE09EwM+XdbBo1ZEOzgwpATebB7?=
 =?us-ascii?Q?AOIieaH7qumfmlsxZrAYRxlWZt1yAwOBu498EKP1XihqRU0l9iOxq7cRnEUj?=
 =?us-ascii?Q?X/kwKEkYM5i22HoTpVgM/UgZFWLyKpdOxfEQfbbFBD3XHFaje1RDQS8Xaj/0?=
 =?us-ascii?Q?4kdHzFJwaNmsiYHb+E5NSOE/QDMn10VxgoIKBDd/n7aoJQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VaT5bKi0v01El+POJqcNMaF4+cC2T0Fn/4NITzrK8TDIqlGEsTpooDk8jAB2?=
 =?us-ascii?Q?CIVkdvqj7p/1K9SgOJB77IGVZYEkwLi8XFgu/rzhLL9pM3wff2wLm/u6F/vI?=
 =?us-ascii?Q?TN3rVM6UKLJ8g5BJZIGl8vq9MeM6jlPS1p3n9j9u30r9z8vbHSEtdPAk2A0J?=
 =?us-ascii?Q?UT3zG25esh7xWeoaOjDSjBS+ea9mnZxWxBnAWg2fF+F8BzzRsZiBmmSb55Vo?=
 =?us-ascii?Q?ADQ1ifNaUIiiLwfjAb3SeD9yKi0hd9SrySD61xe0CNDaC2jbQN49XYhVb/6q?=
 =?us-ascii?Q?TXk2TRVrVSzlf1hmcM9VWFO/t+rZL17U7OcDecbWcsEZ90a2vY89kedSBBib?=
 =?us-ascii?Q?st3R+dPxJ+FPQHblpmPyaJ8nEJgcUn/E84PaxPfYw2FnTkDj6qPDKrKzNIdU?=
 =?us-ascii?Q?pf8oGUmJANjeJr7aWzPtWjhFqRu7rkVwHjyyFUga2VtDx13h983ov1kHFDVA?=
 =?us-ascii?Q?D/KmMc7v4+SZrW6Bs+eVCzL20qSc/jMLFcMe3v0WLQEWWnKiYuYsdFtzEs8i?=
 =?us-ascii?Q?BJS1q/mw60bv64462nKDZJOgecKDKuKsEUzVUs11F6ss8laSg/gs9VgZhjtz?=
 =?us-ascii?Q?CkegOzVolZs+CHxEZIQPfJGjUQjceB3O6m8Z0QHjMnb2ZgDwPa++nsBePEA2?=
 =?us-ascii?Q?Zf/UV5gGh0YkfSn8DOA1k2oTaTLdYFs/RKpqeH/RbW4NSCgexxCev5h6+JDV?=
 =?us-ascii?Q?tOPqdPs3agzEh7Y2SddmHJ7nNexe5OZGPOj54G2dFcfY9daMix5Qifyw316v?=
 =?us-ascii?Q?nncYjdP5Loh8Ph96bXFQS5BN8QnpMt0kmNj7thDdibzbERHUpm3l2Svms6Vw?=
 =?us-ascii?Q?Hxd2A6jwBjdP3WcxRadCBj5AbIv4Wmz1NQNtHKx/PftOVXDmsH4Ig/77gETP?=
 =?us-ascii?Q?j/hf3Px0yucG912BoqlNANB0NhZwWOHvjJyPKK5R7JYI83CYDPexNOcWdAxX?=
 =?us-ascii?Q?gr1P54ofkztcblvmC7gXssNeSFKScKxBVPO4Kb3MQORUw/0IdgQtGh30ptlX?=
 =?us-ascii?Q?9MQcPm26JFF51t04uQzhTXUBdDfsiCMPmbphvc5PPfXCyzENsmO5YPe1ybbq?=
 =?us-ascii?Q?KFLsdUZrWpiUi3DmVVoC3X5e/j6xv1qQes8v/hkpqV5/W8i9Payo1/30AbSN?=
 =?us-ascii?Q?2+mVAuOzaPT9wQXONghBpHPTwOPoHJgXeaMCTPHc2iRGHYX0Mo8Kg6mHrkN+?=
 =?us-ascii?Q?l8ijX9DvmPKfHc2nErrb/vPAmKxER0JlLHYrFOiFFh+r46YkOCp/E/i/3XE6?=
 =?us-ascii?Q?OKXVhL5arGa4oRdJn17CV/0uJ6CoMCJ212Reucl14hrc/jorz7CTNCmxXR59?=
 =?us-ascii?Q?Nb7bhtsSNa2g1JKlrzTfY4GhYlPhIx8O3xGvgxnAoBQ2yMUe3BH2bNPrxCIA?=
 =?us-ascii?Q?+GR5MCBFoQOgv0ZqwQotZL6ex7PH3wUEXlfpShDU9bZCjEVMTSLD4TgM/nyY?=
 =?us-ascii?Q?/NGzUL6elBxxnoGeXr2jfKx0rRKq+HBnpjfCFUvMh/1YZq4vPr6xZ8G1mtlW?=
 =?us-ascii?Q?OTQzvycr/1pks2yfrpBRy4wkQMfmAJrfb1vo12GE7dPkXT0kQUC81pBkgeVs?=
 =?us-ascii?Q?hFk135iXfD+iFKKnLqo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29143986-c965-475e-f3e2-08dc73a25e48
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 23:13:58.3428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e6N/CKY6rpbSyzeWK26voWvV4McB+pgg5VA9dttmEpLTTTWVhoQUnl0kymTp69zp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053
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
From: Ma, Jun <Jun.Ma2@amd.com>
Sent: Monday, May 13, 2024 4:56 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Koenig, Christia=
n <Christian.Koenig@amd.com>; Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: Fix null pointer dereference to aca_handle

Check handle pointer before using it

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index 28febf33fb1b..e969a7d77b4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -279,7 +279,7 @@ static struct aca_bank_error *get_bank_error(struct aca=
_error *aerr, struct aca_  int aca_error_cache_log_bank_error(struct aca_ha=
ndle *handle, struct aca_bank_info *info,
                                   enum aca_error_type type, u64 count)  {
-       struct aca_error_cache *error_cache =3D &handle->error_cache;
+       struct aca_error_cache *error_cache;
        struct aca_bank_error *bank_error;
        struct aca_error *aerr;

@@ -289,6 +289,10 @@ int aca_error_cache_log_bank_error(struct aca_handle *=
handle, struct aca_bank_in
        if (!count)
                return 0;

+       error_cache =3D &handle->error_cache;
[Kevin]:
The above code is always return non-0 value, right?

Best Regards,
Kevin
+       if (!error_cache)
+               return -EINVAL;
+
        aerr =3D &error_cache->errors[type];
        bank_error =3D get_bank_error(aerr, info);
        if (!bank_error)
--
2.34.1

