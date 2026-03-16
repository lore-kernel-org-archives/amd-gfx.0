Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9B9EFCBC4
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 06:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55EB010E2CA;
	Mon, 16 Mar 2026 06:55:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uVrv7ohL";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011011.outbound.protection.outlook.com
 [40.93.194.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBC0A10E2CA
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 06:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ci0c1c8b6riNe2Hoez1n1a1mOYBkzi6Z0zHHzYFUH7gGDX0h1yY6M8F2cX1rNrNNgcF2YhmwD068DQ9EKvd4VLrf+3/Y0QxEzOhR772nQxLTRrQk26GzUz25uE2m2VqsBt7CiYUuAD9G5/aYITCmyEmBGrEAtmxb3xDW52wvqwDHxOP6Odh6t1rtFcr0bcV2HgtxUDBkB9CaRE5wi82IswtKfeE/ZSw6znVG+m2+CZ98G583ho8Ah6WIaAStQ8757TRgnfqe6n6i9StoZQYofjwKQ5Ablid68lEnrPzrim0CSpySH1WHm6DnMd9f+vlUBlwNfCY+Fw57CQdcmDQclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbM+zQ+SXTyPJN1lVXRRnGZr/DCE3eKwgOBuoKfOgHs=;
 b=leSICCBPHkgNEDHgqve9iAdOqbcUeBiChsNMMY5S6u3Uh/dvJnMoUxWxfPO18RcixTNYW7lggiRrgHwhhxl8nrCIqzwgPMvw28EELdhbR4mwxd1jqCAXwxoARzoadNMfC/b4FBeWWONeFPdwPHQGBGXqs8B15MX5V2nGz7SRb4+USzrCJ+DJ2CSiCcCOVQvFDV2vc5b187PPuFSTXowXwk5nlbZkiDB4OrEd1uHY1IOa0WC0ZQNEqw51NJhIekIiS/MWMNi2KORfoKem63S0JHBaQjtdhUQ/fddm58/VY4n6umudZS2Uh095XV/WgYMwIc7n5+oMwtGbIbzuAmMLlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbM+zQ+SXTyPJN1lVXRRnGZr/DCE3eKwgOBuoKfOgHs=;
 b=uVrv7ohLeNbd99CrhiQ6DLxKPrHqA5p/If3M5sVCnMxNrAIDb7BAQE7Qdi7JFJ2rzMzE8XHdTdqzd4N3BoXFCXwiqra5y1V0WYEls9g7I84w3Fn3QUGO3huk2rMSRjRMdwNK7g9XaVvKBKd3sA2ks4YMNJDKQljSA7RjjoaOzBc=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by BN7PPF683A477A9.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Mon, 16 Mar
 2026 06:54:58 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%5]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 06:54:58 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/ras: Remove redundant NULL check in pending
 bad-bank list iteration
Thread-Topic: [PATCH] drm/amd/ras: Remove redundant NULL check in pending
 bad-bank list iteration
Thread-Index: AQHctESKkGo8R4iZ5kOIOd9cDj0nBbWwuwFA
Date: Mon, 16 Mar 2026 06:54:57 +0000
Message-ID: <BN9PR12MB53064A32154AA86AB843C2B8FC40A@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20260315062509.1931432-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260315062509.1931432-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-16T06:54:44.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|BN7PPF683A477A9:EE_
x-ms-office365-filtering-correlation-id: 0352d018-aeda-473d-0b41-08de8328eff9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003|7053199007|38070700021;
x-microsoft-antispam-message-info: eP258U7FJYY/ENknppg0R/jQIuf6hx2dEzHQshw3JyhB+0Pib0VZR5/zXP6NOQePDVN8Q2aT1QiPSmhwLGvkgqdnJOCHdQHvy/NSH8A33mXTPESm0Zlkp5f+cbpoDv9CLU0qRdDqqTvN+i4uCw9StAcr8+FV09M8E4o+5zUZ9eQjBQ5hDba6UU3+v/8i8rFtGjxiPw2vqumw/lDMkU+zSoyW7tkMJ8fbspd3oqPO7XDaUERWWaoik5yPjFNRejSwrgtgOpykkxIavL++PJUfMLA6ekgX/lyz2U/CqnZPsmB1pDz5pRtW8oRye0ZhWY2dciUHI6JH9PD+mD/G7dmfat3sLofGZSI7JhmnHssk2euAn1Q5wh3ZkEzxi2vA3U9uqgcBWBQFgodmumFqhZL+L/OgGTSSH19JxinxptDFd6iVnEIvz8syob7N3WYtGpPkhcVv9Ro/O2z4om6eRgYeh2J4IMvomJbvSrntjARORHkjwr9TmKoStMPp36E1a5tXmgPy0oFrrIo8lDTO98oLsLO+2yXmtYYklcDxKtsStLn7ybZ1Q4SveRPn2Uw8I8ITwdx0Mih3eWGIJMQDSiIpUeH5PsmHVERb1w2oKUSvZXcJcX6GnibukHOAxiUIJc1Q5tRHyaRIJeq/pcmUaDxH0R9hH8zzpyHPCSL4ZhhYMTBlVdtvzeUB0QfJbETKoqEttSC3xxcuNa8aa8NlMu9lPPclgmxPWzY/rV9SYVzarWA+CD+BdPTW/y5YUDRoqkye2u9fLz3EDTPNl1Lr/coSLZN+ISUFTCPqUHIrLQNVtCM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUVkUCtPTVNTZGZTTk94b0dnM1phVldhZ3lPMVd6RGtjM3BLOE1wQWlDS1BG?=
 =?utf-8?B?cGZvODhNNnNadkV2WnNldzNCRGxxL3dicGxHN2ZNWnkwdlZGK2JOVCtJWjhv?=
 =?utf-8?B?UFVhbkF4Z0dlTml0MUw2Z0xMNGhpazJOcjJpZ1J4UzM3S2wrYVdEOU02SHJw?=
 =?utf-8?B?Vzl3L0pGQlIwd1VyY0VqdXBBL204bHRnSnA5dWxRNFVDb2dUY0c0WGkrejV0?=
 =?utf-8?B?cWFPQUhnZWhuWC9wMEV0SXdWZzNKS0NsclgyYjFvVG9HTTRyWkI4ZGszdCt6?=
 =?utf-8?B?dFpKWUFHb25jL25BUGdqMTJRRThUYVJLemhhNU9Vbk9zc0hlREk1MUgxZURx?=
 =?utf-8?B?RzdmUXBLYzlaS252WGxnRkNEVUkzdWxuYTh6SHRONXVaaHQ1R0RRQU1haWQw?=
 =?utf-8?B?N2gwaGJ1RnVWYUl1MVk5MVZZNjdZVitHVnczMCtjZ0RSOXUzVVd6Y0UxUUVD?=
 =?utf-8?B?SVNYOTd5MzVDci9FVlBRUXg2Z2NoRS9FQjBHTU01R1FmMXp2bk93WGRqRS9N?=
 =?utf-8?B?V3Y1SGpMUTVQMjk0dWd3Vi80VGs4UUcvLzNhaHdYdm42MXFubEtEbnpEWEs4?=
 =?utf-8?B?NWtVbW0rVGhPbnNCL1hDOHpCTUxhVm03Y1ovZG1JYzR5SC85MkNRMXJkSisr?=
 =?utf-8?B?elNXTEJQQXlSak9ocmdtbGZsMmNvWUFOandkdjM1NU9ISmxhQndOQUZaMnVh?=
 =?utf-8?B?b3VsK1NPQ0pCdlNuUXBFRDhVL3o3dml0UDBQcUtHVlNtUk44T013ZWlJNHRs?=
 =?utf-8?B?VTJYaFBXWmY2MjJIczQ0S040OWlPRlYyRTN2aE1yLy9palZDQXVtNXYwZDdO?=
 =?utf-8?B?SVhkeUdta2JhQ2ttQjVoSVlZWlBPb0Jsb3ViLytKcEdTVXJtSzg0YzdLNFpi?=
 =?utf-8?B?RVM1SGZvd3psc1dxVHRhcklGYWVFbkRicTk1Nmc0S3ZLRWF1NU5IZTRtbWND?=
 =?utf-8?B?TFBET0NzOUtCV3dua0l6blkrbDcrOGtpeUdnelA1bHVlTVZXS1ZPTWNHS2Fu?=
 =?utf-8?B?NlA4emFvRFlXVWV2YnRKcEpZSk1IWDlCUGxaL1NVVHVUZVlOUms3UVJqc0Vj?=
 =?utf-8?B?ZWE1bTFWa2lFbTdpK1NwUHpEa3dwZXpBRXA3RW5MdDRYQ2c2YXV6bU1uNEdW?=
 =?utf-8?B?UzIzenNQbElqbmZEN3pPM21GNndvQ1Vpa1NjbmNQQXVVc2tpemZ2ZmJqYUZH?=
 =?utf-8?B?WVBMckpqYTcwTmt3TmpuN0JvcVhtaEN0d2pQYTVhOWVCbHlUODd5Z0JkNlll?=
 =?utf-8?B?NjJGTTdiQjJSN05GMWRwRUthZFpDL3krYlNGQlFJUWw3M204VkVWTGxrQlV6?=
 =?utf-8?B?VklHcjVaV1pFMnVKSTMvRC9lRjhkcDI0TW5JdGVwQTlBV2tIV3BXeFM0aTYy?=
 =?utf-8?B?YzJsbFcvNWlqMERad2NEbzJ4YWNXaHkranVRdmg5TXRRVzJucnZSQ3YrNmxR?=
 =?utf-8?B?aVdGeThRRmxwRUt4amc5M1FsemdBSGMrMkpoT210QWJiUE1uUWJ6Um1JK0xC?=
 =?utf-8?B?d01QanJORG1TYnQrQXdDeHBQeGNXUWlZanA2ZzhCSGdsNThCanpJMXdsNklS?=
 =?utf-8?B?ckFBbFpUZkRYZ05RRGp6cTI0WjhrNG5zcDQwcmxBQTlzaHB5QWpOTDQ3SlVB?=
 =?utf-8?B?a0F4NyswSHlDSEorZWpLVS9lWnFJT3pWY2toanpKUW02eDNtNy9xSmJtbnJE?=
 =?utf-8?B?L0hBQ0pXNUM2eDFBb2RzM3NrRjR0WVhwLzBmOENiUjRBR1d2cVIxNFRaaE5h?=
 =?utf-8?B?Szh0U05YdnpGaXQ0bTV1bGNkdmE0WlBVcjVodXFuOWkvQ3FUMk85OHdlbmxk?=
 =?utf-8?B?TWtub2J6MWNFU1owN1ZOUnMxbThsQ24wTVRuQ2ptRWVTdWR3WXVBUzdxdkRG?=
 =?utf-8?B?b3RoamZXMjhkdzZuVnJmL3dTMkpuYmtncHVMU1k2NlMzS3YwcUhQWDYzcGNE?=
 =?utf-8?B?dE5HNm9ocFU3ek5VcHlwVnVTcEVtN1R2MGZLTkVWemI1UDlFU29rMzIxMng0?=
 =?utf-8?B?TmlTQTZhTWtKWDhrMWhsaXBpMTJyUkROaHJ6NnlYQmdtTFJzWDdZRDYrVDJo?=
 =?utf-8?B?RFdLQngvNEpSMGxsR3BUNnFoNW9YbTQwN1hGTnpIYTZ4cFEzeTFEcGVtV2Z2?=
 =?utf-8?B?Yk53QjY3TWcrckkwVHkwNFBVS3JxKy95T2R1WFZwaVZBcHlkSDFjM214TEtp?=
 =?utf-8?B?STI0MmR6VkN5Y2E5T3hXRmNHVkxJcW41NmZQKzd3VVJHQ3FiUkdsbXJqNXY5?=
 =?utf-8?B?RWZNcjZFdytCQ015c3NscGJzQVNmL1RDaEloaFNVNGQ0MzRUWkxURjd4R0c0?=
 =?utf-8?Q?qjXeqNKakDnIat4JhU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0352d018-aeda-473d-0b41-08de8328eff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 06:54:58.0750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWI1BOGsZT0yzDD2cbWfUtLUpYHo/kQFZrnm8ewmi1V66fvmDFBFYrfC6UYNflo+3ovWSjBu+gE83oUwPP3GqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF683A477A9
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
Cg0KUmV2aWV3ZWQtYnk6IFlpUGVuZyBDaGFpIDxZaVBlbmcuQ2hhaUBhbWQuY29tPg0KDQpCZXN0
IFJlZ2FyZHMsDQpUaG9tYXMNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTSEFO
TVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQpTZW50OiBT
dW5kYXksIE1hcmNoIDE1LCAyMDI2IDI6MjUgUE0NClRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hy
aXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBTSEFOTVVH
QU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+OyBEYW4gQ2FycGVu
dGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+OyBDaGFpLCBUaG9tYXMgPFlpUGVuZy5DaGFp
QGFtZC5jb20+OyBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5n
IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQvcmFzOiBS
ZW1vdmUgcmVkdW5kYW50IE5VTEwgY2hlY2sgaW4gcGVuZGluZyBiYWQtYmFuayBsaXN0IGl0ZXJh
dGlvbg0KDQpyYXNfdW1jX2xvZ19wZW5kaW5nX2JhZF9iYW5rKCkgd2Fsa3MgdGhyb3VnaCBhIGxp
c3Qgb2YgcGVuZGluZyBFQ0MgYmFkLWJhbmsgZW50cmllcy4gVGhlc2UgZW50cmllcyBhcmUgc2F2
ZWQgd2hlbiBhIGJhZC1iYW5rIGVycm9yIGNhbm5vdCBiZSBwcm9jZXNzZWQgaW1tZWRpYXRlbHks
IGZvciBleGFtcGxlIGR1cmluZyBhIEdQVSByZXNldC4NCg0KTGF0ZXIsIHRoaXMgZnVuY3Rpb24g
aXRlcmF0ZXMgb3ZlciB0aGUgcGVuZGluZyBsaXN0IGFuZCByZXRyaWVzIGxvZ2dpbmcgZWFjaCBi
YWQtYmFuayBlcnJvci4gSWYgbG9nZ2luZyBzdWNjZWVkcywgdGhlIGVudHJ5IGlzIHJlbW92ZWQg
ZnJvbSB0aGUgbGlzdCBhbmQgdGhlIG1lbW9yeSBmb3IgdGhhdCBub2RlIGlzIGZyZWVkLg0KDQpU
aGUgbG9vcCB1c2VzIGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZSgpLCB3aGljaCBhbHJlYWR5IGd1
YXJhbnRlZXMgdGhhdCBlY2Nfbm9kZSBwb2ludHMgdG8gYSB2YWxpZCBsaXN0IGVudHJ5IHdoaWxl
IHRoZSBsb29wIGJvZHkgaXMgZXhlY3V0aW5nLg0KDQpDaGVja2luZyAiZWNjX25vZGUgJiYiIGlu
c2lkZSB0aGUgbG9vcCBpcyB0aGVyZWZvcmUgdW5uZWNlc3NhcnkgYW5kIHJlZHVuZGFudC4NCg0K
Rml4ZXMgdGhlIGJlbG93Og0KZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcmFzL3Jhc2Nv
cmUvcmFzX3VtYy5jOjIyNSByYXNfdW1jX2xvZ19wZW5kaW5nX2JhZF9iYW5rKCkgd2FybjogdmFy
aWFibGUgZGVyZWZlcmVuY2VkIGJlZm9yZSBjaGVjayAnZWNjX25vZGUnIChzZWUgbGluZSAyMjMp
DQoNCkZpeGVzOiA3YTNmOWMwOTkyYzQgKCJkcm0vYW1kL3JhczogQWRkIHVtYyBjb21tb24gcmFz
IGZ1bmN0aW9ucyIpDQpDYzogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3Jn
Pg0KQ2M6IFlpUGVuZyBDaGFpIDxZaVBlbmcuQ2hhaUBhbWQuY29tPg0KQ2M6IFRhbyBaaG91IDx0
YW8uemhvdTFAYW1kLmNvbT4NCkNjOiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5j
b20+DQpDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KQ2M6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NClNpZ25lZC1vZmYtYnk6
IFNyaW5pdmFzYW4gU2hhbm11Z2FtIDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPg0KLS0t
DQogZHJpdmVycy9ncHUvZHJtL2FtZC9yYXMvcmFzY29yZS9yYXNfdW1jLmMgfCAyICstDQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Jhcy9yYXNjb3JlL3Jhc191bWMuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcmFzL3Jhc2NvcmUvcmFzX3VtYy5jDQppbmRleCA2MDc0ODA3ZWY2YjcuLmQ0MDcy
MzUwZjQ4ZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcmFzL3Jhc2NvcmUvcmFz
X3VtYy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Jhcy9yYXNjb3JlL3Jhc191bWMuYw0K
QEAgLTIyMiw3ICsyMjIsNyBAQCBpbnQgcmFzX3VtY19sb2dfcGVuZGluZ19iYWRfYmFuayhzdHJ1
Y3QgcmFzX2NvcmVfY29udGV4dCAqcmFzX2NvcmUpDQogICAgICAgIG11dGV4X2xvY2soJnJhc191
bWMtPnBlbmRpbmdfZWNjX2xvY2spOw0KICAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUo
ZWNjX25vZGUsDQogICAgICAgICAgICAgICAgdG1wLCAmcmFzX3VtYy0+cGVuZGluZ19lY2NfbGlz
dCwgbm9kZSl7DQotICAgICAgICAgICAgICAgaWYgKGVjY19ub2RlICYmICFyYXNfdW1jX2xvZ19i
YWRfYmFuayhyYXNfY29yZSwgJmVjY19ub2RlLT5lY2MpKSB7DQorICAgICAgICAgICAgICAgaWYg
KCFyYXNfdW1jX2xvZ19iYWRfYmFuayhyYXNfY29yZSwgJmVjY19ub2RlLT5lY2MpKSB7DQogICAg
ICAgICAgICAgICAgICAgICAgICBsaXN0X2RlbCgmZWNjX25vZGUtPm5vZGUpOw0KICAgICAgICAg
ICAgICAgICAgICAgICAga2ZyZWUoZWNjX25vZGUpOw0KICAgICAgICAgICAgICAgIH0NCi0tDQoy
LjM0LjENCg0K
