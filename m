Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A60ECD6E7C
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 18:27:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0659E10E737;
	Fri,  5 Jun 2026 18:27:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U2aa25YQ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63BEC10E737
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 18:27:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTv9zDSKUnad9sbFj7D0pdVa1qu0SwjRnrpIl+ug1JSdMU2PhM2higH1yBxlxe9fXaIVlp/tXDX2MF5rXx7cfWpNfA08Arg9G7UuwnpFC8Qa0+9ePimXDxr1zX9/5zoZtBrrTLEqWejAQYM2jq6dCNo4xqVr5c3CWmQBh7KfED2vKWhK2Gc7R/qQG44VVR9FtDnlbHkz7v8Z5TVfaz6/vueOcsx0gyjARKllbSUbdszeagTj3kZP2I8L6Aov8x5Uf0a3P1hZ0YbuTXmTklX5bGOQh61oQMYZyJnaaif9b1rYC0VAs0ZESHklJfiFI/H3njm/6tnszCHHG3CQhO4GoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuHLxxL3Oxka278+kDLnu7e+IOLtkO7su1UiXEiaAlo=;
 b=WziJN0N2NQeiaJWQuK9+4YQZ4lbBZm9IvyY8K6NfYm3e3ngFtGWLC55S5QArHwqguaM8cTsVNs1ZFqtmsqdQnp54YM1sb3GoLPo93pm+kCUj+cHpzclJ4sf6SAoKz3D7/ZW4cDlhePdXdC4i+CK4TKjO8DEYM2UGYq3b20cTdzXuWUXBWhqAiHLBnaTiGS8maB3p7cQ14RNKeidciXCWc9UsRNEBiOGA11nESrsmTHRgClI9vU2yyGJe/FEbwaD9TRmF0/m19fxOzDU2O0JOVSUVtRSPz7K/s5AnAqpVty1d36o2wQNwGzPDrlaVqm+8QLgMaMOv4kZnHYUqZP4ecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuHLxxL3Oxka278+kDLnu7e+IOLtkO7su1UiXEiaAlo=;
 b=U2aa25YQSx2Punzw22xbBL1L5si20+r1JBwL6HFV6M4jdAD6MO9iBcHKef/rYMl1sz1iqVR8thjXsLUIEsBxsOjeUDLw2Z0h+djwd5ztbUbaon1rdUkY+ygutlLftoY+Ssd2eKDo4lT8rESf0GoMFIuFwi2x6txfXbtzPh/rshk=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:27:02 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%7]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:27:02 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] drm/amdkfd: Extend MQDs in HBM to gfx944
Thread-Topic: [PATCH 3/3] drm/amdkfd: Extend MQDs in HBM to gfx944
Thread-Index: AQHc81zRvJgiFpDDz0uSzgCUPRUWbLYwSdca
Date: Fri, 5 Jun 2026 18:27:02 +0000
Message-ID: <SA1PR12MB8144F241B1580D58EDAEF36DEF112@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260603132740.180346-1-kent.russell@amd.com>
 <20260603132740.180346-3-kent.russell@amd.com>
In-Reply-To: <20260603132740.180346-3-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-05T18:27:01.795Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|BL1PR12MB5755:EE_
x-ms-office365-filtering-correlation-id: c5f2139d-e4c6-42e9-1f76-08dec33009f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: 8hMWtYbn6wi9d1z7QAwYK2HJPyiKF6dtPyXHOjSxhQ5iukECrGHaQMxuT6rouoVtcrteIj7f4Ogp61MFUShORa1X9eADbD63s8xayZW/cjFvFnzG03DqyXe8iZACKbSVgQXHJz8QpY30wBa8JHgKANS8A0a9Kv1OgJ92UUjkU3QKYHa8VizT52FuoYoJr62BeEqAh4728XNrjGO3Ml4hagVvYY3Gemlxx3nCfgguAezaRqlzr4w0qAg4ks2byYecV6xTDbtzDhLKIXFSKGAO7cJyyPYE5zPzAwE9P5eIewui34ELBn++uX/Rgl7N9S+nJZYKxQfSjuQkpQPMmSzbWecJoYdhZNu5RRpj0bDImW+uc/7s06PvP/np/TMJxarsMxkt1SRY799Mn1AVqooSHRYudwkG9d84+caUsYEFzHr0le/vfYVkCl8pODXMvvni5AFrre8TRr8KmeOrTvvsug5ibtN1jHgfO/oMaJMw+XfdBdSTFhoGEJNng8mtEXClM2JK3v9XiOOYaHsQTQO1Ebs9YGP3lXq10MFxDDf1SsQyEnc6U2Ra+YvXJhBjCFgNN7HIfsHIeYrjmV72P4w2Lp2d8RXCvIaR6RvTLWTYuHU9ZuFtvbLC+NMjPcYk91SK6cXbxBcJQTI+f89XwHlpPZNTZEqL9J5whY31KHtdaX0EBBl5Kj8wUsdbVw8fYneGLOar5d22oiFDmuqQ8Yqi+cZCxEiSpoGVplQkXGZvy1lRsL2AUp6lX8D1HZOxgCcJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eCNLqdkqgyj385zGSUN0bGgNsqkWa+kHpaNS6l7Fkz4pEkDTb8Lvh7YbJbrL?=
 =?us-ascii?Q?TZ6oacwDNRwzZBXTY+w9ShnKB9hTLnFKYmsOiwbcR+4coAtPR4I73oEp1OUl?=
 =?us-ascii?Q?oPChqq+Cw0SrvmIsr/MkgB/OzrpAt1GJFUJ9bZg4AjqAr4lWDguI38rM97T3?=
 =?us-ascii?Q?ffOmtkp1uBYcACKPsQCLH46XHgKuvO88vwCrFreb5jU1eJxYX58usv4MDvet?=
 =?us-ascii?Q?uBz+70hwGVb7qVqw5AddGbhBB8anUheNyX5WET7TZcgosr4jmJ7ruHytkdwc?=
 =?us-ascii?Q?itOiWIb93iyyQ0tP9747/Dz1OI0gvFI8y9H3OjzCg5vVuAD+pfOuSHecPC94?=
 =?us-ascii?Q?Av3qowaz6vhMHyNsdN1Tf5wmU4NMXrjhCOaVosmP4xy4Did4LnXAItLwcX1V?=
 =?us-ascii?Q?uX2PHYK73i2BvLm26/3Jsd3qh6qdNxC7uMkJz+nccNCOJsYMyl30gkAqqdsW?=
 =?us-ascii?Q?KG2bn1gyJouYdlUf4rIu9jn3oGv6sDQEeA/q37HOx6jmBfDW9jY2jv6/Chlr?=
 =?us-ascii?Q?UAmtiI7V3mMT/iuEIJQx8BkrXfzzoGFZVBqqQn4GhSDxAm+21n9suUVBX5/n?=
 =?us-ascii?Q?NJDmxKaw2vrrKY8I6wC8wfxok8TldX7W+7k+FrO4oYFEX9QrPoQWDK9x8wnN?=
 =?us-ascii?Q?e2SfNp95edMo48KG5lXA0asqsD8XrPjPqTbNrkYIgq9sbIMxNfT8lZ3O0UcU?=
 =?us-ascii?Q?TBgYp4hPbw5xTreJSr2zflvBBTW0DU8snBHxOFpBEsl11zdg4EU6jRgJwxR0?=
 =?us-ascii?Q?JrxqWIljTlxFguE0yMxylOG2USXISjNy8a6b+GnCYfzMB8+/0KZEzYRkEFQr?=
 =?us-ascii?Q?EavvCms/ve5tGMYIFp23FIIrVtMTrPENuHxynjyiVtCsT03cDNL9y1gazrAI?=
 =?us-ascii?Q?9+7jQqAQj1UoDIGmcL6tlnxtD+6VGjOtlhrM0U2jNRmzh4aSfJVPjQVczU72?=
 =?us-ascii?Q?xPAyinq00m3wrJEccMifNF65PnLEiBBm1cjGpk7uvN4B7Tpip3EA/7kSTFkU?=
 =?us-ascii?Q?3dn7+sbGVp8wZXwLb84zJ3A4Szz1mFeIzIqJN2Mi9qI269CU0JQ8NIRk8/uO?=
 =?us-ascii?Q?NLk/5+hNBcUrp6cscIh5iTYgx16LBTay9qic5sfPW3zI+gnS7BqlOhNwfYaE?=
 =?us-ascii?Q?NppXS9JyaM77am80L+oFLkra7lMM4p4FiF9gex1Mygd7hQZu58qr683CflAG?=
 =?us-ascii?Q?eNnVyVdCoNXoo0MgyXoxKo7o4rWXW+B9ja9hiwIqwhTwyUIS6+Tc0VVc36oq?=
 =?us-ascii?Q?l7w8fZ+D6t9+mhhKVOT+jm6MFW0QJoyxEXGFPRcN76FATn6dtkAxGGbcz1GZ?=
 =?us-ascii?Q?Ez2AyQDmIqKvEaLp9Gcqxe0G4Hr1a74fsRUkpg8ISUnM3f9EcWkHLh98eRKE?=
 =?us-ascii?Q?IqeySmTVi0ozC/FYg/EgttC7gUkGGBI2Lq1ipRUccd+R0P3TmeBNiAuK7+7I?=
 =?us-ascii?Q?bsEUQlYisfGkDzkMJCqa7GnILIkBEWzUMfg3Bux/QpxZDwowyMTi1OqdtNJi?=
 =?us-ascii?Q?u1bD/xRIY0mrLOhNrkIbKgcR1aAoG6rOZoq6nhnCAdHDenfur67Hq5BGtoRB?=
 =?us-ascii?Q?3U+RouxPlN4DgaqV6sM/Sr6yIvbMipHdf30ndOsVX08l3KrrhzqAVwRwPOXh?=
 =?us-ascii?Q?QNd/C0bQbKOsq41EHePeQhtYjbH89QbFCJnIZIrEnByKUiclxRGXal+joSGT?=
 =?us-ascii?Q?jxMgWwUyyosle/oXLooH2gr70O/P2yzhhLLiFjoYYD9ARx4Y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f2139d-e4c6-42e9-1f76-08dec33009f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 18:27:02.5206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZcpL0QjgxuNi5r+kKjaA+PwWTQo1UFLJYEFylCN7IP1ggatzGrVtmpQ/n2BgR+H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755
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

Looks simple enough

Reviewed-by: David Francis <David.Francis@amd.com>

________________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kent Rus=
sell <kent.russell@amd.com>
Sent: Wednesday, June 3, 2026 9:27 AM
To: amd-gfx@lists.freedesktop.org
Cc: Russell, Kent
Subject: [PATCH 3/3] drm/amdkfd: Extend MQDs in HBM to gfx944

This has proven stable and performant on gfx943 and gfx950, so extend
it to gfx944 as well

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_mqd_manager.c
index 5970a1694286..b0f83f63e010 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -324,6 +324,7 @@ bool mqd_on_vram(struct amdgpu_device *adev)
        switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
        case IP_VERSION(9, 4, 2):
        case IP_VERSION(9, 4, 3):
+       case IP_VERSION(9, 4, 4):
        case IP_VERSION(9, 5, 0):
                return true;
        default:
--
2.43.0

