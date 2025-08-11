Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFC6C87FDB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 13:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC10B10E09D;
	Mon, 11 Aug 2025 13:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YRAZGbTj";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC96C10E09D
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 13:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avrDTv+xmYccayFG185kA/kI8tweFJ//UAMAJhjlQOFZH17/vLzY0k951GD+h26gNcSoikTlHHYouxodVJNYzopwapAxWVwOLuCvzSydSbQVRIgVyrjqyN/mDqPVnEH+dtBMfP4M1Xb5Y3ztskIfA180Sc7oImmlsQB1DfSmHDeolP2uhqC7DTH+8oUh3TNoO1gqJs8t/+34R1tUnklccqbixIP2LgtP/pHwXzGvOpzni2GUHksafG0V4FJKM2xgoApTalqZzVATNSnbJ17ycz4EyYmbtQPW1kxI/cpgshVpWiAaLFncnx7G0+gkbG/HQTx6/DUK9tjFBCr8+cfkJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8XOmWI1/tGB2qRySaJ9GKS9FYq1UKaQ9IyGCbwxPZA=;
 b=cOFN78T2Qx1sRH4JBURZfgTA7T0j5/3869tzPVpzTUsHm/uQ9m6FNtDjBH2HUI1dlcEyoP1T79e+Ck87GilbKui0emiHn3ReGaTyLG++rmOmBoYoJ/owVJj3wxQEC/USFIgCAMPpIX5msZfjg1KFHDgLg9KbC+Gm5hrr5xwSzjZhvgmop4C08k5wYEU/KBX51ADbeC2abnJ4p1dxtAns0BgSHWDys5QBxOStJaDUC7KKmXYlrq9QEVG5KsfgJIDrhl4yvZ8X3IuMVjF86lCL4ey4fUvzge/Zbz4KWGYhSr2arjC+S6rUqqkIzmLJGK+3kdhccdpWPyJ/nmvzQEtPfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8XOmWI1/tGB2qRySaJ9GKS9FYq1UKaQ9IyGCbwxPZA=;
 b=YRAZGbTjRcGsXyEbUYkzSgSthkvZ7JNj5nRgSoMk1NhXWAGKAddV3A5WpZxrA64Hqd8sjjNUL3epjZlY92A8a+tw5CkEhQBGha3LPijAJn31lkB27Q897N6N8TCjZ4m4DQMHZtGa4qhtExCLUFy/3Jm7EVQ/irn0zuJHqR/ZhBQ=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CH3PR12MB9455.namprd12.prod.outlook.com (2603:10b6:610:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 13:46:11 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 13:46:11 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>
Subject: RE: [PATCH 0/4] DC Patches Aug 11 2025
Thread-Topic: [PATCH 0/4] DC Patches Aug 11 2025
Thread-Index: AQHcBn6TaN18fxgs00GUh4MCrlebCrRdfyrw
Date: Mon, 11 Aug 2025 13:46:11 +0000
Message-ID: <DS0PR12MB65347D6F60AA5B6EE8D5027F9C28A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250806030216.21096-1-chiahsuan.chung@amd.com>
In-Reply-To: <20250806030216.21096-1-chiahsuan.chung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-11T13:44:52.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CH3PR12MB9455:EE_
x-ms-office365-filtering-correlation-id: 7fd69ba1-4378-4535-1bd8-08ddd8dd6eb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cUR0YXhtOWIxdHJoYWwrUklYVzcrVERlVzBETzNYLzFDa3VBdk5KVm1vdDI4?=
 =?utf-8?B?Lzl1YVpvQklGaXhjVGYrZmFmTm5hTjduK0xYOUs3UzBBVVMvQzhvSDhMTUxp?=
 =?utf-8?B?MDVXeEIwWVRFN1BQMm9BRWFnWkhWR2E0UGZkWk9lSEFleVRaUm9RckNDVXp5?=
 =?utf-8?B?Snd5U2tKUlhTY1drYzIzWXFuWGRKMklRZUJ3eWtlbCtodjRiTWRBZHRyQ0Ni?=
 =?utf-8?B?VVZPNDhUOEN1Wi9NaFBYQVE4aVhxQ3JnVytwK1YraS9qcDRYYzdEYTh4bVpa?=
 =?utf-8?B?U3RaYzErclpJeEZ0ZmNGVDE2QlJnTWpQbnQrR2I2R1VBUWVxaDJzaGpSWWhD?=
 =?utf-8?B?NDIwYUxuUUVsaDZSYlB2Ry9QWW04dWFBWnNNVmx5NFlGZW5YS0tSdzlzZVdK?=
 =?utf-8?B?OUZFblpNMnlrWDhFUjJlLzlGMWtnQS9hbnM1U3hmcWJmSHI5YUJ0U2xSQU9m?=
 =?utf-8?B?bURZY2gxNFpERzdxMC9mRU81L1RUVUllbmhUSzZVUUc1MjRHeW5YZ3VYTmI0?=
 =?utf-8?B?MzlLVWYvYzh0ZFpZSzE2QytXQU5MYVE0bWVYMFBBVlVDcnBjTS9TWDRGZDZo?=
 =?utf-8?B?N1dtdStuTjIrVi9oL24wSmcwVXVGYllZenF2bGloeWtJdDRtZWVEUmNvV0lk?=
 =?utf-8?B?bEVuV2pUdWpkU05Namg5dkdFcWhtNWFneVdiOGVjdEt4bVBCRUdkMEVFblBX?=
 =?utf-8?B?K2xjQTBpSk1mZ3B1MTdBM0dpTy9rMjk1eHgrVUlsblVVUnR0OUdhUFRqV1Nq?=
 =?utf-8?B?ZVVubnd0S2ZYNlVhMmlkN2VzdndCNEJlT3RaMEdCOGV3OGx3ZzZUUmtuMGR2?=
 =?utf-8?B?aVlBN3JmaDhQTWtYaFluT3djd2htc0M1M3dVS3FpRUp0Q1BsNFd1QVNlSDNQ?=
 =?utf-8?B?TmQyK2l5bm55bUk2aGRjblVjYmVkSzNlNDBBcE8zZWVlc1ExaG52V1I5Ritv?=
 =?utf-8?B?a0pXYVZqdGlIcGttbFN1Z1dFODJoM2JiREhKNllZRlhLQThnY0RuV0R1N2pN?=
 =?utf-8?B?ajA3WVd0Y1B4TzZvSG5JRjNtakVJaUdhUmUrUWhKeGE5UjB6RytuWXM5R1lD?=
 =?utf-8?B?UWRZZVd0ejhHdEZua0xpT2VCZnNON2hIQ0JFU2w0S2wxZHJVcldCeGVKbjZq?=
 =?utf-8?B?R01YTnNtekxzbG1wOFl3dXJXQ0pvejA0NnVjRi9KU3phUERpT3RLSStpa0Zk?=
 =?utf-8?B?MVFLKzVCS2V3UnJ2TGhyMTJ6cis4TndrSVkzWVVXNTFCQm1pTnZhT2NKTUVS?=
 =?utf-8?B?Z0FLZU9vWEd0dVJydEh5ckkvNktqY2d1K25nS0RpLzVXS1RuTXA1dVc2NHlp?=
 =?utf-8?B?TUppTEhCbk1OYmIxU2NHcGZZM25PcmtyaVB5UCsxSmtrQS96YUlpbUJVbEV3?=
 =?utf-8?B?Q2pQNHVLM3UxaU5yTURtT2lGMTlPVTRZWmVCMTJpSllZeU8xUUVsckh6YUx3?=
 =?utf-8?B?Ymx6Rms5UTZiVmZCZ1lCaWRqR3o0WkFGdHhYRXVqL1EyQnhqRlpkMGUwbFRV?=
 =?utf-8?B?c3dZTGx3dEsxUnpQemd4NUdVUm1OV3paNVR2dysxRmFoREFqT25ZRys3Wkwv?=
 =?utf-8?B?SEVva29sa0xTMlJHQzBNbkZYU3h0R2xsRElldks5UUdmeHJYRVk5c0Z2Z2VU?=
 =?utf-8?B?dUJIRlRmZmxmR2JiTHB4WVhBbVdudGxkcUFqODBsMXNUZXVPaEdaL0NTMjRx?=
 =?utf-8?B?WHpTTDRNSWQwSWFnQWdidDVuVkljWnV6VHlzTFlzYVlTR0JFODFMUCtrL2tY?=
 =?utf-8?B?WDNrR0xvSFBBVjV2b0RXYWh3a2hHMVlNV0lsbXNiTXBlUS8zS1VNUEl1WDd5?=
 =?utf-8?B?SFdSY1lsajNrT2JsWXIrZTNUR0V0eDVxcmlmdnpZamxraWxBak9BUVgyWGM5?=
 =?utf-8?B?QXRlOWhHTVdaT24rY0tPUjFtbklZUnYwYmc1Q1U0ajQ4Mk0zNENQb21WeFpZ?=
 =?utf-8?B?V29WM1VsZGlnT2NmaWRPdVdidEVrOWlvRHRtWVlCcWNEZVUwUmE0dDZucUZL?=
 =?utf-8?B?bEg0ZTFrR2R3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NW91SmNzdnR5b2VtdTY0SGE0ZGlnRlFSL0l4eVd4MzBPVHNldVEzeVNaWnBB?=
 =?utf-8?B?Tno3WnB1V3VSOTRjWDdGdHNMS3YwdXBsQXM5TUdGWmljbkt4eXRaNUJMYTdE?=
 =?utf-8?B?THFPMVcvZEcwVnhJNDA1NGRuUU9DTS9SbDNOeHp0UGxSSjVPNThpQjVtTFRU?=
 =?utf-8?B?V0pWbFNpMVdrT1p5UnRwNXk0N1ZCRVpMc0FiVVhFdzArZW9OT1RFZjZWa2ls?=
 =?utf-8?B?YytmSjZ1M0dBbUxDeWJuMnNETnB3Q0J3U1RoWlUyRHk5QURLNCs3TXBjc09M?=
 =?utf-8?B?dHRsRW1XMXplcElNRmZyRUNKVUNRSGdSMXljWEtCcllIUzBYU2dVaWE1NU5i?=
 =?utf-8?B?K09GSGVQdVFqNk94WHU5OFg1ZEt6K1d2T2p5Wnl3UzRjbk1YRlFOMWdLQStj?=
 =?utf-8?B?SStlekVoVm13RzdIemJ4VnZaU0pLMGM0RHdlcWVNWmtLVHg2QTZPdDJsOWFU?=
 =?utf-8?B?ek9EMW94Q05udkJTSmZRRjBoSGJta21FeDVuRTJkMm9FMVpsVkxsMWZpMjQ0?=
 =?utf-8?B?bnlBSEJ6RmRLK3J0OVAzcWNsRENnN1pkeFl2VEQzaXUrQ2JQSnprZDFCMjRa?=
 =?utf-8?B?QTFCVFVWSjFNUXA3OHBNVDFaWUtCNjlBQkVUTjdzQWxzZUxHK1l5Z2tUTTZE?=
 =?utf-8?B?NjhzUWNiTWUvTkNQZTlpL2s2V3R2VSsvdno4NVRTZ0ZsWFM3R1ljWTN6QXdW?=
 =?utf-8?B?Mms5c0FaU2ZqRGlzbXlqSEJISXR3WWZ4MmFYYlpwaXJPVkw1VjNNYTlsMHNn?=
 =?utf-8?B?QTVibEg2c2xaSWJlNjNOd3ZRZ3VOVkxITGZKMDBtQUtRZzIvK2twMkt1M1RC?=
 =?utf-8?B?bWNBcUlCNkpkTmMxYWJuU2lKV1hDRytNRDlCRDNDYmgyY1loUWVWNHhyYU9r?=
 =?utf-8?B?U1FVRTRGSE1HRUkreVBGU0tiUlZKVnRoYjlVbUhvZW13Umt6TC8wcU5ETWZ5?=
 =?utf-8?B?WnAzSTVRb1doRVlXaTdhY0c3b1ZXVzFrVlJWdFJNbkMrTTdGemhFeU5iSFlE?=
 =?utf-8?B?VTR3NkQxcGFxVkJhTFVRV0xmRnVYeHQvc01hZmN2S3NtcEY4UHFkdkNLZGtS?=
 =?utf-8?B?c3kxcnFJZUkwVy8zUmc0d3RqTUY0bWNpQlZMb2dzTlVTeGJvZlZldlZsVDBk?=
 =?utf-8?B?RUFVdzRLcDR5UWR1Y0J2SG1MakJSd2NvV1BEQy9CVHRqVy9nOGJpaSsvQWoy?=
 =?utf-8?B?RS9mL0F2cndQWjBaQ0tHR0J6cVdWZkF5dVlQR1drckVrUDJ2d2dYV1FjbDlN?=
 =?utf-8?B?WVVzMGs2ellGRGtUaWE4bkxzQWxWN2pYNXV1VllpaWY5ZWF6TThJdmZWdENy?=
 =?utf-8?B?Q0RMSXlHQXVlWTFWRU5ZZnNUT3dlTXIxeko5SEg1YmpGc3RlVkF3NWJXNlYy?=
 =?utf-8?B?ZVZPRVdZQVQ0UTFaNWtub2hVZS9PazJVbytrMUhEVXd0OVRqd3RYRCtPMnBv?=
 =?utf-8?B?VTdEdmE5b3QwOVM5RDUwc0tvNkdSTVJUSUd3anQvUS9DY1pWeWZldE1vdjJV?=
 =?utf-8?B?Q2dyQ253aXU2VDVFSHhWR2t3NTZKQ3lKbXh4b2pibXBxRXVTYWxrMG8rOUxy?=
 =?utf-8?B?UjEwaVdyQ0lqTDdnR3B2SlB3Zlp0UDVSYmZ3a0o2V08vUjVUeWVSeHVQc2NP?=
 =?utf-8?B?V3N0cHlDcmE3d2F4M2E0YWxWMVBKdTJkYXFDeGZvYk8wNnJrMUVsWHdPbGx5?=
 =?utf-8?B?UFpCZUVHT2dnSHNyWWNxZjlZM2VPd1hjYXREUEY2UEVSVnlkNmZxSzBVT1N1?=
 =?utf-8?B?Yk1tb04xU3pad0JBMmxVVk0rbTZoNzlNOC80Mnp5MUJDMElSUEZCRTNSdlpo?=
 =?utf-8?B?MGlpNnNvTW12ZktnSyswcS92UlpBTC9SUFFxeGw3NTNUWmlFY0p2UjFJNitM?=
 =?utf-8?B?Z1FaL0RuQk5IVDdkN2hxMTJ1S1d4anMrdHY0TnNJK0tCNFhIcnp5MDZTMHBQ?=
 =?utf-8?B?ZGlFMCtaY2J0SW1GeTVtY3IvZ0V6N0oybWl6cElST3NuaXNYTEZOblkyZTJm?=
 =?utf-8?B?OXlhM3FMcW9EbXRqckQrVjRxTWpVNVBKV1V6T21jdG9nNzJqSFlXQVZzY0Ey?=
 =?utf-8?B?WHlvdzQrVDFycG5ka2liei9vWXkycHFMSUJ0aTFla2xleGYzc3FxQklKN1dt?=
 =?utf-8?Q?yVWg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd69ba1-4378-4535-1bd8-08ddd8dd6eb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 13:46:11.2271 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hr7jx3TDHLvto0htnVstID8dtJ3IAQbXqolt2koDQpCQ9Mxxv0InyZyeiWNwEy8UJUxY8htR8yFeLcpvLiqxPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9455
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

W1B1YmxpY10NCg0KSGkgYWxsLA0KDQpUaGlzIHdlZWsgdGhpcyBwYXRjaHNldCB3YXMgdGVzdGVk
IG9uIDQgc3lzdGVtcywgdHdvIGRHUFUgYW5kIHR3byBBUFUgYmFzZWQsIGFuZCB0ZXN0ZWQgYWNy
b3NzIG11bHRpcGxlIGRpc3BsYXkgYW5kIGNvbm5lY3Rpb24gdHlwZXMuDQoNCkFQVQ0KICAgICAg
ICDigKIgU2luZ2xlIERpc3BsYXkgZURQIC0+IDEwODBwIDYwaHosIDE5MjB4MTIwMCAxNjVoeg0K
ICAgICAgICDigKIgU2luZ2xlIERpc3BsYXkgRFAgKFNTVCBEU0MpIC0+IDRrMTQ0aHosIDRrMjQw
aHoNCiAgICAgICAg4oCiIE11bHRpIGRpc3BsYXkgLT4gZURQICsgRFAvSERNSS9VU0ItQyAtPiAx
MDgwcCA2MGh6IGVEUCArIDRrIDE0NGh6LCA0ayAyNDBoeiAoSW5jbHVkZXMgVVNCLUMgdG8gRFAv
SERNSSBhZGFwdGVycykNCiAgICAgICAg4oCiIFRodW5kZXJib2x0IC0+IExHIFVsdHJhZmluZSA1
aw0KICAgICAgICDigKIgTVNUIERTQyAtPiBDYWJsZSBNYXR0ZXJzIDEwMTA3NSAoRFAgdG8gM3gg
RFApIHdpdGggM3ggNGs2MGh6IGRpc3BsYXlzLCBIUCBIb29rIEcyIHdpdGggMnggNGs2MGh6IGRp
c3BsYXlzDQogICAgICAgIOKAoiBVU0IgNCAtPiBIUCBIb29rIEc0LCBMZW5vdm8gVGh1bmRlcmJv
bHQgRG9jaywgYm90aCB3aXRoIDJ4IDRrNjBoeiBEUCBhbmQgMXggNGs2MGh6IEhETUkgZGlzcGxh
eXMNCiAgICAgICAg4oCiIFNTVCBQQ09OIC0+IENsdWIzRCBDQUMtMTA4NSArIDF4IDRrIDE0NGh6
LCBGUkwzLCBhdCBhIG1heCByZXNvbHV0aW9uIHN1cHBvcnRlZCBieSB0aGUgZG9uZ2xlIG9mIDRr
IDEyMGh6IFlVVjQyMCAxMmJwYy4NCiAgICAgICAg4oCiIE1TVCBQQ09OIC0+IDF4IDRrIDE0NGh6
LCBGUkwzLCBhdCBhIG1heCByZXNvbHV0aW9uIHN1cHBvcnRlZCBieSB0aGUgYWRhcHRlciBvZiA0
ayAxMjBoeiBSR0IgOGJwYy4NCg0KREdQVQ0KICAgICAgICDigKIgU2luZ2xlIERpc3BsYXkgRFAg
KFNTVCBEU0MpIC0+IDRrMTQ0aHosIDRrMjQwaHoNCiAgICAgICAg4oCiIE11bHRpcGxlIERpc3Bs
YXkgRFAgLT4gNGsyNDBoeiArIDRrMTQ0aHoNCiAgICAgICAg4oCiIE1TVCAoU3RhcnRlY2ggTVNU
MTREUDEyM0RQIFtEUCB0byAzeCBEUF0gYW5kIDJ4IDRrIDYwaHogZGlzcGxheXMpDQogICAgICAg
IOKAoiBNU1QgRFNDICh3aXRoIENhYmxlIE1hdHRlcnMgMTAxMDc1IFtEUCB0byAzeCBEUF0gd2l0
aCAzeCA0azYwaHogZGlzcGxheXMpDQoNClRoZSB0ZXN0aW5nIGlzIGEgbWl4IG9mIGF1dG9tYXRl
ZCBhbmQgbWFudWFsIHRlc3RzLiBNYW51YWwgdGVzdGluZyBpbmNsdWRlcyAoYnV0IGlzIG5vdCBs
aW1pdGVkIHRvKQ0KICAgICAgICDigKIgQ2hhbmdpbmcgZGlzcGxheSBjb25maWd1cmF0aW9ucyBh
bmQgc2V0dGluZ3MNCiAgICAgICAg4oCiIFZpZGVvL0F1ZGlvIHBsYXliYWNrDQogICAgICAgIOKA
oiBCZW5jaG1hcmsgdGVzdGluZw0KICAgICAgICDigKIgU3VzcGVuZC9SZXN1bWUgdGVzdGluZw0K
ICAgICAgICDigKIgRmVhdHVyZSB0ZXN0aW5nIChGcmVlc3luYywgSERDUCwgZXRjLikNCg0KQXV0
b21hdGVkIHRlc3RpbmcgaW5jbHVkZXMgKGJ1dCBpcyBub3QgbGltaXRlZCB0bykNCiAgICAgICAg
4oCiIFNjcmlwdCB0ZXN0aW5nIChzY3JpcHRzIHRvIGF1dG9tYXRlIHNvbWUgb2YgdGhlIG1hbnVh
bCBjaGVja3MpDQogICAgICAgIOKAoiBJR1QgdGVzdGluZw0KDQpUaGUgdGVzdGluZyBpcyBtYWlu
bHkgdGVzdGVkIG9uIHRoZSBmb2xsb3dpbmcgZGlzcGxheXMsIGJ1dCBvY2Nhc2lvbmFsbHkgdGhl
cmUgYXJlIHRlc3RzIHdpdGggb3RoZXIgZGlzcGxheXMNCiAgICAgICAg4oCiIFNhbXN1bmcgRzgg
TmVvIDRrMjQwaHoNCiAgICAgICAg4oCiIFNhbXN1bmcgUU41NVFOOTVCIDRrIDEyMGh6DQogICAg
ICAgIOKAoiBBY2VyIFhWMzIyUUtLViA0azE0NGh6DQogICAgICAgIOKAoiBIUCBVMjcgNGsgV2ly
ZWxlc3MgNGs2MGh6DQogICAgICAgIOKAoiBMRyAyN1VENThCIDRrNjBoeg0KICAgICAgICDigKIg
TEcgMzJVTjY1MFdBIDRrNjBoeg0KICAgICAgICDigKIgTEcgVWx0cmFmaW5lIDVrIDVrNjBoeg0K
ICAgICAgICDigKIgQVUgT3B0cm9uaWNzIEIxNDBIQU4wMS4xIDEwODBwIDYwaHogZURQDQogICAg
ICAgIOKAoiBBVSBPcHRyb25pY3MgQjE2MFVBTjAxLkogMTkyMHgxMjAwIDE2NWh6IGVEUA0KDQpU
aGUgcGF0Y2hzZXQgY29uc2lzdHMgb2YgdGhlIGFtZC1zdGFnaW5nLWRybS1uZXh0IGJyYW5jaCAo
SGVhZCBjb21taXQgLT4gZjA3YjMxNGMyYTNmNzBhNDg3MDg2MTUwZWY3OTRjMjJkODZiNWE4Yi0+
IGRybS9hbWRncHU6IEFkZCB3cmFwcGVyIGZ1bmN0aW9uIGZvciBkcGMgc3RhdGUpIHdpdGggbmV3
IHBhdGNoZXMgYWRkZWQgb24gdG9wIG9mIGl0Lg0KDQpUZXN0ZWQgb24gVWJ1bnR1IDI0LjA0LjMs
IG9uIFdheWxhbmQgYW5kIFgxMSwgdXNpbmcgS0RFIFBsYXNtYSBhbmQgR25vbWUuDQoNClRlc3Rl
ZC1ieTogRGFuaWVsIFdoZWVsZXIgPGRhbmllbC53aGVlbGVyQGFtZC5jb20+DQoNCg0KVGhhbmsg
eW91LA0KDQpEYW4gV2hlZWxlcg0KU3IuIFRlY2hub2xvZ2lzdCB8IEFNRA0KU1cgRGlzcGxheQ0K
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQoxIENvbW1lcmNlIFZhbGxleSBEciBFLCBUaG9ybmhpbGwsIE9OIEwzVCA3WDYNCmFtZC5jb20N
Cg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogVG9tIENodW5nIDxjaGlhaHN1
YW4uY2h1bmdAYW1kLmNvbT4NClNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCA1LCAyMDI1IDEwOjU3IFBN
DQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBXZW50bGFuZCwgSGFycnkg
PEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+OyBMaSwgU3VuIHBlbmcgKExlbykgPFN1bnBlbmcuTGlA
YW1kLmNvbT47IFBpbGxhaSwgQXVyYWJpbmRvIDxBdXJhYmluZG8uUGlsbGFpQGFtZC5jb20+OyBM
aSwgUm9tYW4gPFJvbWFuLkxpQGFtZC5jb20+OyBMaW4sIFdheW5lIDxXYXluZS5MaW5AYW1kLmNv
bT47IENodW5nLCBDaGlhSHN1YW4gKFRvbSkgPENoaWFIc3Vhbi5DaHVuZ0BhbWQuY29tPjsgWnVv
LCBKZXJyeSA8SmVycnkuWnVvQGFtZC5jb20+OyBXaGVlbGVyLCBEYW5pZWwgPERhbmllbC5XaGVl
bGVyQGFtZC5jb20+OyBXdSwgUmF5IDxSYXkuV3VAYW1kLmNvbT47IExJUFNLSSwgSVZBTiA8SVZB
Ti5MSVBTS0lAYW1kLmNvbT47IEh1bmcsIEFsZXggPEFsZXguSHVuZ0BhbWQuY29tPg0KU3ViamVj
dDogW1BBVENIIDAvNF0gREMgUGF0Y2hlcyBBdWcgMTEgMjAyNQ0KDQpUaGlzIERDIHBhdGNoc2V0
IGJyaW5ncyBpbXByb3ZlbWVudHMgaW4gbXVsdGlwbGUgYXJlYXMuIEluIHN1bW1hcnksIHdlIGhp
Z2hsaWdodDoNCg0KLUZpeCBjbG9zZSBhbmQgb3BlbiBsaWQgbWF5IGNhdXNlIGVEUCByZW1haW5p
bmcgYmxhbmsgLUZpeCBmcmVxdWVudGx5IGRpc2FibGluZy9lbmFibGluZyBPVEcgbWF5IGNhdXNl
IGluY29ycmVjdCBjb25maWd1cmF0aW9uIG9mIE9URw0KDQpDYzogRGFuaWVsIFdoZWVsZXIgPGRh
bmllbC53aGVlbGVyQGFtZC5jb20+DQoNCg0KRGFubnkgV2FuZyAoMSk6DQogIGRybS9hbWQvZGlz
cGxheTogUmVzZXQgYXBwbHlfZWFtbGVzc19ib290X29wdGltaXphdGlvbiB3aGVuIGRwbXNfb2Zm
DQoNClRhaW11ciBIYXNzYW4gKDIpOg0KICBkcm0vYW1kL2Rpc3BsYXk6IFtGVyBQcm9tb3Rpb25d
IFJlbGVhc2UgMC4xLjIyLjANCiAgZHJtL2FtZC9kaXNwbGF5OiBQcm9tb3RlIERDIHRvIDMuMi4z
NDUNCg0KVHVuZ1l1IEx1ICgxKToNCiAgZHJtL2FtZC9kaXNwbGF5OiBXYWl0IHVudGlsIE9URyBl
bmFibGUgc3RhdGUgaXMgY2xlYXJlZA0KDQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2NvcmUvZGMuYyAgICAgIHwgIDIgKy0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZGMuaCAgICAgICAgICAgfCAgMiArLQ0KIC4uLi9hbWQvZGlzcGxheS9kYy9vcHRjL2RjbjQwMS9k
Y240MDFfb3B0Yy5jICB8ICA1ICsrDQogLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9pbmMv
ZG11Yl9jbWQuaCAgIHwgNjkgKysrKysrKysrKysrKysrKysrKw0KIDQgZmlsZXMgY2hhbmdlZCwg
NzYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KLS0NCjIuNDMuMA0KDQo=
