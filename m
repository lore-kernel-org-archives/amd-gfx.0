Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F757CA101F
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 01:33:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F280510E0F0;
	Thu, 11 Sep 2025 01:33:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hCzQnhpU";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C62C010E0F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 01:33:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTZ/mbSflmJLfPNVsJOCysUsxbaV90GzU8L1HA2xsSmC3kTOpHfNTsIDCYIROwm0YjNg/R/JczVhNF23nglekSUBABQ++RzIdkYzl/PtAbRa6suwEfkquyAbllA27BzneZIi8WJAnsUWgOD42wJmRRxlls9kTrR3sNUIyJY2nxh049heA/2nb2opwJ+lpblanke8/iLxrQKeyH+8HurU4toVBUbJR4YEv4152ljRf1NoDl3fyxLNS4nWOGjdW7cKNu92YgWUkyLhUMdBC/xx6eA5AxAK1kaR+WtssPhxYaD9i1LprH53svBTd424DRdAT+XfycQ7cg4AT7Q7DfeDEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USe91j1+9Dfuyrhanhejm6K8y06PIQMYpLh2mLQQ9Xc=;
 b=qiFxGHg/a9nzCcdGld8NYNECTqmBfP5J9EwgffYu/4HqRnHcXU7/fNeIc3qKqMzk0sVaR7vs0Th/7tEqAFYYdk7bfqsbDUR6eiEqYhASTj8CgNYEYbOpyAukv/Dz9+Gq+C3X96olmMO+wuqgueG2BChuapWN/JY4c1R0ESeDUXIVYE7j0j7oC7vO5DtPKurGHslvMt+CIuSstC1Xzkc1ulfrL/Z82aeVEhOSuvxBFYrN+F4uuR//EdVEEwdASDgYBw/bOA83d1JYegV777qv64LrG/A/4TTGsrejFx6Gd5N5+X+U3mZ9/gL3Xw8Hw8RmjKxhLFY2QRT2ZVquO0rO0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USe91j1+9Dfuyrhanhejm6K8y06PIQMYpLh2mLQQ9Xc=;
 b=hCzQnhpUInErH/tjt10QuHkC0wpYhny37G8zP5r9gDx/xKnBIkETd/Y/+7FuDRa6fBh1ToPYCFvJNihQo8vIqmIT+X0oJQyJqeaFbxLhA1efOjcOktTLvAhuLKAaqMWceeayfK/3wSWYPuSBFYPFLB7ZunUMdEtCigYBxw7wiEU=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA1PR12MB6409.namprd12.prod.outlook.com (2603:10b6:208:38b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Thu, 11 Sep 2025 01:33:07 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 01:33:07 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: pass the PD BOs directly for PA
Thread-Topic: [PATCH] drm/amdkfd: pass the PD BOs directly for PA
Thread-Index: AQHcIGn1khhrH1c5f0qJu9TklhsZHLSLqDxQgAFT0oCAADqCUA==
Date: Thu, 11 Sep 2025 01:33:07 +0000
Message-ID: <DS7PR12MB600554A97BEDE5F91393F6C2FB09A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250908024021.1857440-1-Prike.Liang@amd.com>
 <DS7PR12MB600542F4CF8B3D69A06EB2C6FB0EA@DS7PR12MB6005.namprd12.prod.outlook.com>
 <589ee8d9-091c-4afd-b4da-f091cc717336@amd.com>
In-Reply-To: <589ee8d9-091c-4afd-b4da-f091cc717336@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-11T01:30:55.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA1PR12MB6409:EE_
x-ms-office365-filtering-correlation-id: 3b20579e-7f8e-45a9-66ca-08ddf0d3291c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?WGtVSUgvUkNPbzMxdTNvQTZkUkorZXJRMUMraUphTXY5ZitJVS8zRWhvaVV2?=
 =?utf-8?B?RE9TOUNENkJCTnUvRCtZOVl5ejR5WkY0MTRzZVNqaDN0OXdRSncyb3AxNzdL?=
 =?utf-8?B?YlFNaTNUNS9icVJiUGVBem4rWEIyb3JWOFlLOU0wZzEvVnhyamkzMXh2b3g1?=
 =?utf-8?B?Q2NrTzJIVkljOExaQkNJU2VxUEsvbGxiczVTYXRET1ZnVVpOZG51TVZyc2hu?=
 =?utf-8?B?d2ZPWHRTM0VPeVN6UHIzWVd0U0hCY0VKSVhPQzc4T0JuT1JhSGwxaW9Ea1Mv?=
 =?utf-8?B?OHFIdmtmdlFZaFo0bmFrQ0krUVJUYlBkK3YxeVQ1VEdiZ0FWbFIyVHFNdGZ5?=
 =?utf-8?B?WElENEtRNkNPWnBNWFRXKzJubnBuV1ZiZ0sxYm41aHZvMTdadi9kVEthNTc5?=
 =?utf-8?B?QmFCaG1XMGVMYWZwY2hSUFl6bjdTeXpHT0hZWnBtRlhiQ0daT0RaQ1c3eWFD?=
 =?utf-8?B?T1ZiVFhxZWxVMW8xRjhGblBrL3MydDN2M04vaksrV2dRUVdCVmF4NGh0akha?=
 =?utf-8?B?eTZyM0l5YVFCTlZtN2oxdm1xUk15amtSNkVpNXpZQ0NhdG42NE04dnZjZW0x?=
 =?utf-8?B?VkZ6QWdZZVgyYjRYTG9rNFJYWUgrSjlWTXZIazVyV0tXeUNiS1ZuN09WSEFy?=
 =?utf-8?B?SnROdXZ2cVlscTZzby9Ibk94REtucDBZVXpISm1tbTR4ZzRRM1g5Z3JjUldG?=
 =?utf-8?B?LzN1VTBUUWFZMjZzNFBqcXNIZmZIRmtNcFBoVHh6UHNRcnIwc0QzM1BsUi9C?=
 =?utf-8?B?L1pVbUR5angwNHhwdnRWbk5PbDNtOGZieGNNdUl3NDFXNFE4dGRFM2FwNzE3?=
 =?utf-8?B?ZXZCbkxnRnlFV0o5bHdHR01pMXhXNkdFWmZnWERFeUxaLzFhMU5xMjhuVjZ6?=
 =?utf-8?B?a3ZRbzlycmpyOHR1NkxSUk1lWFY2Qk51N1B4VmxURFlJZzJYOExsWHMvWWlY?=
 =?utf-8?B?eDNEU1lLR2grVmMzTjhhRnpLUlhpY2xvZW0vS3dmN21VSE9lWjhRMSt1YzJC?=
 =?utf-8?B?bm9HUHpTMm1qWkZlTnJsK0xzU0lyRW9QZHpiTGNuMGRjamk1SUkvcHZwS1Z4?=
 =?utf-8?B?ZkhxS0pMVHdvRDBaVHprY1VvKzI2dFBITis0WHJVTk9DSHdFL0FxN1dNYUlm?=
 =?utf-8?B?OGx5VXY1NkVkcGZFSUVJWnNlTXJoTU9zcUJobjJ5MG5HOHIvUWF0cGEyRTVZ?=
 =?utf-8?B?ZHQvam5wQXVmWEsrRGdSa2UwSDcvWWF6cDNkMW1mNzZjSklZNGZhaFY5Z2kr?=
 =?utf-8?B?SFhrQlNITyt1Z2k2THgxdDE2Zm5oa1gxSmdWcUVnbUVXSHlkVXQ3bktOVEwv?=
 =?utf-8?B?aDExMnVObkZ2Nk8zc1poSENldlBYTnRuNGMwUTZTNldNRU5xVDlwRmFON0Y3?=
 =?utf-8?B?cGJjYTRyOXFTb28vZzl1RGRnQjJDaXBUNi9mTmNZQUFNcTFueEI4MjhZejFz?=
 =?utf-8?B?MUVPWmVFem1EOWpxN3dIYnFoTTVTcXU2ZmVOUzNRVXQxb3FpemFHRGo4ZEsz?=
 =?utf-8?B?aVVnRDYvanllY3JzeVBWWERET0NFNXRqWExwTzhkd0M3dTRBcThzeFA0VnpF?=
 =?utf-8?B?TmQxbmNyY2VTeWZLbS9QdmM5UUNacTVyR0U5eXQ0UlF1cDNlNytMZkNlWDNK?=
 =?utf-8?B?ZU9vZVZkUjRjL0pNVUQzeGcvdWx5c2VrU1ZOL3habWVFS0I4OHcxTmlTL1JN?=
 =?utf-8?B?TjhPekE3VzdhRTRXaHJSamdQTnpkMTlBazZJZUpSSytmL1RzNWtmczdGOVNR?=
 =?utf-8?B?RS9Bb05GWVEvR3N6ckpDTjVHSW1MM2U1b1llU0dDRG52WFBvcE1MbllFa3ov?=
 =?utf-8?B?Mkh0ZEEybVp1K05adnprUFFDTVRHRmQ0ZW52ZzdrOHQ4REh1UFdlNnplQ3F5?=
 =?utf-8?B?T2dXNzVuT25SdzBHb3FqdU5KanYzdGNEZ2hvaFJxNWc3VGUydSttWlpmcjVB?=
 =?utf-8?B?eGdNek8zL013dit2c2hmVUxzRXVOc0hVVTVPVHNrdjFDOVJNY2lXMmlQdC92?=
 =?utf-8?Q?79ZvKYZv3XV76ZowiWI7yHqVFs9eFo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkFqK3FZTmR6N2ZRZm5oWnN2YUNNY25IMVQ3eXBMTEU0R0s3N3pKSjdhN1Bx?=
 =?utf-8?B?T0JVQm44Y3dEVEhsdWZsVGVHdWh1Uks0R0NacmRLOEVSajY4RGRDWVZBSW5D?=
 =?utf-8?B?bFRQSlNDY2ZaTTl0UUN3VEdzS3V3akRYaTA0UkpiZ3B6VUJia0czaFJpbktX?=
 =?utf-8?B?U244bEJJUFcvQXN6ZDZkVVdFWkpTMkdlT2FpWlh4MjR4cXljdHlFSDA4RFlY?=
 =?utf-8?B?S0tDM1lFY2lYbkNURnJ3Vk1LazJodWtOVnpySkxOdWlRUUlxZnpuQklGcUZP?=
 =?utf-8?B?eURKM3NqTjcvOEdTSEdaYzRNSWpQU0JKRzlEVklieUNpY21EKzl6ZUt2VGhx?=
 =?utf-8?B?a3ArOVY3OWNGb0JTcXJ2Y3NDUS9jLzVlUDBTc1VrdHhXM2tqSHV2UytNekpG?=
 =?utf-8?B?TXg5Yk00Skd3WFRHbDYyV0NQRTZrUVJvRVhhaUtBWkxpdWFDdGFObXZobEhS?=
 =?utf-8?B?OW9iZERCZkMvNlByTlEzeFRMeHpYaytoa3ZvNlJ1YTNoR1R4d3lMWEFYYlQy?=
 =?utf-8?B?dDhsYXNyano1NVNENGFsRFhORGZUMitraWVORzRxU0VKanczOFljb2I4UU1Q?=
 =?utf-8?B?MWJQVU1XWXdJODVNNEkrbHE4UWc2Uks1bUg1eVVJSFVtSzhlbHgxb29hMjR0?=
 =?utf-8?B?TjkxcVhEVXBqSEdqRWYwOHl0STBJT1ZabmZvRU13aVFmZGNmZDBhZHU0b3I5?=
 =?utf-8?B?QktuRVNqdUFqUmJSQ3YxS3hqMVdQZk9WVGlNYzVoNzJmU2poMUZmRHRiMmRE?=
 =?utf-8?B?VlRtOHdlelFQVHUvWVl4ZHVHQ1VZY2VNdUQ5cE1BdDhqV2dhck0wSEhnUEt3?=
 =?utf-8?B?cWYzRk9GNS9SN1pCOXhNSkxKU0hheTdNOFl4U05Ed01BeVd5RDV5R0FNQjJq?=
 =?utf-8?B?UjZEenYzb1VDY080Z3hXTU1ncHJ6R1dxeDBqTFZMTXNVbkR1cEtVMjNSQ0xC?=
 =?utf-8?B?WHc0TzdTZVA2SG9YUzhvQ1c0WEhRWXZ1Z1pxY1UxVWI4UmVVQUhoQU1VSlNa?=
 =?utf-8?B?THJVQUtBMmY4YTU3ZzdkTzVkQ1FIaGs3RnFuMldPUmREK0w3d1E5Z3FZU1dS?=
 =?utf-8?B?MFNnaUR1VDgrM2locmxEZWRNMmkwQkhENlE0dlI1Szd1bFRBMXNtNWRLc3ox?=
 =?utf-8?B?UkdXUklFRGtuQ2JNNTV5WnNKbzdGdHc4T0dzZlM4SXgzQ3VHOUYrUUxEQ0VI?=
 =?utf-8?B?SmpRY0ZlOFhjcmZ4TFhQaWhoZ2RDZFM2aHMyWDBHQVFRUFFmRktqL25qUjVY?=
 =?utf-8?B?QkZLSUZGNXlDMjV4eHQvUFNOTlJtRmV2ZW1ZdWp3SGt0cWhYQ2J1Z25EdFhR?=
 =?utf-8?B?eG84MmNMU2U5akhLRUtUVkNsd0N3elJTSEE2MzlhcURySFNNempLdnk2MTNB?=
 =?utf-8?B?cGFaQVZXUTZWejdscDR5WEVCYVNxbjRLQU5rSHRKOHVEYkljTXdMUk1DNVhD?=
 =?utf-8?B?a1FxMHNCUDZ3T2tIMEtPc0dBNWdjbUk2MUw1S0RxSkFGNDdCc2FMYWF1MFB1?=
 =?utf-8?B?OFpCWkJHVzJ5MzJBZlpOa2FaRys4RjVpWXlUR29KSkFRdHVqQTdRMFJCSjNT?=
 =?utf-8?B?MFpNYkhXL3RnaFBaMUt5U2IzQy9HY3R4R1dpdy95N0x1YitXZ0RpTkxRcy9H?=
 =?utf-8?B?dHY0ZTF5QkhBNmU4Si9FM1dyUElWZnZPM2pKUk9TSTRHK3pwVndKc3lOTmJ0?=
 =?utf-8?B?ZktZY0xRaFYvV0lma3YwRzJWSDJTZjl3cStoT0QwcUtVWHNmUmlJeE9sOUlI?=
 =?utf-8?B?eWR0NGUycjBiSXY5bXFBOFZYUE9UeVF2WXFuN0JFb1E0QnZ2NzNEQVlORzhj?=
 =?utf-8?B?U0JRN3QxNDRiZTh2aCtDaDlXdFQvL1dBZFc2V2R5WHlZTUdrWW1wbDRkUlht?=
 =?utf-8?B?Y3hiY1BydU1tSTV6Y3QzNG1qdEZ1NWljQ0N3a01FRVFLUUZIZytzNnJ5V0pX?=
 =?utf-8?B?aE1XMHBBTlkvenNhdWd1bE01U3N3MWFhWEJvQXpSakE3SzhRWTd5cEZpWGRY?=
 =?utf-8?B?NEZ6ZmdnT3lydWNlK2VrN0NORzJvLzNpVFBFMzYyU00wanlXUnE4ZXJtcGMx?=
 =?utf-8?B?d0tqdTZ6Z0gwb2tXeTlXWkdjb0t0aHlPU2ViRmxVSTM0U3dyMDdMSFg3UnVT?=
 =?utf-8?Q?XJEs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b20579e-7f8e-45a9-66ca-08ddf0d3291c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 01:33:07.4608 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dwsaImKhO9adflMFQR7acSmCYIkyboyjmECD1B/WStSu3BUi01U9Qexjwj9Wtd6x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6409
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQ2hlbiwgWGlhb2dhbmcgPFhpYW9nYW5nLkNoZW5AYW1kLmNvbT4N
Cj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAxMSwgMjAyNSA2OjAxIEFNDQo+IFRvOiBMaWFu
ZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
PjsgS3VlaGxpbmcsIEZlbGl4DQo+IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIXSBkcm0vYW1ka2ZkOiBwYXNzIHRoZSBQRCBCT3MgZGlyZWN0bHkgZm9yIFBB
DQo+DQo+DQo+IE9uIDkvOS8yMDI1IDg6NDUgUE0sIExpYW5nLCBQcmlrZSB3cm90ZToNCj4gPiBb
UHVibGljXQ0KPiA+DQo+ID4gUGluZy4uDQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+ICAgICAgICBQ
cmlrZQ0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IExp
YW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBTZXB0
ZW1iZXIgOCwgMjAyNSAxMDo0MCBBTQ0KPiA+PiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcNCj4gPj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT47IEt1ZWhsaW5nLCBGZWxpeA0KPiA+PiA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT47IExp
YW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPj4gU3ViamVjdDogW1BBVENIXSBk
cm0vYW1ka2ZkOiBwYXNzIHRoZSBQRCBCT3MgZGlyZWN0bHkgZm9yIFBBDQo+ID4+DQo+ID4+IFNp
bmNlIHRoZSBQRCBCT3MgYXJlIGFzc2lnbmVkIGF0IGluaXRpYWxpemF0aW9uLCB0aGUgcGxhY2Vt
ZW50IHN0YWdlDQo+ID4+IGNhbiBvYnRhaW4gdGhlIFBEIHBoeXNpY2FsIGFkZHJlc3MNCj4gPj4g
KFBBKSBkaXJlY3RseSBmcm9tIHRoZSBQRCBCT3Mgd2l0aG91dCBhZGRpdGlvbmFsIGxvb2t1cHMu
DQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQu
Y29tPg0KPiA+PiAtLS0NCj4gPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
YW1ka2ZkX2dwdXZtLmMgfCAyICstDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4gPj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4gPj4gaW5kZXggMjYwMTY1YmJl
MzczLi5mZDljYmJlYmJkZjQgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPiA+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4gPj4gQEAgLTQ3Niw3ICs0NzYsNyBA
QCBzdGF0aWMgaW50IHZtX3ZhbGlkYXRlX3B0X3BkX2JvcyhzdHJ1Y3QgYW1kZ3B1X3ZtDQo+ICp2
bSwNCj4gPj4gICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPj4gICAgICAgIH0NCj4gPj4N
Cj4gPj4gLSAgICAgdm0tPnBkX3BoeXNfYWRkciA9IGFtZGdwdV9nbWNfcGRfYWRkcih2bS0+cm9v
dC5ibyk7DQo+ID4+ICsgICAgIHZtLT5wZF9waHlzX2FkZHIgPSBhbWRncHVfZ21jX3BkX2FkZHIo
cGQpOw0KPg0KPiBEb2VzIGl0IGZpeCBidWcgb3IgaXMganVzdCBjb3NtZXRpYyBjaGFuZ2U/IHBk
IGFuZCB2bS0+cm9vdC5ibyBzaG91bGQgYmUgc2FtZS4NCkl0J3MgYSByZWZpbmUgY2hhbmdlIGZv
ciB0aGUgaW5wdXQgdG8gZ2V0IHRoZSBQRCBwaHlzaWNhbCBhZGRyZXNzLg0KDQo+IFJlZ2FyZHMN
Cj4NCj4gWGlhb2dhbmcNCj4NCj4NCj4gPj4NCj4gPj4gICAgICAgIHJldHVybiAwOw0KPiA+PiAg
IH0NCj4gPj4gLS0NCj4gPj4gMi4zNC4xDQo=
