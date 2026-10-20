Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5986606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sCFqTn6/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 623BF10E14E;
	Tue, 20 Oct 2026 17:22:38 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012031.outbound.protection.outlook.com
 [40.107.200.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC18A10E14E
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 17:22:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipb2lkFMEwKPBOIP6SBXy64VPxnZ6CSgHOiyegqK8vOUfgdxAW2cHDw9Ml4oPRryTbZ6QPKrit8vgoyLe3wvtuEr5p1kmfDxXkTv78pAX2KfY2s9Rzx0kjssNMNmH9h+thWjctdz+3ji36zCoa4fsSNwf1DmNFSXVBuR1NBdHnk2eq8X/6TMk6wmIsXlJJqr8nmmQ3HBxp5cRAkqq/1hEAY1UWdS/c++ESeFV7lyjvdJkmEueIqOgTqUtKisdcsQ7Kgk/MNhMquNgIDKkrfAqLm8+RbB6SDc4qh5/obD6AansUfDH+bCeEM7TdcKT5qOAT4hCpMslXLR0MVeOxZTrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZAtsORlF39fFI5XoVWGWUliGhFGOxa9fDBTUBNfoS4=;
 b=lNt0TwlXdCEgsv+UKevTyySXgEYNcxK3mqWxA6Oe7FzXdxGk9zGsTsl+qvbdzNDPkW7XcvFYCdA5pcVoAP4JqkJbnDzcHtCDezu5OPjsAGIR1OpX2eHnC0BYhKqdsqnAp4BSBbc4DEe/FNDNwOiqnY31T64cYnU9D3EPzvtvzB0YA9rFZWbIVUnqcJQcTu4Fj9xO3LxMXtmxSSwPBasfGy/IqTyxK+mC+sactCVuVRsKuX5ZK4WiRHRT6glmyRuN6+7jvWra3Ibcjt0lO0Xty55ORgfUsnJb9vCRB2LyFFL/OHCVkj/QDHg7j4fdMGUsq8LTz1z3Qjc0FKdGFJ1+bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZAtsORlF39fFI5XoVWGWUliGhFGOxa9fDBTUBNfoS4=;
 b=sCFqTn6/QjHRbbgVX5h4AM9JBVvxBvBpo+ovVTsuR8hj3fzHLrunbdHbfj7SEV3ST9jKLcmf7esPrfyJyt+5W/c2ADUDOlC46Iq1Ghwg9rhAHtW/TdFI+E12lquH+I2mjYhYBSoO+xpxVDsXp+kPR+mCxVHXbZ05EdLBeezDV+w=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15; Tue, 20 Oct 2026 17:22:27 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::3415:a566:2464:83f8]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::3415:a566:2464:83f8%7]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 17:22:27 +0000
From: "Gill, Harkirat (Harry)" <Harkirat.Gill@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: re-enable GFXOFF for compute on GFX12
Thread-Topic: [PATCH] drm/amdgpu: re-enable GFXOFF for compute on GFX12
Thread-Index: AQHdYKyxt4BQ+MOa6UqExSfmyDxJ3LcGmnAAgAASvVA=
Date: Tue, 20 Oct 2026 17:22:27 +0000
Message-ID: <DM4PR12MB5165DEE300531C7225770574E3672@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20261020160316.2411569-1-harkirat.gill@amd.com>
 <CADnq5_NQst-5DeGcNpEV=s4Lsc7QKyq1Dtx3VMWPYCJig4qJfw@mail.gmail.com>
In-Reply-To: <CADnq5_NQst-5DeGcNpEV=s4Lsc7QKyq1Dtx3VMWPYCJig4qJfw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-20T17:20:11.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-bromium-msgid: fa4cf324-ba36-4202-b1e5-bab59c6e0982
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|LV2PR12MB5846:EE_
x-ms-office365-filtering-correlation-id: 93a38df2-6825-4a23-0c86-08df2eceb6a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|4143699003|11063799006|261009223027099003|10067099003|38070700021|56012099006;
x-microsoft-antispam-message-info: tfeWRtpM9ow8jMChR3VyX8L4udrqmbxQS78KQ/kerM7VdqgBIcOyW6yKmJR6lOWzNJCMc3hh2tnPaxMKsX/1PzbohDKc65ncpVYi5tI/OsQsO92ayqa/X5MnUzYlA6QtlO+uIITqnKX83b/OVSs7n+BDR5Qqn++w35nRKhboGebgbRNzqkC3q6CDtztOAkY3b39nbtw0GxMrG6lBWKs7LnlTgV157P/dzbg64Hrs0QNdchONlN98/BPvc6mYonuapr8jAmOFPFa2r7wEVF4fdd2Cyk9uey1iTDZ78rNu7QIa3+hIuwhFWSnBX/Sdx9qJyIK2eTbG4aOMV9lEfU7wfWhFZLR+0m9eU9rZ8bMtNK4YaAIQMorhXRH8yh2zWNtfiUV5mVvcIjaLp4ObJzj6Ccg9b0NNYyl/nFd2uvApPI4xcI2Fw21Lra7XxOMnRtu9jxtMk/BVp9ClXZ1A1nDHHnTu3NJj9eq2NS5EnN33tQIA10XGMbaVnkJxvmhnIhOoBS4P0UdKj9RjX2oZ8ECIXTXNVIRbAqGjl+3DQ3F4HZVJ3TeoUKngEXLZqC+BrtpU7Nx0u0g0J8uP6iPCn+DG/MQp27o7626JuhhNzr4N2zEMPqPr2wq+MCIk76qP4f7JHN9f7KW2SgRPMiwwUYnDXkP/J9nb+fQ4f8bVfUsCGwAWT7B58cTNOIM3rwqVkBgGHfhqPEPX62i8hsvWis5L9mtwkcEUq1oQDJp9aJpJVV8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(261009223027099003)(10067099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDQ4cGI3L2VEZjlaRTZsSFVYc2UwejVOMGpCb0tza2JlcnNnZ1YzeENVQXMv?=
 =?utf-8?B?WWZ2WWcyaEptUytMTklnTDF5OUpOMkdOUFpEaVViOHFHekhPTjVadWJxU1JS?=
 =?utf-8?B?a0ZyTU9DRXdNQlNpWm5LdzBPajJBcno1L0JsZzBWTTNFOTFPQTRIbnFjWGNY?=
 =?utf-8?B?RXlHRkVpNEh2bzduM3YyZlVwci9MQnQwRUFROGVQdDBJUkJicm9kRXZ1NWhB?=
 =?utf-8?B?a0hyenFlTHN4ZzlFYmx4cGNzWk5wYjg0Y1N5TXNPK1dkeXk5KzNnV1NoZFU0?=
 =?utf-8?B?R0lMOXFIMTZiTjc5UjMyWG85L0k3bzFYYUxvUjF6V3lwbkJ1dlJIVEZFU0JT?=
 =?utf-8?B?UUlzcW5XZDROL3lnYkJLdHRUYVkxS3U5MmNMT0Z5cGQ1Z1ltZEF3VVAvY3Jr?=
 =?utf-8?B?WkpIV01GaVZQUnhWOW0xTmRXL2JwaWlnTFJ3N3gwMHhPQThDeFBwZGk4eDNl?=
 =?utf-8?B?ckNFa1F3WVBobVcydVR3Q2lkd1pQQU9sYm1Ga3ZPbmJBMFZhZFFPNXFJUHlD?=
 =?utf-8?B?VE9FK2JLUWx2NkNZNWJwcXB3bzJUK0xqb0R4SkpXNDJRbW1zV1BNaC9Wcjg2?=
 =?utf-8?B?emFLcklHR1FROHl3bjZXaGprL3RqRnJzTndjTTd2TG9RV2NpVzhZMU40N0hD?=
 =?utf-8?B?TmZVR0o0V2ZESTY1WjIyZUYzMGJGaWlOcUo0aFhFSTlmbEhnMFFEc0lIZGpH?=
 =?utf-8?B?RGJlRjM4a1pTM0l6WVpOSnd4SG9HV1E5MFNOb1hXS3p1V09FQlBHeGc5RHhC?=
 =?utf-8?B?c1B0TmdiYWZneDJoclhGZVJmWHlVVjRQbzg4K2FqOG5xNHZLei9JMlpvUHdz?=
 =?utf-8?B?M1VyeGlQaTlOZTg4SlEydTdzWlBMaWxCdTcvL1gzTjJlSlpYbk91cnJ0c1dR?=
 =?utf-8?B?ZXZwMmw4a0hYZFA0Y0V0TGp4T2Rrd1BWakJMRHJIUVM3bk1GWUNVV2I4eGds?=
 =?utf-8?B?bllodWE5YXZDS0g0aWNkMytYaHRhRFFidG1NVHhhVFFVUXErZ0JYdUlxQ3Iv?=
 =?utf-8?B?c2FNSU5kRDI2NFlieWExV2hxalFkQXMwN0VFZHNCS3dmNEVxWllUYXRUVTk2?=
 =?utf-8?B?WlZXdEtPSVpvV2I2UXFkeWdXbXk2dDduckR6dWxRMUZSV05aa1EzK0MxZWdp?=
 =?utf-8?B?ME40dFBtK1czWEUvUVhTUkRCRUhkNTMxc0I3MUttbXBzSUZkdTcvRHpKUndp?=
 =?utf-8?B?dnE1bnVzbFpydXFWK3RzRTZJMFQ0anNYUlBiTlArYlVBMit3TGRPZGdmSW05?=
 =?utf-8?B?TjVDajhiQWlHeUJwRG9DczcvVnpoTGcyaHdzbmIzOXR6cEZldjdaalhTRm94?=
 =?utf-8?B?citYbGY0Sk5uK1JNL0cvdDhJVlpKbUxCcXZWTUpRN2NNaWlza1BlUFphbHk2?=
 =?utf-8?B?cnNZNjAvNW5zNE80M2dqM3NoQmdmazZpcWdWeE5FU0c3bHhBc3EyU1ZHYkZs?=
 =?utf-8?B?bjVxVStEMHE2VWFObmNGT0FsOEFpQVNpRnh5VmpPV1dkTmlOS3lkdlRhR2V5?=
 =?utf-8?B?bk1DQkt1Sk50NDRwRVNpbThoWXRObkNTZVBDdHZKMlNHUk5JdjZGbUJiQm11?=
 =?utf-8?B?eTEyWk1OaHNKSy9HYTRqczhsbzlpMERMaXdJbm00YjB4dUpLVkRVMGtCREdv?=
 =?utf-8?B?OE1rSVBhNXp6ZmppNnM5aXY5WFA0Z3NvSmwweERZQTRHaTFYNTdiUWNFRzVy?=
 =?utf-8?B?cXRMMjRtVjY5eWJEc3Y1d3loQzZ6Q24yTXBnc09uYzcyL0hFTEJ2TTQzRlYv?=
 =?utf-8?B?YnpLcUhKbG8yemxiUXBpUUYxektUY2kza1ZnZEQyZmQzQnZhRzJnTkdoSEF4?=
 =?utf-8?B?K0ZIeEp5OUcwRldpbE1ZZEhUbUxBRFFudHJHVFVEN1VuZDE5QmxPSGtzc2pz?=
 =?utf-8?B?YWxmUWFZZUVEMzVObWRFVkJRRUg1dDhva0RBTVJ4WGRiYVlJRCtiT3hoL2pm?=
 =?utf-8?B?dkp2V3l6cEZXSFhCdFRhMmJSYTNKYzNLVkdwbGl0a0h2aVlscFI2VFExYVdU?=
 =?utf-8?B?c3NqM29CVGpBODdHNnFDcHdBVU83Qlc1NVpYRGo0ZmQzc21wdEs1cFh1TFBy?=
 =?utf-8?B?V1p5WlM1WGtsdEZBWUEyRUpCRnI3NTE1d2liUjdwd2c1eVRCQWxhZGRqMUlz?=
 =?utf-8?B?bU5ZalNraDROd3hLQllaYnhkbmNvRmNXM1VHQTFTczJPM0RLNnRKaUh1Y0N1?=
 =?utf-8?B?bnRtSG1hNWNaY2xaaXRKN1JGTzNnbjhiYUtBY2c2L2JzZlBiVy9wRUs5Y1Ji?=
 =?utf-8?B?ZWt4VlRHVjdQVEhrSkVOSitQVko4VlpNNTVvOVU3L3c5UmdpTkdVNDB6Nlov?=
 =?utf-8?Q?/VJdRyoSN6C9VPCL3E?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a38df2-6825-4a23-0c86-08df2eceb6a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 17:22:27.2252 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c+Rjhyx4H7acOUwvf7eUrOY1Rcyog6OnSMekxrSOO8uvvzff8tEwh5x4U77dv0xGuvHxu5XLgtJAhWilKeOeLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QU1EIEdlbmVyYWwNCg0KPiA+IENvbW1pdCAyYWZmZTJiYmM5OTcgKCJkcm0vYW1kZ3B1OiBkaXNh
YmxlIGdmeG9mZiB3aXRoIHRoZSBjb21wdXRlDQo+ID4gd29ya2xvYWQgb24gZ2Z4MTIiKSBkaXNh
YmxlZCBHRlhPRkYgd2hlbmV2ZXIgYSB1c2VyLW1vZGUgY29tcHV0ZSBxdWV1ZQ0KPiA+IGV4aXN0
cywgYXMgYSB3b3JrYXJvdW5kIGZvciBhbiBPcGVuQ0wgdGVzdCBmYWlsdXJlLiBUaGUgTUVTIGZp
cm13YXJlDQo+ID4gaXNzdWUgYmVoaW5kIHRoYXQgZmFpbHVyZSBoYXMgc2luY2UgYmVlbiBhZGRy
ZXNzZWQsIHNvIHRoZSB3b3JrYXJvdW5kDQo+ID4gaXMgbm8gbG9uZ2VyIHJlcXVpcmVkLg0KPg0K
PiBEbyB5b3Uga25vdyB3aGF0IGZpcm13YXJlIHZlcnNpb24gdGhpcyB3YXMgZml4ZWQgaW4/ICBJ
dCB3b3VsZCBiZSBiZXR0ZXIgdG8gYWRkDQo+IHRoZSBmaXJtd2FyZSB2ZXJzaW9uIGNoZWNrIGxp
a2Ugd2FzIGRvbmUgZm9yIGdmeDExLg0KPg0KPiBBbGV4DQo+DQoNCkRvbid0IGhhdmUgdGhlIHNw
ZWNpZmljIGZ3IHZlcnNpb24gdGhpcyB3YXMgZml4ZWQgaW4uIEtlbm5ldGggbWVudGlvbmVkIGl0
IHdhcyByZXNvbHZlZCBpbiBhIHZlcnkgZWFybHkgdmVyc2lvbiBkdXJpbmcgYnJpbmd1cCBzbyB0
aGUgTUVTIHZlcnNpb24gY2hlY2sgd2Fzbid0IG5lY2Vzc2FyeS4NCg0KSGFycnkNCg0KPiA+DQo+
ID4gV2l0aG91dCB0aGlzIGNoYW5nZSwgaWRsZSBpbmZlcmVuY2Ugc2VydmVycyB0aGF0IGhvbGQg
YSBjb250ZXh0IGZvcg0KPiA+IGhvdXJzIG5ldmVyIGxldCB0aGUgZ3JhcGhpY3MgYmxvY2sgcG93
ZXIgZG93biwgY29zdGluZyByb3VnaGx5IDMtNCUNCj4gPiByZXBvcnRlZCBHUFUgYWN0aXZpdHkg
YW5kIH4zIFcgcGVyIEdQVSBhdCBpZGxlLg0KPiA+DQo+ID4gTWVhc3VyZWQgb24gZ2Z4MTIwMCB3
aXRoIGFuIGlkbGUgSElQIHByb2Nlc3MgaG9sZGluZyBvbmUgc3RyZWFtIGFuZA0KPiA+IHR3byBy
ZXNpZGVudCBLRkQgcXVldWVzOg0KPiA+DQo+ID4gICBiZWZvcmU6ICBWRERHRlggNjk1IG1WLCBH
UFUgbG9hZCAyJSwgfjktMTAgVw0KPiA+ICAgYWZ0ZXI6ICAgVkRER0ZYICAzNSBtViwgR1BVIGxv
YWQgMCUsIH44IFcgKGlkbGUgYmFzZWxpbmUpDQo+ID4NCj4gPiBUaGUgcmVzaWRlbnQgcXVldWUg
Y291bnQgaXMgdW5jaGFuZ2VkIGluIGJvdGggY2FzZXM7IG9ubHkgR0ZYT0ZGDQo+ID4gYXZhaWxh
YmlsaXR5IGRpZmZlcnMuIFRoZSBvY2x0c3QgcnVudGltZSBzdWl0ZSAoNDAgdGVzdHMpIHBhc3Nl
cyB3aXRoDQo+ID4gYW5kIHdpdGhvdXQgdGhpcyBjaGFuZ2UuDQo+ID4NCj4gPiBGaXhlczogMmFm
ZmUyYmJjOTk3ICgiZHJtL2FtZGdwdTogZGlzYWJsZSBnZnhvZmYgd2l0aCB0aGUgY29tcHV0ZQ0K
PiA+IHdvcmtsb2FkIG9uIGdmeDEyIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYXJraXJhdCBHaWxs
IDxoYXJraXJhdC5naWxsQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYyB8IDUgKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMNCj4gPiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYw0KPiA+IGluZGV4IDEyMTI4MmRkMzBj
MS4uMzQ1NzNjZWYzMzkzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9hbWRrZmQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hbWRrZmQuYw0KPiA+IEBAIC03NDYsOSArNzQ2LDggQEAgaW50IGFtZGdwdV9hbWRr
ZmRfc3VibWl0X2liKHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlDQo+ID4gKmFkZXYsICB2b2lkIGFt
ZGdwdV9hbWRrZmRfc2V0X2NvbXB1dGVfaWRsZShzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiA+ICph
ZGV2LCBib29sIGlkbGUpICB7DQo+ID4gICAgICAgICBlbnVtIGFtZF9wb3dlcmdhdGluZ19zdGF0
ZSBzdGF0ZSA9IGlkbGUgPyBBTURfUEdfU1RBVEVfR0FURSA6DQo+IEFNRF9QR19TVEFURV9VTkdB
VEU7DQo+ID4gLSAgICAgICBpZiAoKElQX1ZFUlNJT05fTUFKKGFtZGdwdV9pcF92ZXJzaW9uKGFk
ZXYsIEdDX0hXSVAsIDApKSA9PSAxMSAmJg0KPiA+IC0gICAgICAgICAgICgoYWRldi0+bWVzLmtp
cV92ZXJzaW9uICYgQU1ER1BVX01FU19WRVJTSU9OX01BU0spIDw9IDY0KSkgfHwNCj4gPiAtICAg
ICAgICAgICAgICAgKElQX1ZFUlNJT05fTUFKKGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYsIEdDX0hX
SVAsIDApKSA9PSAxMikpIHsNCj4gPiArICAgICAgIGlmIChJUF9WRVJTSU9OX01BSihhbWRncHVf
aXBfdmVyc2lvbihhZGV2LCBHQ19IV0lQLCAwKSkgPT0gMTEgJiYNCj4gPiArICAgICAgICAgICAo
KGFkZXYtPm1lcy5raXFfdmVyc2lvbiAmIEFNREdQVV9NRVNfVkVSU0lPTl9NQVNLKSA8PSA2NCkp
DQo+ID4gKyB7DQo+ID4gICAgICAgICAgICAgICAgIHByX2RlYnVnKCJHRlhPRkYgaXMgJXNcbiIs
IGlkbGUgPyAiZW5hYmxlZCIgOiAiZGlzYWJsZWQiKTsNCj4gPiAgICAgICAgICAgICAgICAgYW1k
Z3B1X2dmeF9vZmZfY3RybChhZGV2LCBpZGxlKTsNCj4gPiAgICAgICAgIH0gZWxzZSBpZiAoKElQ
X1ZFUlNJT05fTUFKKGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYsIEdDX0hXSVAsDQo+ID4gMCkpID09
IDkpICYmDQo+ID4gLS0NCj4gPiAyLjQzLjANCj4gPg0K
