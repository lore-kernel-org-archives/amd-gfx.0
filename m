Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932EAD5C0C0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 02:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFC4710E266;
	Tue, 16 Dec 2025 02:45:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qzOuoIkm";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010047.outbound.protection.outlook.com [52.101.56.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EF4010E266
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 02:45:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9hjpbVeWBJ2/QRgCJbUzEDOb5iCHqf/if/mzaTaoqzu5KaLi3mcAozeZU5VajyMRF4sAcFOvOZSP47omV2mIxw+CSw8LNj4NDNerMKbIsV8kX2Zzc+D8bn1jLvIeyKTvr22TsH15drVv+KToeL3j0xR0NDOylPtCw6To3FATFrA+6pOrurmA1Bo8qJRWINvGB2RGfsJxj0czaWiCPHc7RLAd9N3YyOY2698xCag656mH+xUZWGZoQWaRuv4nIUHJQ3wMOSCpvb0qjMd4p0nrBto/2Dsh6j+soqrrqDFUQTVwFkqCiLMpWFkgv8p8tm9ftelTr4oET2hB0nDKiAqUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukA/7rFDrX1rMM87KwkXwDmKC+r7UHVQDJ8VZZIBy9s=;
 b=EGs6dP3Xtb5Xft0ioA3dPSPb3+aDChpADWJfB6bBXWHqWbQTnOuSDPSx2bqmnw3nnxSbflmZsvWhrWygGIPKZQnKV0ji+C9xztr2EsO+liwbr11VAVZr06sa97i1yi94U4sgr9qEksDa99y2SbLxEauZYypmi/R2kwCn6R1R9aem/ak4Zqtc1HnTfsIA7aEy+rLhPUa3zaQ+bYNEcowYGm7WP28nahOtSFD8O1i5UdwChf7mkakCGA8LVqqZCj9dO72WO866Ec1qEHnSgp9csk1bpntkmnUxrB8xjAQzClpvmWkp6vxOCSaaUc8v8r/G/iaw+av9Kv6dcfnSexVLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukA/7rFDrX1rMM87KwkXwDmKC+r7UHVQDJ8VZZIBy9s=;
 b=qzOuoIkmGFYmTcvc6z+UkGtERsL3acsTeWo+hhtENp4JcZOLLzY6xNH8kznTpQmNttiJFS4Lm1uEjofeRKi2KI/USNQmEDFBRyvxku5WInxoUA+EoIEzSpBbe9PJGPojTbY7Gc2HNRczYC0WAEFGnpf2mp2vvDAJPrpUURy2L8M=
Received: from IA0PR12MB7675.namprd12.prod.outlook.com (2603:10b6:208:433::9)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 02:45:45 +0000
Received: from IA0PR12MB7675.namprd12.prod.outlook.com
 ([fe80::b2f4:4979:b048:3060]) by IA0PR12MB7675.namprd12.prod.outlook.com
 ([fe80::b2f4:4979:b048:3060%2]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 02:45:45 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 3/3] amdkfd: Add device links between kfd device and
 amdgpu device
Thread-Topic: [PATCH v2 3/3] amdkfd: Add device links between kfd device and
 amdgpu device
Thread-Index: AQHcahG8rB7S50hBWEiJ81jruvbCr7UjlzoG
Date: Tue, 16 Dec 2025 02:45:45 +0000
Message-ID: <IA0PR12MB76756BAC95FE0BA91AB291AC8CAAA@IA0PR12MB7675.namprd12.prod.outlook.com>
References: <20251210201510.3000-1-superm1@kernel.org>
 <20251210201510.3000-4-superm1@kernel.org>
In-Reply-To: <20251210201510.3000-4-superm1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-12-16T02:45:45.655Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=1;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7675:EE_|DM6PR12MB4385:EE_
x-ms-office365-filtering-correlation-id: 389fd328-e801-4f5e-3f44-08de3c4d365c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Lq7DskuV2pnUchYfggbiHDZEwWHMZXMaKd/UOUf37WhjWsLkHo1IQjtOPB?=
 =?iso-8859-1?Q?qdj0DenAYXObsaSehtMbAYg1dLe+ji4AuuLaq+muUueiAjmkj3aTub12Re?=
 =?iso-8859-1?Q?W1429rHmxw5j4nsw/A8ke9twPW2XErGAltI80yO8Ko7yQ7UQiN0cVjJ9kG?=
 =?iso-8859-1?Q?28lEBsS5V6JlSj0WpIU3/nhfKd8ANpWUlmXNN+lqG6Fdv+gwFdFqNG0tBp?=
 =?iso-8859-1?Q?bVAOo3jsrbqQXPB9uvSrC/uz0VlcqniGiRd8b60CXNIgqDYxfFLdMce2V+?=
 =?iso-8859-1?Q?uytLA+gdXCvnl0u11s/xcG2jryyFQNT6CZDtgD9ecLEMy/uZycoFBZ9+EB?=
 =?iso-8859-1?Q?oybBor9Tz/TJNKzdDlvCmaE0kSoTIig9WOFS4oAcyn4yFeQvvlUnrRkfKQ?=
 =?iso-8859-1?Q?vui/Y0afxQmUI4N+q1SUiL9IKxdNhBbKS64PKl9vhcFgC19dJTVyNGqNvK?=
 =?iso-8859-1?Q?AS/T9Klt3iTVos9TYUSCVeBneCRP070FFWDBVFkN4Ch52dEkxzrHB7bkdh?=
 =?iso-8859-1?Q?lRJfxAy7+p+zkpdho4c+2GO4RmgAsyJq4c57XUYjENl3vpz9XEfHEMTq9b?=
 =?iso-8859-1?Q?vZ2+aYkl9iDYT1bTjGMYHgww3Smvl8mu4UlBMQHLxtcAn/7Lq1qGzUMADM?=
 =?iso-8859-1?Q?wzJ4LcIRtBxxg8At5NRDIet6eNWt0+i96dN+aaoAeis9mrRbCqQlsrTcZU?=
 =?iso-8859-1?Q?q6XandMLEVLJaWKTQsTelRLdEyWlSyIG0xTJFAZyJwSuWvpWDgQr2VRA6c?=
 =?iso-8859-1?Q?18O1QaskgX3H4GRxr1xxrxQXc1UX2fYpbPuz+jPX/g7kreZM/H4JTLA4Z+?=
 =?iso-8859-1?Q?LH2Da3JCxKpdhPhKDhzajxNxrgysa0ZBN8aGjTmWi0mCHRmqBXEwBjK0PL?=
 =?iso-8859-1?Q?oWQT0LpYeuHHy2jZQsy7nwk0TNADq35hhg6sVhTEU2buDTSW4Nhw8RV958?=
 =?iso-8859-1?Q?kekJzxJZcrRY1s0WMhceo4ZFTb0c7UrG+peDRnf5EpSLZEIEW5iY1Ny3HN?=
 =?iso-8859-1?Q?7FluUCa9b6YSFx+aHOsq63lsKjldaBSM2w75t8yfZLSEYVHrGLtZRwWss8?=
 =?iso-8859-1?Q?427rV31QuE8B21okjYwFITFrltACXZhmyuTbwNQo61ekLIIQG5gUHMCjGh?=
 =?iso-8859-1?Q?XznRqrVeJmePfiS1G9REoXx7VNwJZTPF+2ZAC5UoJdz+WIFrPE1uIb1CkW?=
 =?iso-8859-1?Q?64u+IVrcg2kzwJIQlWanoKMssc1uRMCT49TFLj/5nVLQ5lxHesSpRUddc5?=
 =?iso-8859-1?Q?Awfg57a60OE+0wrH14wyREii/Ja2vSQyEKtboMHllvqP4YTd8F58Uzr2N7?=
 =?iso-8859-1?Q?592Q0D3E4YacJ3CDF2x6JPNlJs0pjKZg7wrZHEAro32VB6RJDDqSVCIe+O?=
 =?iso-8859-1?Q?J4eSx0lxN2JxVExNro01jug47mxPjrq5m59SkjtKXLO24k+STNl7Mt6IPd?=
 =?iso-8859-1?Q?XIYMjsF03X3nJY993MRfeaXO6GAghSLSoIwxESjrFnuDiVEhqb81JxC+W/?=
 =?iso-8859-1?Q?tDa6O7SSIv2nJ69rp9H2NnumQ99M0irfvgZO99WnYy74Cqe13t7xVPgpIO?=
 =?iso-8859-1?Q?zJK8s+C9CV4rEljJXmIsEas7eFHA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7675.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IWUnnaIHVZvRD+EKyJ9eKaGDkJO+ESiIHHTXTpZIOeTET8F0OAleLKbhSm?=
 =?iso-8859-1?Q?uVJ0Nh7njPb+qu9Ik+CR9+62FP1ZVRuTWuZJSS/54aE9ZqDtU+AiKLoVTC?=
 =?iso-8859-1?Q?9HrsJJPlEkJW9wBymoNqFzh4mNLBIV4hnU/M4H4Mw6anproW6MV/UrCZYL?=
 =?iso-8859-1?Q?ZTtZYNeDWBk46TGyzTSddyPTnte4h79TT/CjAjrHdwSsgYdcauzZOAKbNu?=
 =?iso-8859-1?Q?X+hgM/GKDjDNAcxvN8B6iqAEpzMqQz2tqVXcZqwzFdOfauGhyB6v8zYdoa?=
 =?iso-8859-1?Q?wMBZ5J8A9eFDSqF+HqTJr8pcpGwLDtL9CsA6b6mnpOmnqFqQOw2D8YHwK7?=
 =?iso-8859-1?Q?eRf1RGN069Qxm6xy/jqVdrAuDB5AHfGLCg3WLx36goPAMisnFaY7GkW4B0?=
 =?iso-8859-1?Q?vJClOtfxl9zqqHLH+IQR8++OgR7UzOPpvr3jF+A5vB8Z42Q4nzP6u7Xzsq?=
 =?iso-8859-1?Q?7RL2/p54npp4j5sp2CiC2+ipBlccCxA6EcSr+SUny7WCyVhpiBI/TFw8KM?=
 =?iso-8859-1?Q?EZ/zf7kWSzIebTkQNNJmEQrd8KIp82/pCupAUFA+39ERZHjik/CeDaTUmw?=
 =?iso-8859-1?Q?8h01SqOuIa/fgYPxNEWnG9KE7o45NOQ9Ob+39QLxKeS0B07RQjB0NviuY/?=
 =?iso-8859-1?Q?/0qEp+08R0/bXog02JrZZFIOK0vzrB+nPWv5OeSJ4KbpsM+gyT0RpLbUQ5?=
 =?iso-8859-1?Q?Lw1pTSnHzN5bCtc0OBZKjgl3s3px78fXfWoYBa9n5gNBAaPaBqB1lV8utZ?=
 =?iso-8859-1?Q?D7N6Y0Vx+GxDMk5Lp8pUPDdFJRkpmYEYxp4vSRuGVSxJf3GGIojr8tS7RO?=
 =?iso-8859-1?Q?9i8Jf0q6/KQ3+ZAZzFRYGXNvYU+tBv23kL8vv5vL+LhpHmRfH5Arexjt6X?=
 =?iso-8859-1?Q?5TYal/nWYKEoY0F4vONQVKogt94eiyv50bjczPDLe7JMsJByb/aGR+3G+9?=
 =?iso-8859-1?Q?adlAi+4UdwIu1F7jV1frF7jqumnj2kJFbiZWK9huu6K5tiglEcbfs8BsLX?=
 =?iso-8859-1?Q?fpeakyP0X0djMuxdYOyB4UCqJWXPzfXTTCve7cbvlnkKQjqIrWb/1ChrUh?=
 =?iso-8859-1?Q?MzpQms6xsyEiLgG5Z+dA95nwYP04Poew2K4uhD/dQcgbJ4aVnPuIXkeDGC?=
 =?iso-8859-1?Q?L4SGuvBOvWkXShOCrMEG3JgnggODfDju9ibsHDtDLIazSBI9OSWg/qNah7?=
 =?iso-8859-1?Q?r0a+FuMzAvGioy9dijEYe5UsJnNK0v7iBTnwxSSkvsnJ9tvjufBeZ5BISv?=
 =?iso-8859-1?Q?/drzYJ2PCyLn8ed9Q0ewlp92RWL43vqMoOZe8hvZEd5jdBD7pXX46PyH6C?=
 =?iso-8859-1?Q?FalPZcoaR9L3iW4H+/pGNiBCLu1zSw1EAa63DSfdUoCICNG71lOIf8p8x/?=
 =?iso-8859-1?Q?nZSPlNedoXOOlgP6/Md3lmfAEHwcIpOzojEHglZYloBU42TepAAlnso9+J?=
 =?iso-8859-1?Q?dBaVAYW/wH+9f5N2j3ItaT0NWcoOny96wWn6pTyuW/Pj6JrSGsxPPMF7sZ?=
 =?iso-8859-1?Q?BDjgX/LPF+R8dhHG9/OcWGs/bfI21mzXGJCU0CPCKKwXsTv5r2Blim1CUf?=
 =?iso-8859-1?Q?7625InnCbfoQ2KZGn2T4yURExgl+cFkc7BtxO69U9LzmPNiz0+at/KgEHK?=
 =?iso-8859-1?Q?D9mZlbjjys2q0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7675.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389fd328-e801-4f5e-3f44-08de3c4d365c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 02:45:45.4939 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/mRgLci+2aSnsahtdBIJ6cicNWJjWFhNTQNdjwcGPVN+eulaPEC/HSRWosAaLUViXq9nufVxyvllAMJW+VfEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385
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

Similar comment to previous patch. Once you do spatial partitioning (like Q=
PX or CPX), there is no one-to-one correspondence between drm node and kfd =
node. Partitions don't change device node however, you could have multiple =
(4 or 8) kfd nodes. =0A=
=0A=
Best Regards,=0A=
Harish=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario =
Limonciello (AMD) <superm1@kernel.org>=0A=
Sent:=A0Wednesday, December 10, 2025 3:15 PM=0A=
To:=A0amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>=0A=
Cc:=A0Mario Limonciello (AMD) <superm1@kernel.org>=0A=
Subject:=A0[PATCH v2 3/3] amdkfd: Add device links between kfd device and a=
mdgpu device=0A=
=0A=
=0A=
Mapping out a KFD device to a GPU can be done manually by looking at the=0A=
=0A=
domain and location properties.=A0 To make it easier to discover which=0A=
=0A=
KFD device goes with what GPU add bidirectional links.=0A=
=0A=
=0A=
=0A=
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>=0A=
=0A=
---=0A=
=0A=
=A0drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c=A0=A0=A0 |=A0 8 +++++=0A=
=0A=
=A0drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h=A0=A0=A0 |=A0 1 +=0A=
=0A=
=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=A0=A0=A0 |=A0 4 +++=0A=
=0A=
=A0drivers/gpu/drm/amd/amdkfd/kfd_topology.c=A0=A0=A0=A0 | 36 +++++++++++++=
++++++=0A=
=0A=
=A0.../gpu/drm/amd/include/kgd_kfd_interface.h=A0=A0 |=A0 2 ++=0A=
=0A=
=A05 files changed, 51 insertions(+)=0A=
=0A=
=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c=0A=
=0A=
index a2879d2b7c8ec..5d6cf3adfa7b8 100644=0A=
=0A=
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c=0A=
=0A=
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c=0A=
=0A=
@@ -910,3 +910,11 @@ int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_devi=
ce *adev, uint32_t xcp_id,=0A=
=0A=
=A0=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 return r;=0A=
=0A=
=A0}=0A=
=0A=
+=0A=
=0A=
+int amdgpu_amdkfd_create_sysfs_links(struct amdgpu_device *adev)=0A=
=0A=
+{=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 if (!adev->kfd.init_complete || !adev->kfd.dev)=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
+=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 return kgd2kfd_create_sysfs_links(adev->kfd.dev);=0A=
=0A=
+}=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h=0A=
=0A=
index da4575676335f..fd92b227a674b 100644=0A=
=0A=
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h=0A=
=0A=
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h=0A=
=0A=
@@ -272,6 +272,7 @@ int amdgpu_amdkfd_stop_sched(struct amdgpu_device *adev=
, uint32_t node_id);=0A=
=0A=
=A0int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t=
 xcp_id,=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 bool core_override_enable, bool reg_override_enabl=
e, bool perfmon_override_enable);=0A=
=0A=
=A0bool amdgpu_amdkfd_compute_active(struct amdgpu_device *adev, uint32_t n=
ode_id);=0A=
=0A=
+int amdgpu_amdkfd_create_sysfs_links(struct amdgpu_device *adev);=0A=
=0A=
=A0=0A=
=0A=
=A0=0A=
=0A=
=A0/* Read user wptr from a specified user address space with page fault=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c=0A=
=0A=
index 7a0213a07023d..44c9320d72a56 100644=0A=
=0A=
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=0A=
=0A=
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=0A=
=0A=
@@ -4947,6 +4947,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,=
=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 r =3D amdgpu_device_sys_interface_init(adev);=0A=
=0A=
=A0=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 r =3D amdgpu_amdkfd_create_sysfs_links(adev);=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 if (r)=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(adev->dev, "Failed to c=
reate KFD sysfs link: %d\n", r);=0A=
=0A=
+=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (IS_ENABLED(CONFIG_PERF_EVENTS))=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r =3D amdgpu_pmu_init(adev=
);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (r)=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c=0A=
=0A=
index b65f29294e2d6..796fd411a7dcc 100644=0A=
=0A=
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c=0A=
=0A=
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c=0A=
=0A=
@@ -79,6 +79,37 @@ struct kfd_topology_device *kfd_topology_device_by_proxi=
mity_domain(=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 return device;=0A=
=0A=
=A0}=0A=
=0A=
=A0=0A=
=0A=
+int kgd2kfd_create_sysfs_links(struct kfd_dev *kfd)=0A=
=0A=
+{=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 struct kfd_topology_device *top_dev;=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 int ret =3D -ENODEV;=0A=
=0A=
+=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 if (!kfd)=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
+=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 down_read(&topology_lock);=0A=
=0A=
+=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 list_for_each_entry(top_dev, &topology_device_list, lis=
t) {=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct kobject *amdgpu_kobj;=0A=
=0A=
+=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!top_dev->gpu || top_dev->g=
pu->kfd !=3D kfd || !top_dev->kobj_node)=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continu=
e;=0A=
=0A=
+=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 amdgpu_kobj =3D &top_dev->gpu->=
adev->dev->kobj;=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D sysfs_create_link(top_d=
ev->kobj_node, amdgpu_kobj, "device");=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=
=0A=
=0A=
+=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D sysfs_create_link(amdgp=
u_kobj, top_dev->kobj_node, "kfd");=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sysfs_r=
emove_link(top_dev->kobj_node, "device");=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
+=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 up_read(&topology_lock);=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
+}=0A=
=0A=
+=0A=
=0A=
=A0struct kfd_topology_device *kfd_topology_device_by_id(uint32_t gpu_id)=
=0A=
=0A=
=A0{=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct kfd_topology_device *top_dev =3D NULL;=0A=
=0A=
@@ -571,6 +602,11 @@ static void kfd_remove_sysfs_node_entry(struct kfd_top=
ology_device *dev)=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct kfd_mem_properties *mem;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct kfd_perf_properties *perf;=0A=
=0A=
=A0=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 if (dev->gpu) {=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sysfs_remove_link(dev->kobj_nod=
e, "device");=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sysfs_remove_link(&dev->gpu->ad=
ev->dev->kobj, "kfd");=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
+=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (dev->kobj_iolink) {=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 list_for_each_entry(iolink=
, &dev->io_link_props, list)=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if=
 (iolink->kobj) {=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/=
drm/amd/include/kgd_kfd_interface.h=0A=
=0A=
index 9aba8596faa7e..f6db1dc634399 100644=0A=
=0A=
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h=0A=
=0A=
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h=0A=
=0A=
@@ -335,4 +335,6 @@ struct kfd2kgd_calls {=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int engine, int queue);=
=0A=
=0A=
=A0};=0A=
=0A=
=A0=0A=
=0A=
+int kgd2kfd_create_sysfs_links(struct kfd_dev *kfd);=0A=
=0A=
+=0A=
=0A=
=A0#endif=A0 /* KGD_KFD_INTERFACE_H_INCLUDED */=0A=
=0A=
--=0A=
=0A=
2.43.0=0A=
=0A=
=0A=
=0A=
