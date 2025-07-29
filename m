Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A8BC83F26
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 14:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AF4B10E285;
	Tue, 29 Jul 2025 14:55:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bSIjC43m";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1BDA10E285
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 14:55:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Drq2qyToz5dzyr+6ucoEcNaZyB/ddJrjmrzNM5XaLJdVrYvYshqpMcG6aykt3SLpBZmr7RlkhxRP5AnuZ0qZ6xdVqCnewdTqOa9nzErYSVd1K0wXtNw+zgx5I50fcPEtOVcAiJIkqikTWRmdj7XVDBfi7XvBv4a30nA+veMVMnZ10qZuMTl/p7CObLgc8rXJ/jxUou835CNdSLr+Z23Cu61/JDx0inWx+LU8spfM3gQW5e1KoIesK+EeYyRpwvWzgT7S1EI7+JInHOrpv2DIwSrAouaBn8qbxhfcqnEtGtscRg9rTpLjgswP3tmF8j8S5svApnkgTEg66eCODlwpkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkHe7HQHEAiEKORzu7TuU8QYHojYHHIxS4zLVgb9mM0=;
 b=Pcr/KPG099/zOQz2HdRclYzyZ/nEsbE8B7q/sAD36ow4LRsKXiLpomtER1RefauqF5SJ3auUOAMKUEWY9EcoQ5c46ORwN6wNGAyxaNKtM3tfdxGoDOokj4lG2opI39beLsr3Aa78oWip98VUf6VUNVQSbapWnt4qtVYbSLfAIlLrkaikR6xb2fIL5IrxFnp/RHLzb7kL9cJ9NU2QRm8B2fbdLxXXSt36aUreAy4cqbAcj98krecG0YviJ+Zc2zzv5eYxLz/yULtnXR1X3ClqE4OpD26fyTSaA8ZdXe3rTQa+SyQfZqeHZC8PE0sHs2DMo9yBQ6xe57aR6/kC0Krr4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkHe7HQHEAiEKORzu7TuU8QYHojYHHIxS4zLVgb9mM0=;
 b=bSIjC43mTdsaHZbJSFNcjVGjSaCh41stmiAVCBQjv35wkFPkA+Sh2IEhyXFMClRhBFERj+FiZvHc6HW/7+346nDe7emx4cW87T6rHYWhAiphDs1XmLRyA5/PQLdvQ4RSMC1mNSELWhytOdGd72rU0x15kIZ6+CQVkf4pxA6YVJc=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.26; Tue, 29 Jul 2025 14:55:37 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%5]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 14:55:36 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix unintended error log in VCN5_0_0
Thread-Topic: [PATCH] drm/amdgpu: Fix unintended error log in VCN5_0_0
Thread-Index: AQHcAF3JmZAuErvXo02Cx3ffdgEttbRJMMnA
Date: Tue, 29 Jul 2025 14:55:36 +0000
Message-ID: <DM8PR12MB53990885774CD77447C1D4C3E525A@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20250729075226.3407223-1-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20250729075226.3407223-1-sathishkumar.sundararaju@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-29T14:55:01.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|DM4PR12MB6256:EE_
x-ms-office365-filtering-correlation-id: 6324b2ca-cef5-439f-070b-08ddceaffa0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|42112799006|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UWNTY0t5N0o3dXE1SGVwUXdidkpUbzdmZjFmWHNYc1BkWGJQekY3RmNvZFRz?=
 =?utf-8?B?c1RYSjdEYWlxSGl2WE9iVHhvcVFjTi9DTFBXWG1kSDR4c2M5Q3ZPZzgvZVFp?=
 =?utf-8?B?TG5ZQUZRcFpPaWxVMzcyVGYxdCtNcmQ0MUI1b0FMSENJRjY2TGkxa29PQWV4?=
 =?utf-8?B?cnlROUEwSEQ1eVhKLy9SSGxKNmZqT211M3Rmc3I4cWhFZzZXa3NLeGl5YVNM?=
 =?utf-8?B?SXRQV2xPQzV1b3Z4KzVPVzZ4UkRWK2JtZ1NBamxDVFBDNGtLdHJON2licUcv?=
 =?utf-8?B?RzBLQVV4K2xjRGFDSi9aa3g3ckpFOHlINkY2d000OGZPQjVEUGNkeVdGR2tD?=
 =?utf-8?B?bEJYNXN0NDNDaVlRa1RqKzA2NXMwRVRBMU5lVVBUdlpaMXA4SnhVekR4TXZZ?=
 =?utf-8?B?NW1jTXdHdWR6SmxtSUY1SFV4MUxmQmdQL1VXVDNPUGo0WVV1aWg4NkJab1hp?=
 =?utf-8?B?ODhTcWF2WjNvMzRoM2tVeUNGZTh2R3h1S0V2VU9LMEpZZUhCNHZ2Mjd6dHdy?=
 =?utf-8?B?RmhsNy8xb2hONnJLc3R1cnAxUGVTTkRQcTk2QzZQTUpYek9pQTNFR21PeDhM?=
 =?utf-8?B?K1JKdFJWZkRlMGxpKzBVREZvcnhGbWFDUHV4VUU4NmhOZ3loK2twUWNFSk53?=
 =?utf-8?B?NnI5NEN4R2FBdnZUMnMxbklwUVpmRnlqUUJUNjU4WnRpakFyNnlIdW9HOVJa?=
 =?utf-8?B?dEI2R2srRDhNdldBWFFRWGxCQS96cXQ3bGNjZlFNdzRnSDlGVzM0TzNUb1pM?=
 =?utf-8?B?eXNsSDdKSmh6dERhOThXakRESEpPZFhsazU4UFJoZDBjOWJVZGhLVmJ1Smpp?=
 =?utf-8?B?RjE0V3pDQUZVdmlmZ2F1QncrVDZYUm4xanZqU3VDUUJiN2xsNzlhaGtFZWcw?=
 =?utf-8?B?TVhvRGJRNEp2eGUyUGlHY25Kb3Bvd1BtZGpQVHJWRUlTS2VnWG1rb0NDTkV0?=
 =?utf-8?B?cXNPcW1Gd2sxRmdqZTJYL0d0Zk1BeGtVU29BSnJPd2dNUnNtcC9xeVlSalRS?=
 =?utf-8?B?ZTlGRENxTkJYOTFocmNaVENrbFk0Q3c5Mkp5Ri9vMjg2OGk4MTBlZm41dE9B?=
 =?utf-8?B?c3lZUjRaWGc1eWVIY3l4NmhFUG4vSGluQzg3cVFEYnpGcDZXVlFLT29uMmk2?=
 =?utf-8?B?UTdQRlVPR1Rhc1ErTm83MjZzMmdXTjg1N09QT0gycVBUL0s1VU1PTk1xeHVy?=
 =?utf-8?B?LytKNTFRbUhLNXdwbmllbkRJUTVGUEZUbVJ6K2h5NTFBaG5OQWh5b0puRnZT?=
 =?utf-8?B?SFVBVmhTR3dHMzZWOXRoaEtiWjdJcnk1RndtUlVrek5PalJVOG9ZVGdDbDhT?=
 =?utf-8?B?ZHVEYVFESDM4UElFQ1dBMG16QW1jNmx6OGZFSlNTM0ZrQmlRWEJwMEdjVmVO?=
 =?utf-8?B?MkdtbHVieWhVaTFPaUNieXVrc0VneE1oMHhpcDExbHpFNmgweHREbWszZUNN?=
 =?utf-8?B?SjJrTjVXdEY5YVlWZ0xDMy9GbEpYQ2R2R0Q1WnRZcWJxSktrZitpZjBoRzZZ?=
 =?utf-8?B?ZWR3MzhGTFBIaEtpME03OVp3QnE1RkRiOEQwVVo0aGFyakNNUWFnNGlvWFBa?=
 =?utf-8?B?ZStkbUVBUjhXYnFwMGxMSTdLMUNWRTZrQlNvQ0Zxa3E2eTVIci9UWE1YN3pn?=
 =?utf-8?B?VXlKN0VaOGVnbE9kL1J4MG1rYXZQNnB0cHNkS3NnMVU3YzFoMmN5U1J0ZXBI?=
 =?utf-8?B?WTdEZzlOQ29jdW5NR0FhNUUrRVdzekpmTzZNei9HRGFXRnJCRVlselEwcGlx?=
 =?utf-8?B?N3NqbFhpQ0haOVBQTWpsR242SkRwWWJsa0VFMmNQRHgwNlN1SVplUkJkZUNT?=
 =?utf-8?B?TjI2aVJ6cFA3RGtDcloraW1wYko5MGNTbFBQcnNoRFdFVVl1ekJkNWx1cEU4?=
 =?utf-8?B?YTRNQ2MrYVl2MTE0cEUxZXlKUlBZNjc1VURVQWovaElpcldZa0xpOFAvOVo5?=
 =?utf-8?B?eVcyTjJZMG1zZlVJcGw2dUpIUFVLK2lEUkVRWnRkS3FmS2xQRmZORGVmYk9T?=
 =?utf-8?B?SS9selpZd2hBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(42112799006)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWsvRFZaK2taTzNVeHV1L2NQekt6TU53dHc3cmExT0hQam4rWDZuMUg1K1Rn?=
 =?utf-8?B?NkRTeEkzVjFvYXFwUjlDb1FkZlpyUUVFSmcwOHFaVGExT0hISURmZGFQTlRz?=
 =?utf-8?B?YjN2dEFOM1VUdGFwZ3VlK1JyODI2Q0pwaU9pQUNPTDY4UGtqY3RodlNqZGJL?=
 =?utf-8?B?cHUzVkFHMnFCNmJ6N1Z4NzVrUUdFMmZXcDdnYkRzWTgrUkNwRG5oLzNGamlP?=
 =?utf-8?B?anEvb3lPbVlzSUt5MnJteUF4Y3A4RGVBcEZZeHkyTS9EZDFrVlZ3ZHVvTzYz?=
 =?utf-8?B?QnFvM1BxUGR4QnJMbDlBNnQ3VnRXY09RZUpiRklKT1R3QjFXVGlWZm4rUXJQ?=
 =?utf-8?B?TGEyS1pNS2diL2hBR3dRSHhmeTArMmtUYmdaM080WnlFUlZlcVpPYjdDbXB5?=
 =?utf-8?B?U1JEMlZvRGRrNnVRZE42MytqR1V4dXhFNExCRk1FL2lsaWV3dFozbUxld2o0?=
 =?utf-8?B?QXpPZXN3NEJCOWVyUysyYnhjSFVFQWROVHBpRTIwekdxWVRtZVpvY25tckdm?=
 =?utf-8?B?bytTNjFRM3NKd2tKTVRzNVU2alpRWW85ZmNRWlFxMkErOGo4ZjY2bjZldlhJ?=
 =?utf-8?B?cWZ2SitWWlVDVGZuZ2t1K1NlSElwWFdwNC9NWW9nelN5enREaERTcmJxc2Vw?=
 =?utf-8?B?enJmeU9PK0wzZHV4WXBLZ3IzYURidGdUU3hMRzNpMnhQZ2VJTW5ZSzNuSVdU?=
 =?utf-8?B?ajVwMFQ2SlFmTG8zU2xXUE80MktnLzdLWk9xSno1VEJYYWFSVG5nNEhncmhm?=
 =?utf-8?B?Z2lCbzc1bDhqVGlzZU9vQ2FNKzJ0OCtiZmxJNTc3dE9wTWp1YUk0UTdFQUpa?=
 =?utf-8?B?MFYzSjBzQ3V5Q0t3OUpzSkt5Z0k5bEJ0Wlpycm1jajc5dzZOVlY0SGJrZW01?=
 =?utf-8?B?SzZWU2x0cFVuUDd0UU40bm9QRDhMemtOcU5wVkFpY2ZOTHdkL2pJK3d0OXl1?=
 =?utf-8?B?UTFmMDd1d2NjU0lFV2krR2gxekp5eVBZUlZQZlhLR01YWnpDZG56dkRkMi9a?=
 =?utf-8?B?YWs2NEQydlFjS0Jxc1dsU3JTbmZhT0xDVlArNHBhblk2SUJsZ292d25Ea0dO?=
 =?utf-8?B?d3dXbEhtWC9QU3pwWWFzWitHM2I5bmRZd0p0RGpYOTBmeGdUV05XeDNLN2E2?=
 =?utf-8?B?RVcyZFJVNFNqVkVKcUlyRzRlSUhWS2tmQzVVaTJFbzZQYVUxU0VNcHhNL1Np?=
 =?utf-8?B?STNNL2wvNkQwUTBOUU40dksveG1wNXFubXI2NVAxT0JGU0Nma0dydkNRNmZv?=
 =?utf-8?B?RUFRbGI4STV6UWptWDlPakMvZjBxY0IySlpibEhOakd4VGpEczFUSVRFUHYx?=
 =?utf-8?B?TUQvVW9TQUV0UTluejE2NjRTUk1jZGtFVExQMTZmQ2o2cGNUeVoveE1XVmRP?=
 =?utf-8?B?bzh5VGxpOFhscEJHcmlVMnNkNGw4MlB3TW5KZkFpQ0lvSmwybWR6VTBreWRN?=
 =?utf-8?B?eFFJRGVhcXlPdXh5eVBvUzJDUkoveS94Q3ZHclBwaWwyNkxydU1BeE1MVDR3?=
 =?utf-8?B?bG5sZ1BEdW1tS1RvRHRFRU5HdUtUbXc4bW04TWlaLzRpOUVBQVJxRXNhRnhV?=
 =?utf-8?B?ZXdIb3RSZ1F2VzB6eVZFTXBlY1FoaXRabklQQXlOTGc5SGJqOWM0VTM4M292?=
 =?utf-8?B?Uk16eDNpY2JhZkw0NE5BOUJKdlhSOXJPa0tOcXhRa0UwSnJyT0lSMjIyOHNQ?=
 =?utf-8?B?L3NxYnRsaWRtdXlnT21iWlRWZnF2cEd3SG5yRFpybkFuRHNGOWFKK2xmSlJy?=
 =?utf-8?B?QVp6Wm9PTzZqY1p1QjBMRFQweitZcTAwVHR1bzZhRkpjN01DQlBkZlpFUkcw?=
 =?utf-8?B?ZTJEWUdTb0xNNVdPNStrZi9qajFYTFVtZms0YXd0bklFeUQwS1RxL052bE5u?=
 =?utf-8?B?cnQ1clRTaGp1QlM4N3BWRVdpUWJ2MXIxby9pSmhNdEl5YVZ5QTVaUm1XR2Jh?=
 =?utf-8?B?SDZYSVFyZEQ2OWxrVmMzQ1Zac1Y2QVpwQnRSb1FXaWJxYzVQTWwzSksvMk54?=
 =?utf-8?B?dVB6WWlmQWhWL2FnNkhkSmN4azYwclBVeWVDb0h2ZDdldmFqVXlJWGJDODFl?=
 =?utf-8?B?dkptdzdjK2ZPbHJrY3ExUGRXYXo2c3kvbm9tU1NoKzBGWDVaY0NQM0pLVHh6?=
 =?utf-8?Q?EDCg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6324b2ca-cef5-439f-070b-08ddceaffa0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 14:55:36.6225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wrF0G0FkXSmSs5TOuVOwXEp7UZ+WQy9PoJfM9bOStTv0kgox3F6lrRO6SFWJ2FdV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KUmV2aWV3ZWQtYnk6IExlbyBMaXUgPGxlby5saXVAYW1kLmNvbT4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdW5kYXJhcmFqdSwgU2F0aGlzaGt1bWFyIDxTYXRo
aXNoa3VtYXIuU3VuZGFyYXJhanVAYW1kLmNvbT4NCj4gU2VudDogSnVseSAyOSwgMjAyNSAzOjUy
IEFNDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogTGl1LCBMZW8g
PExlby5MaXVAYW1kLmNvbT47IFN1bmRhcmFyYWp1LCBTYXRoaXNoa3VtYXINCj4gPFNhdGhpc2hr
dW1hci5TdW5kYXJhcmFqdUBhbWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6
IEZpeCB1bmludGVuZGVkIGVycm9yIGxvZyBpbiBWQ041XzBfMA0KPg0KPiBUaGUgZXJyb3IgbG9n
IGlzIHN1cHBvc2VkIHRvIGJlIGdhdXJkZWQgdW5kZXIgaWYgZmFpbHVyZSBjb25kaXRpb24uDQo+
DQo+IEZpeGVzOiAyOWVmMDllYWQ1NzIgKCJkcm0vYW1kZ3B1OiBDaGVjayB2Y24gc3JhbSBsb2Fk
IHJldHVybiB2YWx1ZSIpDQo+IFNpZ25lZC1vZmYtYnk6IFNhdGhpc2hrdW1hciBTIDxzYXRoaXNo
a3VtYXIuc3VuZGFyYXJhanVAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS92Y25fdjVfMF8wLmMgfCA1ICsrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdmNuX3Y1XzBfMC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmNuX3Y1XzBfMC5jDQo+IGluZGV4IDU5Nzk0YmQzZDc0Ny4uMzc4Yjk0ZDhhODM1IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjVfMF8wLmMNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3Y1XzBfMC5jDQo+IEBAIC03NTQsOSAr
NzU0LDEwIEBAIHN0YXRpYyBpbnQgdmNuX3Y1XzBfMF9zdGFydF9kcGdfbW9kZShzdHJ1Y3QNCj4g
YW1kZ3B1X3Zjbl9pbnN0ICp2aW5zdCwNCj4NCj4gICAgICAgaWYgKGluZGlyZWN0KSB7DQo+ICAg
ICAgICAgICAgICAgcmV0ID0gYW1kZ3B1X3Zjbl9wc3BfdXBkYXRlX3NyYW0oYWRldiwgaW5zdF9p
ZHgsIDApOw0KPiAtICAgICAgICAgICAgIGRldl9lcnIoYWRldi0+ZGV2LCAiJXM6IHZjbiBzcmFt
IGxvYWQgZmFpbGVkICVkXG4iLA0KPiBfX2Z1bmNfXywgcmV0KTsNCj4gLSAgICAgICAgICAgICBp
ZiAocmV0KQ0KPiArICAgICAgICAgICAgIGlmIChyZXQpIHsNCj4gKyAgICAgICAgICAgICAgICAg
ICAgIGRldl9lcnIoYWRldi0+ZGV2LCAiJXM6IHZjbiBzcmFtIGxvYWQgZmFpbGVkICVkXG4iLA0K
PiBfX2Z1bmNfXywgcmV0KTsNCj4gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+
ICsgICAgICAgICAgICAgfQ0KPiAgICAgICB9DQo+DQo+ICAgICAgIHJpbmcgPSAmYWRldi0+dmNu
Lmluc3RbaW5zdF9pZHhdLnJpbmdfZW5jWzBdOw0KPiAtLQ0KPiAyLjQ4LjENCg0K
