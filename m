Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B16EC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Oct 2022 06:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6913510EA79;
	Fri, 14 Oct 2022 06:08:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD6C10EA79
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 06:08:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KU7nt5Y69XrCDOO8Ignfavu59ps1l1sTnEluEUAKUNMv6JTtZ5OSKoO4JwCeAVfKkCuIEiIaP3t5JioRse3GTZgTyx5XqyUEsnD26Il/jVsDou8EELz4mCVDgGoOnvw0reRibDliZsyez81w6IUOHrDveQhRv7jUBsXAX3DLMIQNkI/9dePKb0senm38nMNZ1jLyP7M0riDD9QFIREJcD1UU5eH8A9ziXiehlQg0jABjnC+ZigAWbLtfibipdrCnJ9Rz89thCytEOB6enw7lxxTd402rEw/nwIXtDG4bgayQh2/7SSVJmrdP0NFdGaWQFNisGeRD87/2w1M14Nv6+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWv6i4joKM5im74cihPW4Us/yOGDthXTX5zJfXyioKQ=;
 b=TCHApOLwL7Guai+KPxxgXePEH5RiWobCGEmRFA4XmvyrnGaMQ8T7TjRzO042ovIQysNONuPsaWIaXYhdyiK7eT3x2EhJ4Ez7lKMGgz3XDPIkaN7HLO9fuQbBlQ4tZs2rw6GJKo99TOkN+vvyzeSVjvDa8ShE7q6gz3k78E+xLRIjzbndBMSRcSS3Uhp2TZIDgn9F6TqH1ey8otjlW+/4tEh5vS7F0LKVoPOOmP2I10omcEpcIRcCcpOaWFAHz4XF+aogsR2ApG7yogGw2873rJb9B7RinKsaOWEHG1+m093GwdG/VMz7+D7F7qUT+fY6rU2fFckF6/akluKg7g59fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWv6i4joKM5im74cihPW4Us/yOGDthXTX5zJfXyioKQ=;
 b=5svgzOo/aoulCnRkcjIVsTAjrzmnYDEDLQF1ChUOlgqbyJ3zLN05+XeXrwR07Azb+eUoCvjAmS2oaUpCfcRiAGhRS7GMPBPMr1uTSbLboLgKXfqks2eXQPh92Md4y131UdYl45THZSp+303M4UWDGxhsnRCngcCPN5tDKUJlpw4=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by MW3PR12MB4521.namprd12.prod.outlook.com (2603:10b6:303:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 14 Oct
 2022 06:08:23 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::c986:1d1:2237:adb9]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::c986:1d1:2237:adb9%5]) with mapi id 15.20.5709.022; Fri, 14 Oct 2022
 06:08:23 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/8] drm/amdgpu: Enable gmc soft reset on gmc_v11_0_3
Thread-Topic: [PATCH 6/8] drm/amdgpu: Enable gmc soft reset on gmc_v11_0_3
Thread-Index: AQHY35Ho0tANn7y4rUm1+E8TDUAhhq4NZnNw
Date: Fri, 14 Oct 2022 06:08:23 +0000
Message-ID: <DM4PR12MB51812766DCA939D82157584BEF249@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20221014055743.921806-1-Likun.Gao@amd.com>
In-Reply-To: <20221014055743.921806-1-Likun.Gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-14T06:08:21Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=56b5c7dd-ea87-4378-a574-8ff1f874041e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-14T06:08:21Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 00913f4a-918b-4d40-a218-8d42736c8102
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|MW3PR12MB4521:EE_
x-ms-office365-filtering-correlation-id: 269cf7e0-d24b-43c3-8dee-08daadaa8044
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZiufKLY9leGRWtmtDSzMuZsQirfUa1d1i4OElLx9jmkpOakqHQ/nvSnhDes+C8IPmLrAxZgSmLdFNDXSLSNkpGS0lforTLSSDc2A+uzgF+AP301uImX9xRMkHI54aj0KRFxnrYiMqdgQghtJEXQBlyZhbx/cDNllfBgPAcVBc4DgFvmBNwptTMpL6Et1/ZWIkiOqtusmwe9S871z8qJqCuLAlKW/S6lM4ohtEwyXR6PGrWMeTN3GQWY9fziYM8pdV8ZzNHmaXKSL2v8fDqZYdRRRrLxifGcHxqh/O1ULQF1QDmWktNxJ//EfWn5qJmiiXBgOLgKMXy5r0KGr7b9p5fUeDo1bgKVyisWuwUc/PwBWYiZq0OfC1ExJ1z7K22ghWyNSSwtBvoWIRapNUCi4wHk2Kvf7sLOP+lMvwbJCSAK9V5/ks0vPmtMT5Y6d+y2AQ8o4yqTMfugBvVrLIwa92NrfYl+0XhFA3UZR3ysLw7dy0ZvQ1SZnHpiFA8dzf+qE6PBquxBXs8rzfHzbD73jyklw+Bu/DjF82KTDsDonXpC85QGgfhAfpBbom9WSn7Utqch5awKZHuUdpFeYSocy4azc/GcGa8om74/OKzRPMQMBuwL+FC6wohhuXv3Md0z2CNH+itLf0I7uOIhUHfcGwXOo3B478AQgxc2SK9hqids++7nFY39mH/q1ibL1IxdtwlqNaAXtAIz/+tZ0HNWmlGZHZIgmFZIZG7o5eEh2isj1lEKdwk7rT/H2gkXn2guU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199015)(186003)(66476007)(9686003)(83380400001)(38100700002)(122000001)(8676002)(4744005)(38070700005)(64756008)(2906002)(8936002)(55016003)(76116006)(316002)(52536014)(478600001)(66446008)(6506007)(41300700001)(26005)(66556008)(71200400001)(7696005)(5660300002)(66946007)(6916009)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DePfDfdzldslYzIN98UbmDULlXSh3S2nfZqRUupAGvAYMGtAB9Kp4Az2ph1x?=
 =?us-ascii?Q?9zoPtYbYWC8KEnGTI3n56ZK1zx6UDqgH0ijfDCZN9EbyvKM9Ce0YVfytn2Gn?=
 =?us-ascii?Q?M2BBglKOeJ3izpyRZNU9M6KewG7lCyINOME6QFs69AOCJimZ/y69MMuvTpQS?=
 =?us-ascii?Q?Du0Q6qORtmPjHu+hNxaTVUinP4srF8ga3FRlPeobGzpioAukhKNdtdSonkZ4?=
 =?us-ascii?Q?Ax+3xG+aZnZmBzHqui624feWZoOojt1tuAXzv/HkmR86xAvQlY5cDuA0U922?=
 =?us-ascii?Q?X6RCf6kxGC+4aeq2WRE1HxMVefGfkt9Pdxt9BTAepd8cKv5qZgHeF0PVsQ1F?=
 =?us-ascii?Q?9S3BCbnxedamQEU7BMg9scQzigdKrJGPBgoLmrv5LwRtkVZ5fOYZV2/sYLqk?=
 =?us-ascii?Q?f0y/3KGbpRGzTK6rYA8tMbmCj49X+j1KfU8uU62FnMnPdxeoBszmU0HNzG/z?=
 =?us-ascii?Q?ApK759OG58D5m3sp3AcFY59LtxSKd6tNI+eH5nPMZXpeAh2Zwt9wUKHyyO5C?=
 =?us-ascii?Q?nZb6QdzYyBs3527Q1ltkul3ut0d1fwninoM6gg6JTSc5deWNfwguGJ0pki0S?=
 =?us-ascii?Q?tZh1Zt8dA2wkserUk31tNyGE/zWfR+qDk6Tlur3mwYvcaDPEA9RX+OUMgrss?=
 =?us-ascii?Q?lSv9b35NztoMWn5q/1CX41WX5qpaE+xPXZkZpV2SVYZFOdLA0Vb95M7m/ltY?=
 =?us-ascii?Q?eN7lPMj0+16H+lrnCkurQgpyMixk5WvqlDjGT3G3/jsZ/dru11wr3ey4uheG?=
 =?us-ascii?Q?BFGhRM7bOwGe+p4w44r3feLasB45/CjnkW67gC2C3KKwEXsF6ikJszdF4ZjP?=
 =?us-ascii?Q?GW0jDH2W+WQHtwJ4memT70qx/LUgW5QoKUKAQIKDnlO7KzSx1FuP6kaHLxVI?=
 =?us-ascii?Q?mvBV0459j0g3aMxUXeD4Okgb2pxMC1nd9iwADAHDp+lSRvqhyfuVFkIkS1N2?=
 =?us-ascii?Q?jjQ4lliuTHI8RSH1nWGRHoOycNYYRV9idKR4dfOAMKQJP3zbOGSahqPxuZpT?=
 =?us-ascii?Q?GI+t+whLbDM8v60aAT5D7JvOgahJJkK1OFl7uyqJGRuVpmSxy+8P+CPZagw9?=
 =?us-ascii?Q?whBK1TW231jWW+p3sGAwVkEn5BrgFMMugAceawMCCxDPMzznW2dIRE2hnuBL?=
 =?us-ascii?Q?zs1WMBVNYmcIaOM4r7uzwtVzp3bRB+yR0Q6WU94R1vh9LgjIBWo0O4vtIYQv?=
 =?us-ascii?Q?2mj8aCPCAijDOsMltQVTpSiLw8u4bo9NHQm/io6Xk8z/x8myAxGlxBN0Mevd?=
 =?us-ascii?Q?GZsCP26yuITtTf84ZkcYrTLqGRWJhoTym8voIlDt4jUSo38Bw2IozjsXl06R?=
 =?us-ascii?Q?OjScqi5Kek6g7UkTdmV331kn2vLlRqz4bxwgsRfPeh2XlnCv+ksrkTxkHUph?=
 =?us-ascii?Q?v0e2+P8O6K7dL+VV3JrQvvUTcpIl6DE2xZx9WphFlT23IZhsdhzFCH6/Nlxe?=
 =?us-ascii?Q?7y0c2LD6M5yRca5dNL5S9hbnq6Q/lA6hX82ZR5s24Gk6OqXOXlD/lJZTJ30z?=
 =?us-ascii?Q?jOSgqHMiEjnn0+XpGI0TkZ8WnwKRt7BOgrm45VjOBiobAJVY1udJ6RvFr03X?=
 =?us-ascii?Q?/ehnrXbkKQGUNfdn9Ao=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 269cf7e0-d24b-43c3-8dee-08daadaa8044
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 06:08:23.4212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /DKATE5BscHAK8nbHvIySOFzOQciGf5IwF4KA6LBxp6giMDeCg+8ixlWARqEZsI9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4521
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

[AMD Official Use Only - General]

Enable gmc soft reset on gmc_v11_0_3.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index 8e4ad723d7ca..cdd7e4706e0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -423,6 +423,7 @@ static bool soc21_need_full_reset(struct amdgpu_device =
*adev)
 	case IP_VERSION(11, 0, 0):
 		return amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC);
 	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
 		return false;
 	default:
 		return true;
--=20
2.25.1
