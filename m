Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7536606A32E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JuFz18H+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B0C211263A;
	Fri, 13 Nov 2026 15:12:58 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012013.outbound.protection.outlook.com [40.107.209.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45E1B11263C
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 15:12:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcMXCvUcAl5uE9mos407v9RALUjdVBkIrGnQnzaBGNQdHFaEeCGsTso5eX59czvR/pW5ccCrneEzZa71q538nool2TIsfiMlVBoWKHrwURyNPCBDildDw9iYkiPAZ4hZB3qPVnQsVSmT9hRDBWleeRBnovilcehCBXiEvBwGuT8oNpdI7j+dpdC9twaKBEVAiAUQHMhiOraxFVrcxTs0vzUUTPLe0fCG3ebmBz4kyeLYnBuYph/RYpXWH8bPUwUq0HfLjJmjmx6C2nm9+ofKLv106ObGNgLupMZ3nwX8bTOEuRIrwY0KiAYgt8W6k159jHL5+BTWZX417uYht1D1Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvkDNIblvTPEoPO4w1tamoL5eNEmCYjcEyyzmld55Vo=;
 b=RP5KeqCmsmNHU7PGthlhtgM5ISVwh/jXbmS/5ka+P/0VYFDfdBmyEL0Nj145ZcnGee0N0vC1v+mVXjHn7yFKk8dojhVjKhVCLRab1V93Po4CJ39lDxrESC1+97b9w9lC9oeBgWKZmIGs8QuLcpJdFNYnNLJSBKy6ynWQt5rIaersq6xpZSqla7hojgztsKU3K7n+z5xlIILE1dPiTA+OX3znsKKGe0kn5Ofx9PyYberCEMSW8ztJuMgrRfP+YHOZsn6LHny7zDHRxmlUIJEqW1XhwrEMpNh8br/DgWWZ3Dy5DrnBt5UB7AOtw6C5IkEIzj5XZPKfRZ7lP+GAIpijgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvkDNIblvTPEoPO4w1tamoL5eNEmCYjcEyyzmld55Vo=;
 b=JuFz18H+afI9h/6+NlEc1a3Di7geVcvGrYHH8Fy5oRLFBRgvA1CwBvEnJoyaAkmSPxdWWjI/T+GEtpfH1ELVu9YbOeTOry+SfmO3NMnscOr0Zv5zzRVh5djQWV7tUrKo62xr8f70cTzdhe0O+C7bR5VKTaBM9VkrWCQZw6PskSc=
Received: from IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15)
 by PH7PR12MB8039.namprd12.prod.outlook.com (2603:10b6:510:26a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 15:12:48 +0000
Received: from IA0PR12MB7505.namprd12.prod.outlook.com
 ([fe80::9012:fd0b:696:a346]) by IA0PR12MB7505.namprd12.prod.outlook.com
 ([fe80::9012:fd0b:696:a346%6]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 15:12:46 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Ba, Gang" <Gang.Ba@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: Fix fault shader cleaner on MI3
Thread-Topic: [PATCH 2/3] drm/amdgpu: Fix fault shader cleaner on MI3
Thread-Index: AQHdcqvhHq31DD74RkGxzPJattqdIrcsG2eAgAACDYA=
Date: Fri, 13 Nov 2026 15:12:46 +0000
Message-ID: <IA0PR12MB750526D3588C682E4F779990857F2@IA0PR12MB7505.namprd12.prod.outlook.com>
References: <20261112134340.4122401-1-kent.russell@amd.com>
 <20261112134340.4122401-2-kent.russell@amd.com>
 <ab2113a4-3db7-457a-98b4-a989e5ddbf46@amd.com>
In-Reply-To: <ab2113a4-3db7-457a-98b4-a989e5ddbf46@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-13T15:12:28.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7505:EE_|PH7PR12MB8039:EE_
x-ms-office365-filtering-correlation-id: 203d790b-c754-4cc0-9987-08df419892ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|56012099006|4143699003|11063799006|261009223027099003|261021121427099003|261026121527099003|261102123227099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: Ri6YJ7W7TNgT2B23qBJ4pu5loIZKnZNzwH+JEo6uh+A8I57w+B8M0/dLo5ZHC2GoOg38v4jnDg0TOR5XSanwlGAkwjLvEftX2PnpJy/N8rqh3+zST86tq3Wuy6ZkXSGsNFSXdMUe8HcW0fGB9sb44xtCMjlcx7VXb0HEzIvdIvVg8XOXLD0teCF6/QpxpBuj3tUCNroP8BaIsu2gXLz/qYIBqfmz0AZXGQV7iGEHah67NKb32+hrc6BAf8XO+cV/cV/hmwa4K2fRb/eGyh0QuafjJeltMo1o15vDI5cUetwU5YH3SuPK04md9frq/8vGMzIEkb/Iim01Vds3+6zQbsycTPTz+qrNM+uc3oJ5gNK4irx9VUOpiNy7axGmPNGCMrvAizejKVOXHr4h5bX4GcQLe/y3Ca9SaR/Q+vQ6XvQ6ng2bi97I83qEjnVHPj4L9IqkfeJfXsSK64UABFQzlkclmN9twQNpGOkNhvVMgYyZ7C8+10w9IQC9AlEkV9QB3ZVCIP1Uz6khIz1AQQt4MIqIgKnhmGlyMD6MgY/PwNsi5cFEq4gl/V0R5twoh1GnTwDJeyicLrg3T2RUkq2Uwk9lYzN60YtL0fFdnKFMdU7GufbCi17UVCP+W+pPxoeuVycsSOZIt3dNGtl8kbXUYlg2571+DWKdJBgtABzERVNqOr/AoYvpfI+ebJ9gZlgf8KSGdafqTxsdK1b+OX7It54Ch5ZOvhkr950Nge6FcKs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7505.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(56012099006)(4143699003)(11063799006)(261009223027099003)(261021121427099003)(261026121527099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzhmemdGcVNONWtuam40UG1WOHhRMXV3MGZtc1hQa2IxUlZhMUNTZUYrZHUw?=
 =?utf-8?B?ZGpjNFNXb2pHTDljOEJvMWtJZnpZY1BYUUZWRFFxV29pQnNXSTRUOHBQRXJl?=
 =?utf-8?B?U2ZLck93NksreElYMVhIK0tmdVhaeWtkRlI0L1hnenBmLzk1aURLQ3BLT2Jk?=
 =?utf-8?B?QlRybURWdFoyRzNTcmhwMElHK2lqbFFrZjlxZTJyRkNqbUlMM2ZjT09iYXRM?=
 =?utf-8?B?c1pUTzZzdWh0SDBleHovdlYrcVUzdk9nZTJBT1FPejMzTWdXdjQ1RXdRM1ZZ?=
 =?utf-8?B?QmdYbXNuMEVjR2hJcXRJSlpnSk14OU8wbzNubksyR05ZN3Z1MzZzMERuTXJD?=
 =?utf-8?B?OUpGamI1RVRIWnl5LzY0ME5LL2NCMVd3TEIxdElTQVJHRDBTaHhMbGlTemZv?=
 =?utf-8?B?am43L2s4WFFoVEJkQkxlaWxrVmdsV1pqS21TeDVnbnFxeGk4eXdrL09YWGhZ?=
 =?utf-8?B?dUswWGU2N3RmeGJyRzVmaUZIK3RqY29UcXVEczhnUUxmakNiV3hSU1oycFh4?=
 =?utf-8?B?SEJaWGpDNU9Ic1Z6THM4N00rK0w5cDlLdzVmbE1zdGdCeTFXckRFdXlwZWlB?=
 =?utf-8?B?NUoxNk5BaGVodXpjQ2hmb1E1TjcwR29zVklEcWsrSCtMQ1Bwd2FPV2xROWVm?=
 =?utf-8?B?cVBEUE5FajY0bk04VW9HREVFSHByN0svVnN2a2pWdDB1dVFFYklJVVVSVFZQ?=
 =?utf-8?B?VnJOTHVnbjBBNGx3Y01oaU1Gd3JFZmNBcUl2LzRnZnJzZ2lsZ1phSS9Hc0R1?=
 =?utf-8?B?R0h0Zm5vRjNsN0xFbXBSUjJzcGFLemRmSzZPa0h0MHZBcmRNWUM3b2NUdTJp?=
 =?utf-8?B?Skc0bU5XUjZqUFZhR1h1UmJpSUhrOVk1akxCMjRBSFVPWU12TGFFYTVBR1g5?=
 =?utf-8?B?d1ptVDRSUXJRY0Q0SkpjdFpzLzQxbzBaYW00dGtNL1dDZlovOGgwenY5K2VO?=
 =?utf-8?B?STZnRVpKR3prMXJuSjFOd25VUlRJOFdscWRzelA0bVJNUmFRSXFYOTY2NDl4?=
 =?utf-8?B?N29LNzcrUE5rQStpWUtrM1dyT2pxNlN6L1dhL05Ed0FaUGIyRjlnQ2c1Vmgz?=
 =?utf-8?B?eHBjamRxN1NyOCtpUlh2R04vREZkZ05iMGdBTnUyaWdrRlFGNCt3RFM0QVJs?=
 =?utf-8?B?cTc0YUhUdWFuN1VHcXBaRUJTN05sY3lqSytOTzZDbXYwWlBnUHZhc3JSa1E4?=
 =?utf-8?B?S2NncWZZNWNzQ01ra1hJTnoyRVdFSERZQWhWKzBORE53SHhVNnJNRFQ4L05k?=
 =?utf-8?B?d2FFeTFjQ3BLdkVmQUpRYlQ2cnlmVlNYQ0I5bUU2dEVVc1NjdDVLenBTMmVL?=
 =?utf-8?B?ZDU1RmdBWEhwZ21uSVpEY1RwKzFHL1hWY2ZvRXZDYlRwM1BYVzJaRk1oVXdu?=
 =?utf-8?B?Z2o1Skt0R2p0WmNMSzlkRFo2bmlUVG45NmJQQ0sra2d6TzVNUWhxZUtNaGJU?=
 =?utf-8?B?YnlVYW0vR2xSZDdOVjNMZUhxNnR6M3dEQk1PM2pzTDNmYWovUmJ5SjUwZUlr?=
 =?utf-8?B?UXdIeURJcHA0M1NCdFdtREpDZFhsOWtjSnBiZDJLbUd2aGttbXZVbWJGeHl3?=
 =?utf-8?B?dzBEbmM1Y2prMTgyWnFKOTZWbFIveWI1TU9RTlo2MHJaM0JyajhoTzYvcUhu?=
 =?utf-8?B?elFOT3dpQ1dPdUtKNGxRVTJ4UzBLVndVQXZrdUxiM2d6ckgvbWNKL2NhdkVK?=
 =?utf-8?B?bGdWY3JmcnovR1E3bWJ2cTYxSkV3UEE4UUlxRUY1M0t0dVN4dUlyNno1N0VE?=
 =?utf-8?B?NklGOFRaQXdXeDA5bXpyYmJsM2JkWUhHMkpPUVJRQ2c4SlhRejY0WUpIeVd2?=
 =?utf-8?B?b000K2U5SkJQT2thSnBlSTA3UFp3cUdVNXJweDZRR0R2aEF2dnh5WXNjcDBi?=
 =?utf-8?B?T29vUysvMW1nZWx1aXZXMStEVHkwNjQzWkxXano5RWpWd3VndTZ5NjBHNm5y?=
 =?utf-8?B?NVk4Y0VaYWdURU55aUZuK2JuVDl3NjNwdnB3Wk04OHF0N24zMzltL3M0bFhC?=
 =?utf-8?B?RmxacU5WYlBmemMzdnNNeU0wd1p6L2MwTEw4NTJINW5PTlVXTVltQXlmNTEv?=
 =?utf-8?B?WEFDZ2xQMm5RQnZVamErTTVkWEFvYnZQWmFnMFcyaHRsQUthei8rb3NRTm0v?=
 =?utf-8?B?QVRTcm9ncGhDYmRUQWtibmYxQ3JYeDF4VU1EdUYyZkZnNmQwdXo2c2JmN0JO?=
 =?utf-8?B?cG1LQWdzNFFVdjZQZGg3djNzajVVOHJrS1M1S2VSWDIzRm8yM015d1p0Vzhq?=
 =?utf-8?B?TU55QStEa014VEx0bnBwOEkwRlpiK1lJZ3RESVdIOUNmZi9pbUozUTE4elJ6?=
 =?utf-8?Q?1xlPFG9opnyj7+ELUO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203d790b-c754-4cc0-9987-08df419892ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 15:12:46.5300 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XOKSlTD2bOhZj2P4FWEsXW98JJpxdbY7EKfWJPMi2byfiSaol+uAgPm04OvHvbuVO3Wuyq/9wXshvzegFFLnCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8039
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDb3Ju
d2FsbCwgSmF5IDxKYXkuQ29ybndhbGxAYW1kLmNvbT4NCj4gU2VudDogTm92ZW1iZXIgMTMsIDIw
MjYgMTA6MDUgQU0NCj4gVG86IFJ1c3NlbGwsIEtlbnQgPEtlbnQuUnVzc2VsbEBhbWQuY29tPjsg
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IEJhLCBHYW5nIDxHYW5nLkJhQGFt
ZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zXSBkcm0vYW1kZ3B1OiBGaXggZmF1bHQg
c2hhZGVyIGNsZWFuZXIgb24gTUkzDQo+DQo+IE9uIDExLzEyLzIwMjYgMDc6NDMsIEtlbnQgUnVz
c2VsbCB3cm90ZToNCj4NCj4gPiArI2RlZmluZSBHRlhfVjlfNF8zX0ZBVUxUX0NMRUFORVJfSU5J
VF9SRUdTX1NJWkUgMTENCj4NCj4gRXhwb3NlIHRoaXMgYXMgYSB2YXJpYWJsZSBjb21wdXRlZCB3
aXRoIEFSUkFZX1NJWkUgc28gaXQncyBrZXB0IGluIHN5bmMNCj4gd2l0aCB0aGUgYXJyYXkuDQoN
CldpbGwgZG8uIFRoYW5rcyENCg0KIEtlbnQNCg==
