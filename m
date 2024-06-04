Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3E4C25B78
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 02:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00F7610E06F;
	Tue,  4 Jun 2024 02:32:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dDYKkoDd";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B429710E06F
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 02:32:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgxyPWP8JGQpcjJx87qLh3zmBwpJxOW/Refe7/GlDTowCJtinhtcCVydjwkvDFVnvfyts5lJ1iV9/x5lFR0khEsPEgddSNcV82VkOM0SVhFd6im7c1nhiBS1ZYklw0PJY1erlGfeOko0EkttvOofOIpGPk1iMTW69sTE9lwDCXEQMPXK7BEgZViCODp9K2yyDI42qg/AfjOAOcOLtPwZGolfleniqUN23OSm40kb3pYpJEwkvfFkl6QRsVzlqyIQomDBHE4qQCDxlKaNOJWPqIIR0q7r7jgGz4JJllHRBWliszzk/pfbd08qqmBIg9MTpv61j48N51iQe/lCfG/yIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neqhP/dUQYean65b0JXdhD0u4LKZvsBRfQgyidnstos=;
 b=TPSm5GDcEuxpQTu3nE1GN7pZChFl8mNlxgw+NdFP9yuXUzFxM+4jdj2KssWs0lO5UYK0GmuSHUfqAZtQFb1H+RqK1cPJwETXPRVbpRA2s5h0elLN3mcrbVDjfkD0HKzyNgk853GQiUwqZxf2biO6KxC7vYPTyjMoeXuzyTH4vUO9s9HICxS06eLeM/5sZGc5yO0epucrKso9RaZKgBK3iwGfQQ6zqFsGCi2+1aRVjJA5QRUt/IKiq3joS6/gBmVnpHje5vCvAGdgqCCvI42ZOJcXATpVkmnphEXC1ShOfbUwxPuAvuE8mci+4V0KvViujcUIChQjOHZrhfuk1/I43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neqhP/dUQYean65b0JXdhD0u4LKZvsBRfQgyidnstos=;
 b=dDYKkoDdiTBwHhMoKWRPDlDJNbx1F9R94fEHP+ax+rxnfQzMYBq8Y6f7qkZuLrEbFDluXWe2JDO27EDmUSsIXFvahWjrx+oNPLQvTJtv6oEz2apysyKM+aL++2OxgxP3gJY93ToNdhEwtH3o+YbHeiaMRPOR48SQvwa35aX5nT8=
Received: from SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7)
 by SJ0PR12MB6757.namprd12.prod.outlook.com (2603:10b6:a03:449::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Tue, 4 Jun
 2024 02:32:43 +0000
Received: from SA1PR12MB5659.namprd12.prod.outlook.com
 ([fe80::e783:dfa3:88e4:d166]) by SA1PR12MB5659.namprd12.prod.outlook.com
 ([fe80::e783:dfa3:88e4:d166%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 02:32:43 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: Update soc24_enum.h and soc21_enum.h
Thread-Topic: [PATCH] drm/amdgpu: Update soc24_enum.h and soc21_enum.h
Thread-Index: AQHatcbKDTrroCNRcUG+YqBl1NDeTLG2I5cAgAC/mFA=
Date: Tue, 4 Jun 2024 02:32:43 +0000
Message-ID: <SA1PR12MB5659A31C03BDE0DA8C2C2431E9F82@SA1PR12MB5659.namprd12.prod.outlook.com>
References: <20240527054145.4576-1-Frank.Min@amd.com>
 <SA1PR12MB56593AA7772C724E43243AD6E9F02@SA1PR12MB5659.namprd12.prod.outlook.com>
 <BL1PR12MB514448F264DF93B553AD145FF7F12@BL1PR12MB5144.namprd12.prod.outlook.com>
 <SA1PR12MB5659E2A8BAE5CD601A8A8243E9F22@SA1PR12MB5659.namprd12.prod.outlook.com>
 <BL1PR12MB5144B83247F4C501FF27B879F7F22@BL1PR12MB5144.namprd12.prod.outlook.com>
 <SA1PR12MB5659B5B900B1A0824BB422E3E9FF2@SA1PR12MB5659.namprd12.prod.outlook.com>
 <BL1PR12MB5144D5EB83A7293D61381318F7FF2@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144D5EB83A7293D61381318F7FF2@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-03T15:06:11.560Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB5659:EE_|SJ0PR12MB6757:EE_
x-ms-office365-filtering-correlation-id: b3786396-31c4-467f-4f7b-08dc843e9d02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?jtR+nN3IqK7G4+leAtichmYWYHNyb79AdnvQ9SbOFXy85p1ot+B5pNCmbJmC?=
 =?us-ascii?Q?X5uWmGe4TURFF+PZWtHiPTKJIb0E1RLPg+IIiez+9CEsPUFKNu5ndB+3c0vU?=
 =?us-ascii?Q?TcPJgL8m1oMJqkPVPCAkxqTibeDUf1RYHc7ImH4A0iNiYS2iYsWOZQflfZpK?=
 =?us-ascii?Q?8HoAKvcz97DsTANLAmNUg/Hs+GNymxfduPXwkPlx36nb6fywzDfFYUK8XmTa?=
 =?us-ascii?Q?N6cj9ndNIefxofulUvtQd6/a2MmB0JiIOiyt0LC5ZAzj4r6/7Mx9X3IgVi5V?=
 =?us-ascii?Q?5u9nC/xDUqnoeGb+H+SIOHGC1NKKIv9lRmesaUUlID7nHoDOEews2ovjWC6W?=
 =?us-ascii?Q?+RdpHiPJMDDJZwdb8pPPOb9m/HQtc8jEDLoW1hI+aApWdcpVkDxvd9Dmsadc?=
 =?us-ascii?Q?WfUwF+Hgn2FRTgqnr0cxHZWcjb8T+hUk/3WZBZ0Yo5FqYtYfYAKZt9j9Nn57?=
 =?us-ascii?Q?jjSfhawAAfGgdr+8BLjLIpbBYb8Wld+QuNYqv4YH8+wZnNR03d83F/ZwUg8L?=
 =?us-ascii?Q?0CFlclN69QdpLiC1T3itYI0g24c4sn3v9RVD0UuAD8Zs5pv+0L4DKqML/VVS?=
 =?us-ascii?Q?MqViCDaVULNWWJGWDRY7xtKX5JTGi5H1XrVrzpuGc1IQQeiDNVVXl+opX9Gc?=
 =?us-ascii?Q?xgUWsBNp5wO2883Bj+uIhHpPS+rW6+JFNPNqGQcQKd4fi6zDhzIZU5KDrkoZ?=
 =?us-ascii?Q?nXYpUqZSRNziNpj2ZK27MsnsAB3cvja9PtoX7nq0r8oFpUsJRSfGobuwoRh6?=
 =?us-ascii?Q?fDNPd85ZFsfi/5YGnURo7G3zwbyuKkfR7ec2TriHvMAKmMWZXb4bqJvuIHxA?=
 =?us-ascii?Q?CpqNwU4Y/YQ5gO4y4iKaxXXjHvTaJND2EML3n7eKCXiMk6GGg4sKE3TFp3CD?=
 =?us-ascii?Q?JOY1tcv4fImRqgn0QLSBuRJzz1Pq2HzU3Atrxz1RqruWKdqKm0Uttqk1PRLo?=
 =?us-ascii?Q?0fPFBc2Cs6ozhEiTxSj1BrOzJiNQmLCy9A/yCpPMDkz9uxSmlxlnsFdDmguh?=
 =?us-ascii?Q?URR1tgAF00rzI/5OX4tAXdIM7liXtx+orlKGGtUtbyQm7xAkcPNOrIgxvY9u?=
 =?us-ascii?Q?raPbfYER0+Lot6oh4ZMiIOlVyo4k7z3L2xmlwYTkgqyZqypuhjZpZRDQH6bo?=
 =?us-ascii?Q?A8wBVk/EaKZrwk6DIDu6xxGDB0I7kTElDXnWwapnlY6BkMqMJ3qlRess/bpQ?=
 =?us-ascii?Q?HZnSajpSdUmRqC754WyAQNJIFaXFjmFPouIwuJ4iJF1DcJpFGsXRi2S6oqcr?=
 =?us-ascii?Q?/0OCyxQpvynasrWoIXSjYrKM/4E6icCUddtyooheRfoBaog69cqqtxLx6jKP?=
 =?us-ascii?Q?ar1utz6IZOQ7REttjV43g7PAH3bkVxHlcImuT85YnY16Cw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+u7wXaDuuZEhJmFZgkCNqAvuhOCm6J6ErDHSzRsEzJOqzqbnJzKIFodbmQtM?=
 =?us-ascii?Q?4NDFVyPRGvTMcJaIkeVqkxzWFI1cRJ7Knn34Ibi9Iu8dI+xnIwwKwJ8RJa4v?=
 =?us-ascii?Q?RVC9rD6XZeenkh65FpG4XTwtYx+k3Q+JeKwqj9MM3iCGDJO9si1TSlB6Bxte?=
 =?us-ascii?Q?A+LvX+G9pxwXTOWzSrHS+ed+YWMFUzVO1BT4wGP6/fwoaT0tNZUpmn5491Rj?=
 =?us-ascii?Q?zYvUdygBkpSuT8DpX7J8MKIa0x0pDZ1a9nAEPOQ3ptKb8Xuvg0uHEa1aBpzp?=
 =?us-ascii?Q?mBoGRTz62BUfJdKc/hXdQO2aEYHb7ZQVjrLqCu3Ybcb2XLijuQ/OJdTNmx5G?=
 =?us-ascii?Q?z/rkBZQxpQLgmEY71wQ6S2qczLykfWnb1EFIiafyt6qfG7ebWiinRNaAW2xr?=
 =?us-ascii?Q?qiEAmiCXd86i4PtJHnywKCfi7ApsUiu4D0St52YlP361PK7mdstLqKJu1qBo?=
 =?us-ascii?Q?VCdlP/q2+Ev8uFVMP0lFau7Kl06XHmkfnsxht1upw2EuWoYzNx0uBgPX+s6i?=
 =?us-ascii?Q?wb2fA5FTSQ9ORiMa7yomFuwhOCRuuwfvc7OlZME0dt3qTTyBhRUQ0ZbN6iIt?=
 =?us-ascii?Q?bRGnspNwr849qKpv7KziiN6pCQPJd4tSp1elnnE40bvv4YFAkMi55AZwI5Ga?=
 =?us-ascii?Q?ToH4Ij+2pJqAngcLLQPV/tMFSgUzSBt97mPiBRMEWVSahI9lWiwMlziEhcne?=
 =?us-ascii?Q?hCpLeQ+bV785Z0vAO7E0cjMZnEsZjlt10ijS9GC+JI7gzbwh6TwcB+6GMNzF?=
 =?us-ascii?Q?DjIs72rNoL+mmbuubRef3Nmi3FVM7v1dfdom0HdQQTl7MorcE1m1HlpODJ7n?=
 =?us-ascii?Q?xR9XVgpjtR02Jibr15gsbeyK6bTG/Drol9T9r0pgvKPcQMU+emVMl08slLdM?=
 =?us-ascii?Q?zOVC90GTJ6KmVLe21YnO6vVruzUUNPheGBjtkvqdH6VRv8V+AdqXLYt7Idy6?=
 =?us-ascii?Q?ucnJCExVjjHNZi7YBCKKGK0hug96hhAfEW6dpekmoh18j7md/UwI6t5lfNGi?=
 =?us-ascii?Q?D93BxIwM1QREHxGx+TSwX4JneGXKZnia/EHl7bDgkmg+MODj/mGgZZWMcBWA?=
 =?us-ascii?Q?EYIyFREOwGyUVYCMNBHJDKULsVNXssVp/pKOxx7FuCLiBURjkP+aXUJg8qUd?=
 =?us-ascii?Q?aVgTswkeyJwQZGCQfHnH7pczP1xGlgX0ag9HnOORhVuX7f6FKwlCW/K3P1K7?=
 =?us-ascii?Q?CQvk5YsdKe7Yy0ixtuUWZBuwmeTo5oh7faqWUvO6tmDm1l6jmrJWpBXMGYML?=
 =?us-ascii?Q?J0tXejbKqAUXnVVn1KEdtr+kp5B6rBO+IXAD/ax81wYFrXSYgP0V0ni4DBu3?=
 =?us-ascii?Q?7z0ExsCaYI5c6ZiQeLdVvhjCiyuzznKYtX0KzUKvVU1RNCqhwbKbBvc+PYPr?=
 =?us-ascii?Q?Zd0s7/efewTj33KSjgxRHWFJHlyRFjt9W+7wxu8BdsI8JsDFwy+Kt9woyXtU?=
 =?us-ascii?Q?X2IERbvCdUbfGuWFxv9KWJcprFDOyNRxsChTIo3BKBMTtXhpoMALiChe9KwK?=
 =?us-ascii?Q?SkZYptyWzvh4WKYSGVqXOzrS4dFB5bKSgFcbb63PVvw++RDCYe/FB8Zj7/As?=
 =?us-ascii?Q?bXf6V3uiQly8bMfQeJE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB5659A31C03BDE0DA8C2C2431E9F82SA1PR12MB5659namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3786396-31c4-467f-4f7b-08dc843e9d02
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 02:32:43.6338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OeRYEXMmh7ChjR20Yo/dPflm77uK2Lo7ZmINArUuMgTKxc3F9Bq4imikrGP7Q68r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6757
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

--_000_SA1PR12MB5659A31C03BDE0DA8C2C2431E9F82SA1PR12MB5659namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]


From: Frank Min <Frank.Min@amd.com<mailto:Frank.Min@amd.com>>



Update to latest changes.



Signed-off-by: Frank Min <Frank.Min@amd.com<mailto:Frank.Min@amd.com>>

---

drivers/gpu/drm/amd/include/soc21_enum.h | 2 +-  drivers/gpu/drm/amd/includ=
e/soc24_enum.h | 2 +-

2 files changed, 2 insertions(+), 2 deletions(-)



diff --git a/drivers/gpu/drm/amd/include/soc21_enum.h b/drivers/gpu/drm/amd=
/include/soc21_enum.h

index 951ec2900c61..07d98bff7f73 100644

--- a/drivers/gpu/drm/amd/include/soc21_enum.h

+++ b/drivers/gpu/drm/amd/include/soc21_enum.h

@@ -92,7 +92,7 @@ DSM_SINGLE_WRITE_EN                      =3D 0x00000001,

  */

 typedef enum ENUM_NUM_SIMD_PER_CU {

-NUM_SIMD_PER_CU                          =3D 0x00000004,

+NUM_SIMD_PER_CU                          =3D 0x00000002,

} ENUM_NUM_SIMD_PER_CU;

 /*

diff --git a/drivers/gpu/drm/amd/include/soc24_enum.h b/drivers/gpu/drm/amd=
/include/soc24_enum.h

index c47b8cc2f203..3eb7662bbbda 100644

--- a/drivers/gpu/drm/amd/include/soc24_enum.h

+++ b/drivers/gpu/drm/amd/include/soc24_enum.h

@@ -73,7 +73,7 @@ CP_PERFMON_STATE_COUNT_AND_DUMP_PHANTOM  =3D 0x00000005,

  */

 typedef enum ENUM_NUM_SIMD_PER_CU {

-NUM_SIMD_PER_CU                          =3D 0x00000004,

+NUM_SIMD_PER_CU                          =3D 0x00000002,

} ENUM_NUM_SIMD_PER_CU;

 /*

--

2.34.1


--_000_SA1PR12MB5659A31C03BDE0DA8C2C2431E9F82SA1PR12MB5659namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:\5B8B\4F53;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:\5FAE\8F6F\96C5\9ED1;
	panose-1:2 11 5 3 2 2 4 2 2 4;}
@font-face
	{font-family:"\@\5FAE\8F6F\96C5\9ED1";}
@font-face
	{font-family:"\@\5B8B\4F53";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:\5B8B\4F53;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.xmsoplaintext, li.xmsoplaintext, div.xmsoplaintext
	{mso-style-name:x_msoplaintext;
	margin:0cm;
	font-size:11.0pt;
	font-family:\5B8B\4F53;}
span.EmailStyle27
	{mso-style-type:personal-reply;
	font-family:"\5FAE\8F6F\96C5\9ED1",sans-serif;
	color:windowtext;
	font-weight:normal;
	font-style:normal;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"purple" style=3D"word-wrap:b=
reak-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<p class=3D"xmsoplaintext">From: Frank Min &lt;<a href=3D"mailto:Frank.Min@=
amd.com">Frank.Min@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"xmsoplaintext">&nbsp;<o:p></o:p></p>
<p class=3D"xmsoplaintext">Update to latest changes.<o:p></o:p></p>
<p class=3D"xmsoplaintext">&nbsp;<o:p></o:p></p>
<p class=3D"xmsoplaintext">Signed-off-by: Frank Min &lt;<a href=3D"mailto:F=
rank.Min@amd.com">Frank.Min@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"xmsoplaintext">---<o:p></o:p></p>
<p class=3D"xmsoplaintext">drivers/gpu/drm/amd/include/soc21_enum.h | 2 +-&=
nbsp; drivers/gpu/drm/amd/include/soc24_enum.h | 2 +-<o:p></o:p></p>
<p class=3D"xmsoplaintext">2 files changed, 2 insertions(+), 2 deletions(-)=
<o:p></o:p></p>
<p class=3D"xmsoplaintext">&nbsp;<o:p></o:p></p>
<p class=3D"xmsoplaintext">diff --git a/drivers/gpu/drm/amd/include/soc21_e=
num.h b/drivers/gpu/drm/amd/include/soc21_enum.h<o:p></o:p></p>
<p class=3D"xmsoplaintext">index 951ec2900c61..07d98bff7f73 100644<o:p></o:=
p></p>
<p class=3D"xmsoplaintext">--- a/drivers/gpu/drm/amd/include/soc21_enum.h<o=
:p></o:p></p>
<p class=3D"xmsoplaintext">+++ b/drivers/gpu/drm/amd/include/soc21_enum.h<o=
:p></o:p></p>
<p class=3D"xmsoplaintext">@@ -92,7 +92,7 @@ DSM_SINGLE_WRITE_EN&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x00000001,<o:p></o:p></p>
<p class=3D"xmsoplaintext">&nbsp; */<o:p></o:p></p>
<p class=3D"xmsoplaintext">&nbsp;typedef enum ENUM_NUM_SIMD_PER_CU {<o:p></=
o:p></p>
<p class=3D"xmsoplaintext">-NUM_SIMD_PER_CU&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x00000004,<o:p></o:p></p>
<p class=3D"xmsoplaintext">+NUM_SIMD_PER_CU&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x00000002,<o:p></o:p></p>
<p class=3D"xmsoplaintext">} ENUM_NUM_SIMD_PER_CU;<o:p></o:p></p>
<p class=3D"xmsoplaintext">&nbsp;/*<o:p></o:p></p>
<p class=3D"xmsoplaintext">diff --git a/drivers/gpu/drm/amd/include/soc24_e=
num.h b/drivers/gpu/drm/amd/include/soc24_enum.h<o:p></o:p></p>
<p class=3D"xmsoplaintext">index c47b8cc2f203..3eb7662bbbda 100644<o:p></o:=
p></p>
<p class=3D"xmsoplaintext">--- a/drivers/gpu/drm/amd/include/soc24_enum.h<o=
:p></o:p></p>
<p class=3D"xmsoplaintext">+++ b/drivers/gpu/drm/amd/include/soc24_enum.h<o=
:p></o:p></p>
<p class=3D"xmsoplaintext">@@ -73,7 +73,7 @@ CP_PERFMON_STATE_COUNT_AND_DUM=
P_PHANTOM&nbsp; =3D 0x00000005,<o:p></o:p></p>
<p class=3D"xmsoplaintext">&nbsp; */<o:p></o:p></p>
<p class=3D"xmsoplaintext">&nbsp;typedef enum ENUM_NUM_SIMD_PER_CU {<o:p></=
o:p></p>
<p class=3D"xmsoplaintext">-NUM_SIMD_PER_CU&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x00000004,<o:p></o:p></p>
<p class=3D"xmsoplaintext">+NUM_SIMD_PER_CU&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x00000002,<o:p></o:p></p>
<p class=3D"xmsoplaintext">} ENUM_NUM_SIMD_PER_CU;<o:p></o:p></p>
<p class=3D"xmsoplaintext">&nbsp;/*<o:p></o:p></p>
<p class=3D"xmsoplaintext">--<o:p></o:p></p>
<p class=3D"xmsoplaintext">2.34.1<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;&#=
24494;&#36719;&#38597;&#40657;&quot;,sans-serif"><o:p>&nbsp;</o:p></span></=
p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_SA1PR12MB5659A31C03BDE0DA8C2C2431E9F82SA1PR12MB5659namp_--
