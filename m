Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DB8CCD192
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 13:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 139F410E60F;
	Tue, 14 Oct 2025 13:53:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TSZ/3NVc";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012009.outbound.protection.outlook.com
 [40.93.195.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FFD810E611
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 13:53:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUYkPrv7MBtnUhdnAODQ4l2oz8OkU3ujmY09u1MNBsVpiQ/AjvfsEyg8VK/I277VHojnv0bnEHk/kee2mL33PWysebbtITWKOWN6sOeHEDJ9Lv0DTP2siUCKUFeZEtPxMPC6N6KidoVdE9ccHsQ7pwolcmOWccjhveqeAhyNXWv1FEKduYRQSaI6DNL7f2XZIL8ZMaPdPJYrNPhxW3GP1jPdBA1qupBk2WAlt6qw0+6ehnT8eygCPjsI0dRKCNSf/7P6MRBQ49T6hStkKCae1LMwsjs40fZ+0f4oSuX4MpDNcfe28L4q2wGUQID2A4YKDXrIkAI8M3k10b73b2MNRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/1RUAIi1wcbzXdrBnHztgYWpynwKYRjffxVFuHAFEo=;
 b=bGzUs9w2oDtxEGr6mFxGejLMU6VvYlsY+wLgizOVBOAyIrVjcr+Y5A9Q7DOKc/Ih/tIoRNAzOv9T/Z8q0nAkV9W2LyDKYXMLtswjDht5Tj8XeC+185Vp9gc81YXluFp/wgcWiNF/3aIyFvmbhTtZQ/09ygOzM6Q7idTcGf3wf3JsjxDtbEa6XSV6YAOQrRFMskLSgVbjg+OMBx40lC8u6JuDiMcW6kIm0+Z86JOYUKVARCqVOKRszYFwPKFBtohgvSJ8TrFj/Wh3idBVB4xM9MAv3jos4Lbm4Wz7TWqwrEFRhEsoD5hU8DOZ7/gal3hk7/GOSiKkYjPu4ADCQZzkyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/1RUAIi1wcbzXdrBnHztgYWpynwKYRjffxVFuHAFEo=;
 b=TSZ/3NVcfQYOlwPdxKRRCc3hVMXbkwK6JJU3KYR4dpXrk7sOTmX12MhQzk0X8xU83yR3vLevub9URghCmciOqBeO7pHgBEEfBeWEVtp/ugZQT4UzNjVfBMrtxCN0+amFkSDPDbkmezzUMzmzxFLtB+eGUPZkyIi7/gW9nFjHsrE=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 13:53:20 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::c1d5:bb14:abc3:7fd1]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::c1d5:bb14:abc3:7fd1%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 13:53:20 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
CC: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>, "Wu, Ray"
 <Ray.Wu@amd.com>, "Wheeler, Daniel" <Daniel.Wheeler@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>, Linux List Kernel Mailing
 <linux-kernel@vger.kernel.org>, Linux regressions mailing list
 <regressions@lists.linux.dev>
Subject: =?utf-8?B?UmU6IDYuMTgvcmVncmVzc2lvbi9iaXNlY3RlZCDigJMgQlVHOiBzbGVlcGlu?=
 =?utf-8?B?ZyBmdW5jdGlvbiBjYWxsZWQgZnJvbSBpbnZhbGlkIGNvbnRleHQgYXQgLi9p?=
 =?utf-8?Q?nclude/linux/sched/mm.h:321_after_6d31602a9f57?=
Thread-Topic: =?utf-8?B?Ni4xOC9yZWdyZXNzaW9uL2Jpc2VjdGVkIOKAkyBCVUc6IHNsZWVwaW5nIGZ1?=
 =?utf-8?B?bmN0aW9uIGNhbGxlZCBmcm9tIGludmFsaWQgY29udGV4dCBhdCAuL2luY2x1?=
 =?utf-8?Q?de/linux/sched/mm.h:321_after_6d31602a9f57?=
Thread-Index: AQHcNiv6PcJ1brHvqkCPD0iW1oJ6RrS29K0AgAAE/+6ACPwWgIABwWh0
Date: Tue, 14 Oct 2025 13:53:20 +0000
Message-ID: <CH0PR12MB5284F51463E2B68EF5D68DE18BEBA@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <CABXGCsO8_GXZQ9tJYZJDbO7oGvsHyVS-32L1PZ7YNL0SrA1RFg@mail.gmail.com>
 <CABXGCsO2Yx1FvyryYU_R=kvS292eCDaLr9j0LHKPtNDkkz28PQ@mail.gmail.com>
 <CH0PR12MB5284060F40235BB4538B51DD8BE0A@CH0PR12MB5284.namprd12.prod.outlook.com>
 <CABXGCsP-haMF=kMkfOVBr8AjQLvfGr1ncgqstHrYyDWY5ZABHA@mail.gmail.com>
In-Reply-To: <CABXGCsP-haMF=kMkfOVBr8AjQLvfGr1ncgqstHrYyDWY5ZABHA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-14T13:53:19.606Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|PH7PR12MB5903:EE_
x-ms-office365-filtering-correlation-id: 404e34c3-0fdc-4d88-1b5f-08de0b2908de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?utf-8?B?N2xqbzcveU9UTXpxd2ttbGdHbHdSblJkYm96MERxRzNEUXplNmtIL3lIR01S?=
 =?utf-8?B?SmFJYmdsL2pWSnR5cVVFQ2xGRmkxd25yVGtQWndRY0lvaXZxeDI5clNEc2FS?=
 =?utf-8?B?VU9hSXcvSWJjSDhrbStkYnp3RWFNMXVXU3FHc3dqZStTUUtOZTVZUW05QWg1?=
 =?utf-8?B?MGdPcGxSVkJpK0E5M1NtYWFiTlZsYTJ6a2dlaTN0dGd3Q1d0REJXL3FLamJt?=
 =?utf-8?B?dGJmM0hyNEJFYVFIZ3dxOHpXeUQzRDNWVUFlU0xyN1BtemsrUHRTMEpUeGx6?=
 =?utf-8?B?SU8vNHZiKzM3K1FMTlZGUDlxY2p0RysyTTFoODlOaDdIYUFDdlZVcllmeUh4?=
 =?utf-8?B?eDhnOWZVQS9qakFIR1pPYmlxdE5PZGJXeUs2cFRLTXhlNTlOUmJQL3lGS2ti?=
 =?utf-8?B?WDl4M1RQMU05OHVlOG5nSE9oVEVYL3E1OEU2MDlFZUlDbXBmV1N6QnhDdlIz?=
 =?utf-8?B?OThxUEhtQzFGUGExaThzTG5IU1gyNlhpekJLMk0zWmVqZG9sUCt6MEt5Nm9n?=
 =?utf-8?B?bnlKa1hBTVlpK2hPRVRjeDVxdU1xRm5jWnIvZFFybFhEQXNwQUVYYk1FWlRS?=
 =?utf-8?B?Q1VYanlabzIraVFoT29CZTBwWi9oQVRTYVZXdHFwejIzM0QzbWhUZkZTUGRC?=
 =?utf-8?B?amN0azdIYTFnS01uTjdzVkxxdXQ5OE1mRGhjdC9iTU9oa3l4SUx0Vlh6Nm5h?=
 =?utf-8?B?MmpSbTgzeVlqaENldERGUkRubW42YnlVbHliS3AwWkJ1a1ZKM2tUd29nR1Ar?=
 =?utf-8?B?Nlhqc21mbFhVbnZGUmVuUmdnRXlBUThUcUFVendDbjlFVFk4MUE0QVN6S0s5?=
 =?utf-8?B?V28wWWJMaG5mNzc0Y2k0T0k3UVU4V3MyRFpIVHp6b2tZN2xGQ21FbFRTM3Rj?=
 =?utf-8?B?VmY3TlkvRWFLekF0alF5dHZ1OTNKNXZKYmNjZVp4MDBKZ0FjTVBnWXRJcFVq?=
 =?utf-8?B?YnF3Zm1hSWpncU1TSEJaWjNkQjFVOFRDeVZwZVU1K2FkalczUGdlbWtuem1F?=
 =?utf-8?B?WjhNYm55N2VSR3J5NzNZZXJMN2lIc2RIdHYxajJqTEVuRUdtN0Z5bjRIaHI4?=
 =?utf-8?B?azgwVU0ybVFTWTQ2UUlXVkVwVmhQd3ZTMjVwZ1k5ZzVJNmZwNHBnclBsT2Fj?=
 =?utf-8?B?TXdRdlprZzN3NVN5NU1tdVFBdjVIdHNXQ1h5b3ZSTjRWZkdtZW5tYlpWUEJR?=
 =?utf-8?B?Qk9nT1MxNXJ0RnRqV2xDcHV5SnR1T0ptNG1EVVRTMzZnQ2l2eFVvUW9TU3V6?=
 =?utf-8?B?WTYxbjFXNzBmTTN5OU1wT0REY1R1LzlWMUdBM1liRU0ySEQ2bWRCSlV6d2sz?=
 =?utf-8?B?WVV1UkllL1Z6cXdld1hTWHlNQ09VQ3BYME1Nc3lCR1AxaUtjYjdVVTJOdXFX?=
 =?utf-8?B?S1J0MnpTalpmK2RZVFViWUUzKy9WSmVoVDVDbENyZ3ZkeE1UVU43QXZDa0Zk?=
 =?utf-8?B?QmdWOHlnM0lGWDZoWi9DcFlCaGpkaEMxQ2MwZlhSUmxJTTI1dWpieGU3ZGNa?=
 =?utf-8?B?dS94ZWFuNFlYMExzYVJvU1ZQWStJUHJaNUw4ckRQNHRQMUxWVlk1bUpFY0dy?=
 =?utf-8?B?RC9FdFhHWEdmQjY5QmhtWjcvYjMzakI2bnlsaFZzRHRHdUprQVZhZStwbnZp?=
 =?utf-8?B?SUx5QnZLY3pyVEJMalh3dThhTjlBSEpIOWc1bnlsQnN0Z3BFclgyeituNWNR?=
 =?utf-8?B?ZzZPR3RyMGJpYm10V2lkd1A3emN4cHhNY2x2UUt2L3lQWVZ1MlF0d3pZTGts?=
 =?utf-8?B?QmFCNDh3Q3ZEVEFBWmpNYjZOSkNEWE45eGhQem42K004VGZ1YzkrWFFFYXdp?=
 =?utf-8?B?KzZ5LytJak9KTDhWc3RxeHBhQmJTVE9TZlV3M2lhdWxXUE1YZmg5d2s3MERv?=
 =?utf-8?B?QWwzWEJlcWFXOCtwZkNvRlJabjkvenRvUDRoZGVGbFp0NHBOQjdkU0V3RXhK?=
 =?utf-8?B?YURHbTBYWEZrdjdLY3g1U3AyTG9ETkhGR21BaWlwZ0tFUUFVRm1OUEtoVkdB?=
 =?utf-8?B?dDdjME5BQjU1N2FjMFA3VXAwTmJDTE90QUZVV2tIdkd0OGFxWk0xbEFHK09K?=
 =?utf-8?Q?VkTBbh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXhkemRvanNKUW45N0FkZ0wvNDBYa3VuZGQ1YVFYZVh6WWh6blhPL2c5QmF4?=
 =?utf-8?B?c09hQWFjOTI3MzdpZjc1K1RhOTBiNllMRDhzWGRPbW5UUmxlVWV2UkltQ3R3?=
 =?utf-8?B?QWZNZ3JuaTBsNVRWZ0o4UVhjVFhQeHNnR1dRRFZuTG1oMHZzSis5UkRRTEYx?=
 =?utf-8?B?dU4vbXE1b2JCSHNPSHJJL0NzSSt3RGpPekVhVzN1WkZJMFJuMlNtSXkwYWF1?=
 =?utf-8?B?cjIvVHAzMGNqNjI0TGFNMTFzUk1EZndDK1p0SWVQRkpBMzMvOEYwenpwV3FO?=
 =?utf-8?B?SmRMWVZSSjNXY0JjS2c3R0lOQk1URURrdkNmNnNIM0JyZVREbjNCN1ZQL3hO?=
 =?utf-8?B?ZzQvVkdBNW5zTnJscnRzVEFlQ2FBbHJPaUlZaklPV1ZMcEdsOHZ1d09jN1pu?=
 =?utf-8?B?R3pjNEIvSDNOR0dSNDIzK2ZtOVZ1WVd0aWoxSUNhc1FobUwrSFdlU2oybmIz?=
 =?utf-8?B?dWc1N0Y1enhweWJ6b3BMTzBjUWZKRVZqK2Rob2Z0YmpJZEQwOWVXc3dGR1lJ?=
 =?utf-8?B?aFNHeDFvd09HQ3ZJd1AvVWlhSkF5cVRCc0t6eDRCVXczd3BKOFByMHUveGZ5?=
 =?utf-8?B?dHB0NEdaTG9GNU9mR25LSytTeWhYK0hVOUt6KzBkWmozZTVmZnljU2RVci9X?=
 =?utf-8?B?S21NaFFoS3pxc2FVazBxc2RvMHcwZVNHZWk3V25yb21ua2ZWckxNUjVHKzB4?=
 =?utf-8?B?bVpZRElOWmxQR2hXU2Q0LytsWUdpYTREMGd2aU5EeWlkT2pTNGJmVjhOU21Q?=
 =?utf-8?B?amtuZE96SEFOa214L3hOUlFJeEhXSjdFZ2gvUG1QSzk3OGFIUS9GaFhZVU0y?=
 =?utf-8?B?Q1dGRXF0ZGVoOCtUZFdyMWowdHF0RGhMNllzaTZVSUVVSld0bUR5UmhRd3BZ?=
 =?utf-8?B?SmZwazFIWTluYXo4V3dHWW1Sa2xFUTUrWTE0UWp2ZTJJSElsOXlkRnpUTWlL?=
 =?utf-8?B?a1FQbXV5ZTlvbWNCRk82VHgrZVlJZGMrMW5kdWJUZnBmaEdNSEFJNHdNV0tu?=
 =?utf-8?B?bkJQbWVhNWM4K3NZbWRFK2grQ0N3RmFFT1IrTjMrWExhQnpiU3FVSGNTMXF4?=
 =?utf-8?B?dUowVllLRzBtdTZBaTltZk1WWkZvQW1pYmN5bmQyOEhMUmJ5U0cycWdrSzNl?=
 =?utf-8?B?c1M2REMyeFlqRmo3cHhrZzVFMFJUNWpIbFYycm1yazY3cXBiTzVRYUN5Szdr?=
 =?utf-8?B?TjZ1YzZYQ3c5Qm5MbTVkOVVMWWRpQnRLSUZEQ1lrbWhtOER2VE02a016OGwy?=
 =?utf-8?B?S25HQ1VCWkx6ajRYKzIxN29jRDdlZDYzTEtlOVM3QXJIUEExTVBOcmprS0ha?=
 =?utf-8?B?dXpWWHpqaUNZTHBuaXVDV0pBV3hsT2U5dklZNm9QTEpIdWwxL0ZyVzBiTlpI?=
 =?utf-8?B?ZnUrR3BBdnBKcHU3MGdQWVhCRUNEOGdIUUxuN0x2cWREMmFIK1pweHJBMis1?=
 =?utf-8?B?bW44T1l5dzRBY081M2lqbXRuVUxCYld3a1p1YmNaN1pFakViekNhZnhJMllE?=
 =?utf-8?B?M2EzZ0lNTmZTRng4aXJBTVZWaEkyeTZsWmlXRFIxamRoejVnYVA2bzJJYVFr?=
 =?utf-8?B?NWZRZW1YMDg3NFQ0M3pqTVRZcFVGZHFEVHVlU1pCRmdhUURjaG83UjV3WjBm?=
 =?utf-8?B?YlpSL2lkbExkeGZWRDRxbDh3aENKVDI0akRQdVNLVXBWcVhKeHBNYTRCRFFI?=
 =?utf-8?B?Qk93NVhvYUpLUEw3cUpudjZQYVFsV1Vjczk0Z3VVVU1kaFd2Z3BiVi9qVlU1?=
 =?utf-8?B?ekZQL2lYYm5OZFIvcm52SUpkNUxPbitaZjR0em5vbVc1UTVxZFZhcUQ1eVZ5?=
 =?utf-8?B?NFl4UEFreTFHNGdDQ3ppMWs4R2Y4RG1MUWF5emVEVTFjNlhjU3VQZ0dkaHRm?=
 =?utf-8?B?OFJPZGRRdE9mR2RXTktTL0d1Qi92Q1pqK2ZjQzFUZ0RIWkFJNW9XdHY2Y0NW?=
 =?utf-8?B?bjNNU2k3M2xrNExudDBRdmlNaEZEWU1RNWl5ZWhLWmowRHlHL29RTkFSb0V5?=
 =?utf-8?B?WkY3KzcrRW1YSzg2Y012KzFmUGpPYWdTOWRrbkx0OEpZTnR2NVFHTFR1MVpH?=
 =?utf-8?B?eEZMMytGdXF5TzdRWTVnZTZwNFJWMkV4cXc5ZUdES0llUytYRnIyYkJaNXcz?=
 =?utf-8?Q?tkEw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5284F51463E2B68EF5D68DE18BEBACH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404e34c3-0fdc-4d88-1b5f-08de0b2908de
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 13:53:20.2660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nxgVG9K2YHuRV3ttrvYo0jyMeLdTqv5sE3pw8qtzo5dQqK0pwdYTQ6slnVOWttk8PnWOD657vy9iV0wK3kzGug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903
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

--_000_CH0PR12MB5284F51463E2B68EF5D68DE18BEBACH0PR12MB5284namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgTWlraGFpbCwNCg0KTWVyZ2luZyB0aGUgcGF0Y2hlcyB3ZXJlIGRlbGF5ZWQgYmVjYXVz
ZSBvZiB0aGUgVGhhbmtzZ2l2aW5nIGhvbGlkYXkgaW4gQ2FuYWRhLiBJdCdsbCBsYW5kIG9uIGFt
ZC1zdGFnaW5nLWRybS1uZXh0IHNvb24uDQoNCi0tDQoNClJlZ2FyZHMsDQpKYXkNCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQpGcm9tOiBNaWtoYWlsIEdhdnJpbG92IDxtaWtoYWls
LnYuZ2F2cmlsb3ZAZ21haWwuY29tPg0KU2VudDogTW9uZGF5LCBPY3RvYmVyIDEzLCAyMDI1IDc6
MDMgQU0NClRvOiBQaWxsYWksIEF1cmFiaW5kbyA8QXVyYWJpbmRvLlBpbGxhaUBhbWQuY29tPg0K
Q2M6IEthemxhdXNrYXMsIE5pY2hvbGFzIDxOaWNob2xhcy5LYXpsYXVza2FzQGFtZC5jb20+OyBX
dSwgUmF5IDxSYXkuV3VAYW1kLmNvbT47IFdoZWVsZXIsIERhbmllbCA8RGFuaWVsLldoZWVsZXJA
YW1kLmNvbT47IExpLCBSb21hbiA8Um9tYW4uTGlAYW1kLmNvbT47IENodW5nLCBDaGlhSHN1YW4g
KFRvbSkgPENoaWFIc3Vhbi5DaHVuZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZz47IExpbnV4IExpc3QgS2VybmVsIE1haWxpbmcgPGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc+OyBMaW51eCByZWdyZXNzaW9ucyBtYWlsaW5nIGxpc3QgPHJlZ3Jlc3Npb25z
QGxpc3RzLmxpbnV4LmRldj4NClN1YmplY3Q6IFJlOiA2LjE4L3JlZ3Jlc3Npb24vYmlzZWN0ZWQg
4oCTIEJVRzogc2xlZXBpbmcgZnVuY3Rpb24gY2FsbGVkIGZyb20gaW52YWxpZCBjb250ZXh0IGF0
IC4vaW5jbHVkZS9saW51eC9zY2hlZC9tbS5oOjMyMSBhZnRlciA2ZDMxNjAyYTlmNTcNCg0KT24g
VHVlLCBPY3QgNywgMjAyNSBhdCAxMDo1NeKAr1BNIFBpbGxhaSwgQXVyYWJpbmRvDQo8QXVyYWJp
bmRvLlBpbGxhaUBhbWQuY29tPiB3cm90ZToNCj4NCj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAt
IEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4NCj4gSGkgTWlraGFpbCwNCj4NCj4g
c2NoZWR1bGVfZGNfdm1pbl92bWF4KCkgaGFzIGFuIGFsbG9jYXRpb24gd2hpY2ggaXMgaW5jb3Jy
ZWN0bHkgdXNpbmcgR0ZQX0tFUk5FTCwgd2hpY2ggaXMgbGlrZWx5IHRoZSByZWFzb24gZm9yIHRo
ZSAic2xlZXBpbmcgZnVuY3Rpb24gY2FsbGVkIGZyb20gaW52YWxpZCBjb250ZXh0Ii4gV2UgaGF2
ZSBhIGZpeCBxdWV1ZWQgZm9yIHRoaXMgd2VlaydzIHVwZGF0ZSAoc3dpdGNoaW5nIGl0IHRvIEdG
UF9OT1dBSVQpLg0KPg0KDQpIaSBBdXJhYmluZG8sDQoNCjYuMTguMC1yYzEgc3RpbGwgcmVxdWly
ZXMgcmV2ZXJ0aW5nIGNvbW1pdHMgOWQ2OTM5MTc5NDkxIGFuZCA2ZDMxNjAyYTlmNTcNCnRvIGF2
b2lkIHRoZSDigJxzbGVlcGluZyBmdW5jdGlvbiBjYWxsZWQgZnJvbSBpbnZhbGlkIGNvbnRleHTi
gJ0gd2FybmluZ3MuDQoNClRoZSBnb29kIG5ld3MgaXMgdGhhdCB0aGUgc2VwYXJhdGUgV0FSTiBw
cmV2aW91c2x5IHRyaWdnZXJlZCBhdA0KZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmM6MTM4IGFtZGdwdV92bV9zZXRfcGFzaWQoKQ0Kbm8gbG9uZ2VyIGFwcGVhcnMgaW4gcmVj
ZW50IGJ1aWxkcy4NClRoaXMgV0FSTiB3YXMgYSBtZXJnZS1vbmx5IHNpZGUgZWZmZWN0IChpbnRl
cmFjdGlvbiBiZXR3ZWVuIGRybS1uZXh0DQphbmQgYW1kLWRybS1uZXh0KSwNCnRob3VnaCBpdOKA
mXMgdW5jbGVhciB3aGljaCBleGFjdCBjaGFuZ2UgcmVzb2x2ZWQgaXQuDQoNCkxvZ3MgZm9yIGJv
dGggY2FzZXMgYXJlIGF0dGFjaGVkLg0KDQotLQ0KQmVzdCBSZWdhcmRzLA0KTWlrZSBHYXZyaWxv
di4NCg==

--_000_CH0PR12MB5284F51463E2B68EF5D68DE18BEBACH0PR12MB5284namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgc3R5bGU9
ImRpc3BsYXk6bm9uZTsiPiBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30gPC9zdHls
ZT4NCjwvaGVhZD4NCjxib2R5IGRpcj0ibHRyIj4NCjxkaXYgY2xhc3M9ImVsZW1lbnRUb1Byb29m
IiBzdHlsZT0idGV4dC1hbGlnbjogbGVmdDsgbWFyZ2luLWxlZnQ6IDVwdDsgZm9udC1mYW1pbHk6
IENhbGlicmk7IGZvbnQtc2l6ZTogMTBwdDsgY29sb3I6IHJnYigwLCAwLCAyNTUpOyI+DQpbQU1E
IE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XTwvZGl2
Pg0KPGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9zLCBBcHRvc19FbWJlZGRlZEZvbnQsIEFw
dG9zX01TRm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1z
aXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyIgY2xhc3M9ImVsZW1lbnRUb1Byb29mIj4N
Cjxicj4NCjwvZGl2Pg0KPGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9zLCBBcHRvc19FbWJl
ZGRlZEZvbnQsIEFwdG9zX01TRm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZldGljYSwgc2Fucy1z
ZXJpZjsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyIgY2xhc3M9ImVsZW1l
bnRUb1Byb29mIj4NCkhpIE1pa2hhaWwsPC9kaXY+DQo8ZGl2IHN0eWxlPSJmb250LWZhbWlseTog
QXB0b3MsIEFwdG9zX0VtYmVkZGVkRm9udCwgQXB0b3NfTVNGb250U2VydmljZSwgQ2FsaWJyaSwg
SGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2IoMCwgMCwg
MCk7IiBjbGFzcz0iZWxlbWVudFRvUHJvb2YiPg0KPGJyPg0KPC9kaXY+DQo8ZGl2IHN0eWxlPSJm
b250LWZhbWlseTogQXB0b3MsIEFwdG9zX0VtYmVkZGVkRm9udCwgQXB0b3NfTVNGb250U2Vydmlj
ZSwgQ2FsaWJyaSwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9y
OiByZ2IoMCwgMCwgMCk7IiBjbGFzcz0iZWxlbWVudFRvUHJvb2YiPg0KTWVyZ2luZyB0aGUgcGF0
Y2hlcyB3ZXJlIGRlbGF5ZWQgYmVjYXVzZSBvZiB0aGUgVGhhbmtzZ2l2aW5nIGhvbGlkYXkgaW4g
Q2FuYWRhLiBJdCdsbCBsYW5kIG9uIGFtZC1zdGFnaW5nLWRybS1uZXh0IHNvb24uPC9kaXY+DQo8
ZGl2IGNsYXNzPSJlbGVtZW50VG9Qcm9vZiIgaWQ9IlNpZ25hdHVyZSI+DQo8ZGl2IHN0eWxlPSJm
b250LWZhbWlseTogQXB0b3MsIEFwdG9zX0VtYmVkZGVkRm9udCwgQXB0b3NfTVNGb250U2Vydmlj
ZSwgQ2FsaWJyaSwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9y
OiByZ2IoMCwgMCwgMCk7IiBjbGFzcz0iZWxlbWVudFRvUHJvb2YiPg0KPGJyPg0KPC9kaXY+DQo8
ZGl2IHN0eWxlPSJmb250LWZhbWlseTogQ2FsaWJyaSwgQXJpYWwsIEhlbHZldGljYSwgc2Fucy1z
ZXJpZjsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyIgY2xhc3M9ImVsZW1l
bnRUb1Byb29mIj4NCi0tPC9kaXY+DQo8ZGl2IHN0eWxlPSJmb250LWZhbWlseTogQ2FsaWJyaSwg
QXJpYWwsIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdi
KDAsIDAsIDApOyIgY2xhc3M9ImVsZW1lbnRUb1Byb29mIj4NCjxicj4NCjwvZGl2Pg0KPGRpdiBz
dHlsZT0iZm9udC1mYW1pbHk6IENhbGlicmksIEFyaWFsLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7
IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiIGNsYXNzPSJlbGVtZW50VG9Q
cm9vZiI+DQpSZWdhcmRzLDwvZGl2Pg0KPGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IENhbGlicmks
IEFyaWFsLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJn
YigwLCAwLCAwKTsiIGNsYXNzPSJlbGVtZW50VG9Qcm9vZiI+DQpKYXk8YnI+DQo8L2Rpdj4NCjwv
ZGl2Pg0KPGRpdiBpZD0iYXBwZW5kb25zZW5kIj48L2Rpdj4NCjxociBzdHlsZT0iZGlzcGxheTpp
bmxpbmUtYmxvY2s7d2lkdGg6OTglIiB0YWJpbmRleD0iLTEiPg0KPGRpdiBpZD0iZGl2UnBseUZ3
ZE1zZyIgZGlyPSJsdHIiPjxmb250IGZhY2U9IkNhbGlicmksIHNhbnMtc2VyaWYiIHN0eWxlPSJm
b250LXNpemU6MTFwdCIgY29sb3I9IiMwMDAwMDAiPjxiPkZyb206PC9iPiBNaWtoYWlsIEdhdnJp
bG92ICZsdDttaWtoYWlsLnYuZ2F2cmlsb3ZAZ21haWwuY29tJmd0Ozxicj4NCjxiPlNlbnQ6PC9i
PiBNb25kYXksIE9jdG9iZXIgMTMsIDIwMjUgNzowMyBBTTxicj4NCjxiPlRvOjwvYj4gUGlsbGFp
LCBBdXJhYmluZG8gJmx0O0F1cmFiaW5kby5QaWxsYWlAYW1kLmNvbSZndDs8YnI+DQo8Yj5DYzo8
L2I+IEthemxhdXNrYXMsIE5pY2hvbGFzICZsdDtOaWNob2xhcy5LYXpsYXVza2FzQGFtZC5jb20m
Z3Q7OyBXdSwgUmF5ICZsdDtSYXkuV3VAYW1kLmNvbSZndDs7IFdoZWVsZXIsIERhbmllbCAmbHQ7
RGFuaWVsLldoZWVsZXJAYW1kLmNvbSZndDs7IExpLCBSb21hbiAmbHQ7Um9tYW4uTGlAYW1kLmNv
bSZndDs7IENodW5nLCBDaGlhSHN1YW4gKFRvbSkgJmx0O0NoaWFIc3Vhbi5DaHVuZ0BhbWQuY29t
Jmd0OzsgRGV1Y2hlciwgQWxleGFuZGVyICZsdDtBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tJmd0
OzsNCiBhbWQtZ2Z4IGxpc3QgJmx0O2FtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnJmd0Ozsg
TGludXggTGlzdCBLZXJuZWwgTWFpbGluZyAmbHQ7bGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZyZndDs7IExpbnV4IHJlZ3Jlc3Npb25zIG1haWxpbmcgbGlzdCAmbHQ7cmVncmVzc2lvbnNAbGlz
dHMubGludXguZGV2Jmd0Ozxicj4NCjxiPlN1YmplY3Q6PC9iPiBSZTogNi4xOC9yZWdyZXNzaW9u
L2Jpc2VjdGVkIOKAkyBCVUc6IHNsZWVwaW5nIGZ1bmN0aW9uIGNhbGxlZCBmcm9tIGludmFsaWQg
Y29udGV4dCBhdCAuL2luY2x1ZGUvbGludXgvc2NoZWQvbW0uaDozMjEgYWZ0ZXIgNmQzMTYwMmE5
ZjU3PC9mb250Pg0KPGRpdj4mbmJzcDs8L2Rpdj4NCjwvZGl2Pg0KPGRpdiBjbGFzcz0iQm9keUZy
YWdtZW50Ij48Zm9udCBzaXplPSIyIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjExcHQ7Ij4NCjxk
aXYgY2xhc3M9IlBsYWluVGV4dCI+T24gVHVlLCBPY3QgNywgMjAyNSBhdCAxMDo1NeKAr1BNIFBp
bGxhaSwgQXVyYWJpbmRvPGJyPg0KJmx0O0F1cmFiaW5kby5QaWxsYWlAYW1kLmNvbSZndDsgd3Jv
dGU6PGJyPg0KJmd0Ozxicj4NCiZndDsgW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRl
cm5hbCBEaXN0cmlidXRpb24gT25seV08YnI+DQomZ3Q7PGJyPg0KJmd0OyBIaSBNaWtoYWlsLDxi
cj4NCiZndDs8YnI+DQomZ3Q7IHNjaGVkdWxlX2RjX3ZtaW5fdm1heCgpIGhhcyBhbiBhbGxvY2F0
aW9uIHdoaWNoIGlzIGluY29ycmVjdGx5IHVzaW5nIEdGUF9LRVJORUwsIHdoaWNoIGlzIGxpa2Vs
eSB0aGUgcmVhc29uIGZvciB0aGUgJnF1b3Q7c2xlZXBpbmcgZnVuY3Rpb24gY2FsbGVkIGZyb20g
aW52YWxpZCBjb250ZXh0JnF1b3Q7LiBXZSBoYXZlIGEgZml4IHF1ZXVlZCBmb3IgdGhpcyB3ZWVr
J3MgdXBkYXRlIChzd2l0Y2hpbmcgaXQgdG8gR0ZQX05PV0FJVCkuPGJyPg0KJmd0Ozxicj4NCjxi
cj4NCkhpIEF1cmFiaW5kbyw8YnI+DQo8YnI+DQo2LjE4LjAtcmMxIHN0aWxsIHJlcXVpcmVzIHJl
dmVydGluZyBjb21taXRzIDlkNjkzOTE3OTQ5MSBhbmQgNmQzMTYwMmE5ZjU3PGJyPg0KdG8gYXZv
aWQgdGhlIOKAnHNsZWVwaW5nIGZ1bmN0aW9uIGNhbGxlZCBmcm9tIGludmFsaWQgY29udGV4dOKA
nSB3YXJuaW5ncy48YnI+DQo8YnI+DQpUaGUgZ29vZCBuZXdzIGlzIHRoYXQgdGhlIHNlcGFyYXRl
IFdBUk4gcHJldmlvdXNseSB0cmlnZ2VyZWQgYXQ8YnI+DQpkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYzoxMzggYW1kZ3B1X3ZtX3NldF9wYXNpZCgpPGJyPg0Kbm8gbG9uZ2Vy
IGFwcGVhcnMgaW4gcmVjZW50IGJ1aWxkcy48YnI+DQpUaGlzIFdBUk4gd2FzIGEgbWVyZ2Utb25s
eSBzaWRlIGVmZmVjdCAoaW50ZXJhY3Rpb24gYmV0d2VlbiBkcm0tbmV4dDxicj4NCmFuZCBhbWQt
ZHJtLW5leHQpLDxicj4NCnRob3VnaCBpdOKAmXMgdW5jbGVhciB3aGljaCBleGFjdCBjaGFuZ2Ug
cmVzb2x2ZWQgaXQuPGJyPg0KPGJyPg0KTG9ncyBmb3IgYm90aCBjYXNlcyBhcmUgYXR0YWNoZWQu
PGJyPg0KPGJyPg0KLS0gPGJyPg0KQmVzdCBSZWdhcmRzLDxicj4NCk1pa2UgR2F2cmlsb3YuPGJy
Pg0KPC9kaXY+DQo8L3NwYW4+PC9mb250PjwvZGl2Pg0KPC9ib2R5Pg0KPC9odG1sPg0K

--_000_CH0PR12MB5284F51463E2B68EF5D68DE18BEBACH0PR12MB5284namp_--
