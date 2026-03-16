Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFCCEFCBD2
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 07:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75FA410E1EA;
	Mon, 16 Mar 2026 07:04:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QnyM8Aa8";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A35CF10E1EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 07:04:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/fV3pAAYX7vx9OZT6bClFimxFMdE/aO4sRtvYpvFOjZ/MH9qV/fl+eGmQtTPOOL3zuoov6qzwerRfeiU8GV/gZM5XAw8oQwCpmmHyIsIGFCh4d5CjDb/haUzVQ5iWGHJ8/qeW7bKlru10lBm7sphFA47MnW85iiKOI43t8X/4QEgAnor79dcFJs67LSQ/yK76TDVl6/wk+VDEI6oyA62Ma/rAz525gH/zhcu5QP/xw2+Uf+bRsT4RVhvu3/P25T5dWJAWr13sxYnf/9vvn+5lDD1/8q/SR+kJL4yX2GPFtlDYB92gBBSlHz7kS74/z8vPEApbdT43rRFdTHfb4LTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YhAwRO4XYUTa3hUvMHnsX//g1xNCfZ/ck5q2Od9GJE=;
 b=NBKiYHGQNADg2HjWEilNP8j9KbjKedK8dApzVb+y3wdYuxyuo6ou1eNNILG+8Q6nn+AMazOqkBmfMC9M7Qyp6XOgz2T8CYiE1LU/A1wamZ7JO/frf01EHH8inv28jRwJHnfPwuEeukQJjYqvHJtQWalvI7PWTtUBN44vvIRlKz8UqeCw0tj7mU1BRmLQcVdYlEBd5ey/b5SxVFT/5El7qrPh0Fo9zbI8ArvYCI1qU/OSL2to30qAgx/MAugxuhlHIpq9L5bfWQ5bRBJwO5FPN91xRqKNZYEUtv4KoyxMDNSv2AEJ3/YEOVZICofIUK3u4UboNmXg6yLUlFO3J3NsWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YhAwRO4XYUTa3hUvMHnsX//g1xNCfZ/ck5q2Od9GJE=;
 b=QnyM8Aa8VJ7n4ZLaUuRwAXTAcwoV7IWU1Em56S+8YzeAY47rrqFkWwb/wgZssOdw6xjN8SJWRx1flXLUJwQxPT9+2JZjiCKMzOCw+/BlOwxE7BV9+w54eADo51vVetmAYx0A73lkUizVqQsUpHRtKUkx6vq8jLNzsLkRErC7g7w=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Mon, 16 Mar
 2026 07:04:46 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%5]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 07:04:46 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Make emit_vm_flush() check explicit in
 amdgpu_vm_flush()
Thread-Topic: [PATCH] drm/amdgpu: Make emit_vm_flush() check explicit in
 amdgpu_vm_flush()
Thread-Index: AQHctEjHTRXdgtejGUya05vLwjjEarWwuVOAgAAD1XA=
Date: Mon, 16 Mar 2026 07:04:46 +0000
Message-ID: <IA0PR12MB8208E15658F04F7E3A6A345B9040A@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260315065528.1932950-1-srinivasan.shanmugam@amd.com>
 <bb50bb58-4101-4908-aec4-be7003321f79@amd.com>
In-Reply-To: <bb50bb58-4101-4908-aec4-be7003321f79@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-16T07:02:33.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|SJ0PR12MB8138:EE_
x-ms-office365-filtering-correlation-id: 1a9c6bc1-c355-40bc-8c89-08de832a4e7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: jpCge7ylnDh+K2x5rM1p2WZISCGbWbDqvmRtoo31USSxdqi9Rj3/duipLv8OpWAVPP82EyIcJsqKKZ/Dz5sPht5usiAbof4MCFKbkD2mM1nPY1sSwDlV+xp4Xkp1yUWwerjNF33mkXSva6mFp/Ly6gkbpU63F7yRR45/v5HukMnVnYtLN7z7CzWpTS8NA8Qqwb1E1qv1yJGZ58A06MmhpbqnpjzshZylCIxMTSZHFpL0STCGZZP8aNanSA59DT4A5i8Umjm1TX8JwxFLvrVLSoJyD6cmb5JKrJTZFNkTQ3tJ+kI/pU+jMerqhlCncEhJgbl5ikgn44Sw4fiBuvwcIqC+cvQq/QGWUA6OJaRIXw6C+HKFoFH8iLv5ebaHkEeK6/I8ZK/EpskwG39f2q/bP6woelHZ8NPTLcwTtroYXu4Z7tW04eue6WFZuhIA0+REtbuNPehEAVX08oVFNW8C71jd0exSUKIDFlzT0BwLwUvUiaz6NA80m7if15EkGdsRnMR0MSQFwaaoJmvZTPxbuAQNJEW8NBdMMEqcTSzxMiRQOxJvAJV+Zq9gQ1bDL/j7AN8H+Zk+PmqkRlqS9wEeT/bCY3ZBYqryOC4spP1TJ7V+OJ0IsA3R6Xui5TYRPI5VJ/W+OLj6ndYTN/4YtaU5BWkQ6RhsNTTsDJ2DNMb8s/17C6taPnTgxIHp8WdPIiJNVhPzmIqryHTUTuWHO9FCPkyWLXvMAHaV/3+w8/Z4S6fJMx3+cpiMplKmDz9R4N+hN9g3R+Op+kJiOK9tb/0UP2q08YBMfOM2c4vdCuFn6w8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVB1M05HYmpFVlRDQkFNek11b2hxWkptbUhKSGUydzY1aDFTVHpPdEdyTVZ5?=
 =?utf-8?B?R29NS3U0YmJ5Q1ByR2x4TWVoVlNPV25ZaVgvd3h1NlFjVXZHc2lweS8rK3du?=
 =?utf-8?B?RGRhMjBHbGFPQlpFbVcxUjQ0andGMHZaMFlTdmk0ekZwbm1ISG9xOUp1bDZ6?=
 =?utf-8?B?bURreXJlN0FRd1RObS9pNnYwWjEzYjdObTRNUktoWFlrVEpRMUZ1SktwRktV?=
 =?utf-8?B?TU9BdkdjUUNiSHI3VGU4Tjk5eFZjYVEvZmkzekpKVXNqZnpFSUxlTnh6SEVC?=
 =?utf-8?B?OFM4b2ZZQjd6Y2FnZDJBZ3JyRnNCa0E5aTNSTHo4OTVGNFc3Rm93K2ZWOEhI?=
 =?utf-8?B?N1MyQmlycVdzQ05hK3I5NzRCMWQ2WWRnSnBTelVXUld2bWJMWmtpRUdLZmZ0?=
 =?utf-8?B?b0dBZHlYRFpTcnkyblZIS1JlLzQ2Y094MjlDZ1NkcWJ2OEhJQ0FRNjNQR3dU?=
 =?utf-8?B?aHp3RnR0djZWdXh3YUFCVGI2VnhHQy8zVFpkUXNqbGhsZlhsVEFHWlpybk1m?=
 =?utf-8?B?eHA2MkdPMG9qZXZuallpZGVYNndzbUxybzVIUmZ3cjFpVktKbUx1SFFnSmtP?=
 =?utf-8?B?b0hLY1laeW5OU2NIZ1FJSk11ZDg3UDFyUEM3UDMvd1NBc1pnSjhtYytGSFlI?=
 =?utf-8?B?UkMyQmIvbkQ5STFhQ2s0REJieTArcUdnRHNUdUFPUmdnaUpkL2hLYTBkcXdi?=
 =?utf-8?B?NldBNEhJc0I3NlQxQ0tjckFCMk9rNkFOam9FanRVMmZ1Q2xNNzNRKzlkb2pp?=
 =?utf-8?B?ZTdGeVVVZTd0U3hBanZiRmkzLzZiR1FQdEgwM1ZwSjZkV3A1T0ZxVnRYejJX?=
 =?utf-8?B?SE04SGN5dFVPZU5IclpEU0FkMFdZTzMwaGxYU2QyVWxFckFRa0NjTHphVk5V?=
 =?utf-8?B?d25YUTRFeWxiWkVYVjJ2TXBsUXNTL2xKWlhNR0xSY2lBRnhwOXJtRENzcmNm?=
 =?utf-8?B?NXNGaUxKR3BKbTlnZG9vL1dYb0FSOUlVaE1IUXhuV2Q3aHVYOXJ6QXV4c0RJ?=
 =?utf-8?B?ZnVEeGdCRGIyYjU3dFdZNUxiY0lEN1ROeG1qSUkvSnJqWElXaEQ2SXM5NGZC?=
 =?utf-8?B?T0cyVXFBdWpBeFhTaWcyRmZwQVU0NTdPRmc4VWlweXRZNDNRNVl5S0xuRTRG?=
 =?utf-8?B?WE1BSUFVcU0yRkZnNXkwYWhDTXJaVDhreGs4bkNUN3B2WGpZRFhuV0RvQmNO?=
 =?utf-8?B?ajVPOXhXeis0OFNYWlRZczREeDdIQkpWWHNNZWJxWk93S1VpaEtzL1MvU1Ju?=
 =?utf-8?B?bUd3QmhjUTRVd3F4RnpsTUNINVhmbDBQTFZZU0RNTHZzTmhtTXpHY0M2NFBM?=
 =?utf-8?B?aXI4VWhUNFY5YVdSNGZsMW5ERktObHlxSi96ZGkzMjRzSkNOc0FiQlRpOTBB?=
 =?utf-8?B?ZTA0TDExb29MYi9UZngvbEErRktRV25RSzRhRWRVKyt5VjhVM1hsTWhISHNS?=
 =?utf-8?B?TVVtaXNxRjRSbER2VE1NSklybGcrTkhiS2ZqWXd5SG5LVW9oeDFPL0pEMW5x?=
 =?utf-8?B?empuQ3p3QzhSM2lvUDFaRmYwUFp5MGw5dUM1ckZNQm9TV2hBYlkwS3IvTTBp?=
 =?utf-8?B?RlQ3dGRYNDYwVEI0Sy85K0dHSGxqbnorR01lQzhjaVRKVERpQU0rWjN0SUZF?=
 =?utf-8?B?cll6UGZ6bFNNcnNBRHZjTmNiYUcrelFYMUs1YSsvTnphQzl3ZElhTDVJQUph?=
 =?utf-8?B?dDlVUlUrR2Y3ZGFjeHhKS3dxWWczb0I5bjdVcnFhd3NPZllLRDQzZiszSWQw?=
 =?utf-8?B?bHkwV1JWRmZ3QjVVdG9GSnNQcXR0R2krYjNSTVNyWmFWcEEyRWVaZkRweXVx?=
 =?utf-8?B?U2RtWmdoV0lyTHdpaUFFZnZWZzFhRGZjSnZ1UmM2YmZSSE5IOG1tVkp0Y0Rv?=
 =?utf-8?B?anNtdUw2UjIzZXB3S3J5WjBXOVlzcGxxYnlUbDFTaTQvU05xa2ZLOUZqNlRW?=
 =?utf-8?B?dEZWSjcvV2R6U2tVWXBlNzlNaG9oYWwzV1NFam4wMmlSaUF2elM2WkZnQk5w?=
 =?utf-8?B?M3dRYmV0YVpYQldBS2pRUTMyeWtuZ1l6Wmx5emNsVi80a0YzZHNsZGloTEpG?=
 =?utf-8?B?SjZyVEVpN2JaSFlZVXp6MGFoQmZ6RFRhYmFXSEJySFA4ZUZES2xnbzNSRmtL?=
 =?utf-8?B?cTd6TGJieTlWc2RXR0R3eW54Z0puVlFGb3BlTVZwMCtvaXpYTndHcW5ONFgy?=
 =?utf-8?B?cjZCNGVCR0JLSWNZMCsxcHNSUmRCenBCM2gvQlFWN3dzdU9PSmtLaUNnTGpp?=
 =?utf-8?B?RHBTRUYxa3hDbGtlNW5PSjVpRHZwUXlqUSt4a2VxRmNjc1lmNE9NQmhoQS95?=
 =?utf-8?Q?1HfXwXga4HIyCtBxha?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9c6bc1-c355-40bc-8c89-08de832a4e7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 07:04:46.1217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AO/lt7genaQw8JuBETPmgzpy5S8breLOnrhYG09a9nTiunOc3jdj4CmPuvgDvlfdaXGbgdOYClO2sHdGNl6ulQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8138
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwgTGlqbyA8TGlq
by5MYXphckBhbWQuY29tPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDE2LCAyMDI2IDEyOjE5IFBN
DQo+IFRvOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5j
b20+Ow0KPiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1
Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBDYzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJA
bGluYXJvLm9yZz47DQo+IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogTWFrZSBlbWl0X3ZtX2ZsdXNoKCkg
Y2hlY2sgZXhwbGljaXQgaW4NCj4gYW1kZ3B1X3ZtX2ZsdXNoKCkNCj4NCj4NCj4NCj4gT24gMTUt
TWFyLTI2IDEyOjI1IFBNLCBTcmluaXZhc2FuIFNoYW5tdWdhbSB3cm90ZToNCj4gPiBhbWRncHVf
dm1fZmx1c2goKSBzZW5kcyBjb21tYW5kcyB0byB0aGUgR1BVIHRvIHVwZGF0ZSB0aGUgVk0gcGFn
ZQ0KPiA+IHRhYmxlcyBmb3IgYSBqb2IuDQo+ID4NCj4gPiBXaGVuIGEgam9iIHVzZXMgYSBHUFUg
dmlydHVhbCBhZGRyZXNzIHNwYWNlLCB0aGUgR1BVIG5lZWRzIHRvIHJlZnJlc2gNCj4gPiBpdHMg
YWRkcmVzcyB0cmFuc2xhdGlvbnMgYWZ0ZXIgdGhlIGRyaXZlciB1cGRhdGVzIHRoZSBwYWdlIHRh
Ymxlcy4NCj4gPiBBIFZNIGZsdXNoIHRlbGxzIHRoZSBHUFUgdG8gZm9yZ2V0IG9sZCBhZGRyZXNz
IHRyYW5zbGF0aW9ucyBhbmQgdXNlDQo+ID4gdGhlIHVwZGF0ZWQgcGFnZSB0YWJsZSBtYXBwaW5n
cy4NCj4gPg0KPiA+IFRoaXMgZmx1c2ggY29tbWFuZCBpcyBub3Qgc3VwcG9ydGVkIG9uIGFsbCBy
aW5ncy4gT25seSByaW5ncyB0aGF0DQo+ID4gaW1wbGVtZW50IHRoZSBlbWl0X3ZtX2ZsdXNoKCkg
Y2FsbGJhY2sga25vdyBob3cgdG8gZW1pdCB0aGUgY29ycmVjdA0KPiA+IGhhcmR3YXJlIGNvbW1h
bmQgZm9yIHRoaXMgb3BlcmF0aW9uLg0KPiA+DQo+ID4gVGhlIGZ1bmN0aW9uIGFscmVhZHkgZ2F0
ZXMgdm1fZmx1c2hfbmVlZGVkIG9uIHRoZSBwcmVzZW5jZSBvZg0KPiA+IHJpbmctPmZ1bmNzLT5l
bWl0X3ZtX2ZsdXNoIGVhcmxpZXIgaW4gdGhlIGxvZ2ljLiBIb3dldmVyLCBzdGF0aWMNCj4gPiBh
bmFseXNpcyB0b29scyBzdWNoIGFzIFNtYXRjaCBtYXkgbm90IHRyYWNrIHRoaXMgcmVsYXRpb25z
aGlwIHRocm91Z2gNCj4gPiB0aGUgdm1fZmx1c2hfbmVlZGVkIGJvb2xlYW4gYW5kIHdhcm4gdGhh
dCBlbWl0X3ZtX2ZsdXNoKCkgY291bGQgYmUNCj4gPiBOVUxMIHdoZW4gdGhlIFZNIGZsdXNoIGNv
bW1hbmQgaXMgZW1pdHRlZCBsYXRlci4NCj4gPg0KPiA+IEZpeGVzIHRoZSBiZWxvdzoNCj4gPiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYzo4MjYgYW1kZ3B1X3ZtX2ZsdXNo
KCkgZXJyb3I6IHdlDQo+ID4gcHJldmlvdXNseSBhc3N1bWVkICdyaW5nLT5mdW5jcy0+ZW1pdF92
bV9mbHVzaCcgY291bGQgYmUgbnVsbCAoc2VlDQo+ID4gbGluZSA3ODgpDQo+ID4NCj4NCj4gSSB0
aGluayB0aGUgY29kZSBsb2dpYyBpcyBjb3JyZWN0IGFuZCB0aGUgY2hlY2sgaXMgaW1wbGljaXQg
aW4gdm1fZmx1c2hfbmVlZGVkLiBXZQ0KPiBkb24ndCBuZWVkIHRvIHdyaXRlIGNvZGUgdG8gZWxp
bWluYXRlICdmYWxzZSB3YXJuaW5ncycuIE1vcmVvdmVyLCBpdCBpcyBpbmFwcHJvcHJpYXRlIHRv
DQo+IHVzZSBhIEZpeGVzIHRhZyBmb3IgdGhpcy4NCg0KDQpNeSBpbml0aWFsIHRob3VnaHQgd2Fz
IHRoYXQgdGhlIGVhcmxpZXIgZ2F0aW5nIG9mIHZtX2ZsdXNoX25lZWRlZCBvbg0KcmluZy0+ZnVu
Y3MtPmVtaXRfdm1fZmx1c2ggd291bGQgbWFrZSB0aGUgbGF0ZXIgY2FsbCBzYWZlLCBidXQgU21h
dGNoDQpzdGlsbCByZXBvcnRzIHRoZSBmb2xsb3dpbmcgd2FybmluZzoNCg0KZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmM6ODI2IGFtZGdwdV92bV9mbHVzaCgpDQplcnJvcjog
d2UgcHJldmlvdXNseSBhc3N1bWVkICdyaW5nLT5mdW5jcy0+ZW1pdF92bV9mbHVzaCcgY291bGQg
YmUgbnVsbA0KDQpEYW4sIGNvdWxkIHlvdSBwbGVhc2UgY29uZmlybSB3aGV0aGVyIHRoaXMgaXMg
ZXhwZWN0ZWQgdG8gYmUgYSBmYWxzZQ0KcG9zaXRpdmUgZnJvbSBTbWF0Y2ggZHVlIHRvIHRoZSB2
bV9mbHVzaF9uZWVkZWQgYm9vbGVhbiwgb3IgaWYgdGhlcmUNCmlzIGEgcmVjb21tZW5kZWQgcGF0
dGVybiB0byBoZWxwIFNtYXRjaCB0cmFjayB0aGlzIHJlbGF0aW9uc2hpcD8NCg0KQmVzdCByZWdh
cmRzLA0KU3JpbmkNCg0KPg0KPiBUaGFua3MsDQo+IExpam8NCg==
