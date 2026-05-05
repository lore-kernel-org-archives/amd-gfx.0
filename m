Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09FBFF885A
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2026 12:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8136710E427;
	Tue,  5 May 2026 12:49:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="B/qqKQhQ";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazolkn19010021.outbound.protection.outlook.com [52.103.66.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12EEF10E9A7
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2026 07:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbHdn4GogTn5tEzv3Cop6+g67AxmcWhi4N/UTvoXC3v0KGN1fjhX45BLDxqG7TspDCyyf5dod+UbS1h1UdMMw/kKcThmKDdJrrBqJGODN9cbGRuBRHFD0vTQhO2j6Mr5dosTx+2H594F9fC90Rw9jx/S9RFL/KnCfzji0+QxaaK+nq9vghxUHQo1vhghObXBp2h4U/sQIMqvsQAmkvzwZo3WoXVhNdTUuaP5QqxIUS9GzyCa9o8GpBpz9JSkurQWMxz4Kr66fdc9buNtay03TTb3wvCSI+150Ef7l5JrCcF6uC7IvZeT1D8Kx+nODR2ndckhCJYR9D2HxoNfdx7TZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UURO0wDt1Zi2Z0y9drsvh04L+iBAQxDi+DgmFLgvyE=;
 b=x/QeGQrTFXyVh1nZ6tt3c9fqSemdh/4cpLB5if7dK7KQnNkR4clKcHPVqKkz3dU3gAfcfhVJaA0hvXViN4KtqzoKc36L691EFT+Dih9WsAteAVjlTaGV7plcaonu+FMlFoaKfSqIQEW+/r8oJZfeiMRKffdbs5Zqf3OM/666PFA21UM5l0VffKk8/LhkRIakfSVVEyRapGAREQvkXHDZ8L14vu3sF/cYv+AC5I1Ws9f4ct6RMmj8Y3RMMiLoTRqPEtMf+7txb4p5k1FV00kV4DzkdaJiS5h0Yh22lqiBPAWdJOKRyHhtyf+Hjp6lh7MqHdiN4pGe/BwDLZDc4eNjPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UURO0wDt1Zi2Z0y9drsvh04L+iBAQxDi+DgmFLgvyE=;
 b=B/qqKQhQw6/+u8EJK58/9n0BYEmpB1h+goSF7sM6ygZQiQDiV3btS3YRIhaeGPZ6FiQhPm/kuRrU1YD8FnlG8pxcTHAcII/kuX4LYbYjr+WIzcC7E9ioIMJJ1/I1zecYyflfjxIhSUmMtyivUfo0HlGKX4raAyf01C5b2Jibe53OePxrgfOlGjiWg3DVEm5zOvhpHvELxwde9oydYs+6EM4o1mcoIalB1BoRruBXrf3taWchyfILPTirfwpKvBNkpypIruTA5erBSWcfymPLtXYaqp46rm3PbOU+1VVk0lRQ8camxiKRVviQOsobpjSaZNYY8XrhHsZcDpCnurAsSw==
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10) by OS9PR01MB16375.jpnprd01.prod.outlook.com
 (2603:1096:604:2bf::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 07:31:32 +0000
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::de2b:6c81:9bd7:99c2]) by TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::de2b:6c81:9bd7:99c2%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 07:31:32 +0000
Message-ID: <TY4PR01MB14432C0C6EF9F858AD4B65304983E2@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Date: Tue, 5 May 2026 15:31:20 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, amd-gfx@lists.freedesktop.org,
 harry.wentland@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 siqueira@igalia.com, =?UTF-8?Q?Michel_D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: Leo Li <sunpeng.li@amd.com>, Michele Palazzi <sysdadmin@m1k.cloud>
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <49434297-d6e8-4eaf-b4c7-ce14134d7869@amd.com>
 <96f4df42-2675-4bda-b0f2-753b09f7a80d@m1k.cloud>
 <ca869a77-4bdc-47b7-a8f3-788224be48be@amd.com>
 <fdb2d4ad-10e5-43ca-92db-f1dad48b7890@amd.com>
 <c4cae811-e3a4-4aae-8501-6de0977566a5@m1k.cloud>
 <6e1f5a30-82c3-4872-add3-7d46a266c37c@m1k.cloud>
 <6ac9fc7f-0493-446f-97e8-760a54e209d8@amd.com>
 <7fdc3c4f-c321-48f5-93f9-17a1a8ded9f8@m1k.cloud>
 <1356e93b-af76-47f3-afc5-29535a9518bb@amd.com>
 <aa3891fb-ed89-48e6-bfb8-86e704447a2e@m1k.cloud>
 <51219a7b-eeec-43f2-a335-06710809415c@m1k.cloud>
 <7a148774-3364-4ce2-9f55-2e77889bfb53@amd.com>
 <a8a3d8d1-ee55-4fc0-ac98-45d70ad0bd6a@amd.com>
 <deb792f8-70a5-41f9-bcf8-1425994aad14@m1k.cloud>
 <4e48ec7b-ac73-4637-9e42-9c328067ed72@amd.com>
 <fe88c29c-3fc3-48b5-b6a2-ee4c210e7a83@m1k.cloud>
 <e415c38b-4102-40e4-a195-0256caf34802@m1k.cloud>
 <9c37520f-ad9a-4fac-bd21-e92f2107ca36@amd.com>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
In-Reply-To: <9c37520f-ad9a-4fac-bd21-e92f2107ca36@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------V05l3wiQttGMjSmIJzWbmAWY"
X-ClientProxiedBy: KU2P306CA0056.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3d::14) To TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10)
X-Microsoft-Original-Message-ID: <89c4b48c-8b14-4cee-a650-83faddce3175@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY4PR01MB14432:EE_|OS9PR01MB16375:EE_
X-MS-Office365-Filtering-Correlation-Id: 1baa8308-86ec-437a-6644-08deaa785317
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|6092099016|5072599009|23021999003|19110799012|8060799015|15080799012|12121999013|8022599003|24021099003|3412199025|4302099013|440099028|26104999006|20055399003|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlNwRGlzRFpESS9YTG85V0RUbXZNT1h6TTZJbElUMTdQU0UrbTNRN0F0b3Vm?=
 =?utf-8?B?bWZNREd3SFFNTlZoSzF2bHF6OHNNdkdKam5wM3FoUjBHdS9YSW0xSHZhOGk3?=
 =?utf-8?B?TEQ2Sm8rWEloU1pMeGRUL09RdEZEVzFnZ0RWckpRQVdOV3VwZm1od2FRL29i?=
 =?utf-8?B?VW53by8zRWFtUlFMM1VxdE8yWkNVUUk1SHNRMjRVTmdPaGhONHh1NjdiK0Ji?=
 =?utf-8?B?QjM1UGk1b3o5QkNwTWlyY3BLYkVWeGtkbmZjeUEyTDZoYng3M2g2MjdzV0JU?=
 =?utf-8?B?YXdTSHFLSE9pazZTZHhEdGNOcnROSlZVRWJHaUFkU1pOUjFHUzh5Vm9SRVZK?=
 =?utf-8?B?ZEVUT2drQkFHTGZqcEU5QVRDeEJmWkpPUWNQcHlXVHpibjEyc1RFYTNYMTgy?=
 =?utf-8?B?UlhNSmZIVDg3K3ZKZ3FGRE80U1hONDlveVpSaCtNaVpMTTArR21EVXhOYXpt?=
 =?utf-8?B?anM4a0hHbjBRQk51eFpDVWpqMlRwR0R5ekd4ZVdPdWlhTjEwbHJUZG4yWFky?=
 =?utf-8?B?RFNFNmZmTmgzK2hFYm40OTJVOUo2NFU5dkR6cHhCUXNSQUI3VmFpaWRwTWJU?=
 =?utf-8?B?aS9NRTcyV1Y0c0ZiOWswZUtsM01wcTZkU2NZc0hQMXhoeHk1Z1dzVktHYW5W?=
 =?utf-8?B?R2s1bkZKam9zdjh3UE1HRndxWGJrNFZsMUROMzBKeWYvOUlrWXB6cHdMaFkx?=
 =?utf-8?B?T3phTFU5U0ZRZG40Y3V3eGFFOXF3NnM4UGVVVkpPWC9YWlVQOW52cGdycTVy?=
 =?utf-8?B?VTNkekVuN3lpMHVtRUVlbThDNVJJM3dhQVNVZzBudDZtZFdlSTRpeGhObmRB?=
 =?utf-8?B?dFVYbXM4NEVNeGZGQmNaZTNEczE5b3ptSXhBeHZQQUdhcDUvNXJ1VmVLSkFi?=
 =?utf-8?B?L1lRVkRoelJFQ3pNVFFqaHVVcHhLS010SmQ4M0pkeWtaK3dGYmtLRE9jaUlK?=
 =?utf-8?B?eUdMb3M4RUZncmtNaDV2a3RkdldDa2tzYmdlWjBCcnFLL3NmSWx0eTRmdno5?=
 =?utf-8?B?UGZWRUcyREtZM2ovZFpkU1ZaSXRkTTRDZnNlM3dzZTZQSFFLcm9tZnVFSXk1?=
 =?utf-8?B?a3NOUWozOERldlR0b0EwclRacWUwM0NNWnpzd0daZkFpamdQeWVzeHdOaVdz?=
 =?utf-8?B?RVh0Z0xlMWNBVlZYYTN2VzdVSnJOdkhSeW40NllVYi9HRGdmMXgxRWp3ZGsz?=
 =?utf-8?B?UWxMM3ZZcXlMMWZNOW9zTmU4RTdCeW1EdE4wa3lpZFE2NXRkUG9JZFZ0akFQ?=
 =?utf-8?B?MXhteTJvTm0yYWRqaDgxZGlmYWhYS2pRU0JkenBuOVBLcGJqYk4yaVlaSVQx?=
 =?utf-8?B?MHFuM0NIQkhycXk3UW1hUE80dGdiYmZiekJneWlQUDA0UGJsdGd2eGNSSGVm?=
 =?utf-8?B?aUI3Z0w2aEFmVFJjb2tOVTlDWU90RHZIclpvZzRMY2RzQ2JibkhIY2EwWTJr?=
 =?utf-8?Q?McvvqNN7?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzlpWGNoUGFNU3B1d0tkaHA1MjQyU3JxdHR0RUFVb1h6Q2c5VDR0VHhPVm03?=
 =?utf-8?B?a1BHS3ByL3BSYTZCemxDR1BJT0Y2VFRNbVZXWnBlWVRnT01KRklWSjFpK0ZK?=
 =?utf-8?B?K3hSODNZNnkrdG1jZkppWmc2RnYzOE8zaUFKajRHZldRZ3dWNzRobDRxbUNi?=
 =?utf-8?B?MU1EbnFHMG92ZDZYbnR5RjRKdnZtOWNoU2xteEZwNzlTeU83WUhITUNqZFMz?=
 =?utf-8?B?VE04cGt5SlZTOUJuNktLVXgvTUlMTmFhd29aelNNMDZtcWpwMG5XbmJ1VFQw?=
 =?utf-8?B?dW9yVTFDelR3Wi8wT3hzNmsvS2YrUk11ejdNMjhwejRXeXlYOEVTbFc0NE5l?=
 =?utf-8?B?MnJXRWI2TXFDSVhCamdaT1ZkWkJYWC9OU2tnNkNYeXV1Tm1hejM5TFdpL0RV?=
 =?utf-8?B?VG1UNVBVbmY2eUJWRm91SVJCRmRnL212TWIxbGNzSlBwckIzMnVDbDBGRzJo?=
 =?utf-8?B?Z2V3cEZ1aE8xSURUSHh4YStyWnVkVytoa1hVNi9CdVUvYm9GejBPVm5SZ2xv?=
 =?utf-8?B?bnBOdkorMFNKVGtUVzRXamlQOTc3SVFxdVJ1ZDc3UFFXaTNRa2ZMeGQ0aUs2?=
 =?utf-8?B?ejFYa3hlMGJOQW9tVDI0Vm9McWE4ZkRaNjZXYVR6OEMwaGdSaGsvVHZDQmwr?=
 =?utf-8?B?SVhLSXZoR0puL2JuYU5ja2R2blJEQUF3RDdPTjYzUnpoQjVtTVhNSSsxR3RH?=
 =?utf-8?B?MXcxRTRGNVcxeDFvMEZVMklCVnYvYjMwZERPaGVZb2ZMK3JGQ2FVZkovMk54?=
 =?utf-8?B?NFRJZWJHSUY3T3NLMlVubVNGOXNkNHVQMG5MWFVPeWdZeXdmL0d4MmtwZTE4?=
 =?utf-8?B?NlJyQmhwc2JQaXlkcytaNGFJaU5zMHRhdkNpdDd2eFR2TndJWUR6WG9URmRj?=
 =?utf-8?B?U3VXd3FObklKMkRHRC9JQkpxMnBjR3pHWTh6U0VOaHgyQ0JEdEkrbmh2eE1k?=
 =?utf-8?B?MjFDV0dKSndBNDBha1JvN0ZKa3ZjL3M5YmNsejY0NXlhSXZNUG1GeDMwRW8x?=
 =?utf-8?B?R0hWWlFXb2lET1hTNFdGQU00bitzQXhBd094QjBrRUp1dW14eDlNOURhZFhh?=
 =?utf-8?B?V3F4eHdDTVVndU5zTXhpWDBzSGd1Y1ZidjdjQUJsNlh0OWkzdmY4OXlkV1Q1?=
 =?utf-8?B?VmIrbytYS1NNdWNhZFYxZ01sb3dRbk9IQmRqdDgveCtyZEdCbWdkc084TjhZ?=
 =?utf-8?B?L0RxQVc4dTZFdHYrdGFWZ0htRFZDZjUzcS9hUEU2OGpodWh2QXpqVXhXT0Fa?=
 =?utf-8?B?N2EwbnQ5L21rR1plVWtpMFViZC9DdTRucC9EM1MrNk90SzQySWlGckhWYUJT?=
 =?utf-8?B?UWc4QmZsRDYrODFqbUhQcFYxQml2K2lhQXk0bFh5R2JaNzNvMVhSOStzZXhN?=
 =?utf-8?B?MlR5WXJXdVR0dHlkQXB6WjhxYWVJRDBETGQ0QncyMElmdHYrM1RIUkZmNTVl?=
 =?utf-8?B?V0VCZEZHTkxuMU9oSUc2WWlxeVFOSkFiSHY1TFQ3ZFY5VlhyYWZOdUwwY3dn?=
 =?utf-8?B?RzVpQ0c1T3BZa0dXSHlsdEkzZHkzWjBzVHJVWVlGa3V4RmFsWmg2MlJYZUxi?=
 =?utf-8?B?anc1QVhtaVhjcnFFQ0p5aTFZY1NYSStJcXlndzRIc00rMjdiRE5jWnNYSGZa?=
 =?utf-8?B?NC9qVzREeEJIKzE1VU0zazdjNVVRYU4yN3Zzam9Wc3JnTzFnOUFFSE1UdzVr?=
 =?utf-8?B?SDlmcktXejg2N0FNS1VZVk05R2FMTTAzeFljd1g0M01oUnAwbEZ6cDZsTyt2?=
 =?utf-8?B?c2tCK0VhYmZRRXo5TG8ya2NCbEV2TGE0cHJQcWY4Nk0zNnRSZjIwOHRGZEtl?=
 =?utf-8?B?YXVNdXFvbHRiSnJDM1Bod2pBNUtaS1dEam5IYWY4NzNlWDBxY0tvd1piMDV0?=
 =?utf-8?Q?Xwr/KsflLKJ2q?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1baa8308-86ec-437a-6644-08deaa785317
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB14432.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 07:31:32.6936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16375
X-Mailman-Approved-At: Tue, 05 May 2026 12:49:49 +0000
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

--------------V05l3wiQttGMjSmIJzWbmAWY
Content-Type: multipart/mixed; boundary="------------usCnLlaQJjpybHAvLX0WpyZ6";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Leo Li <sunpeng.li@amd.com>, Michele Palazzi <sysdadmin@m1k.cloud>
Cc: wiagn233@outlook.com, amd-gfx@lists.freedesktop.org,
 harry.wentland@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 siqueira@igalia.com, =?UTF-8?Q?Michel_D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>
Message-ID: <89c4b48c-8b14-4cee-a650-83faddce3175@outlook.com>
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <TY4PR01MB14432450DA5BDEFA272476A2F987FA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <49434297-d6e8-4eaf-b4c7-ce14134d7869@amd.com>
 <96f4df42-2675-4bda-b0f2-753b09f7a80d@m1k.cloud>
 <ca869a77-4bdc-47b7-a8f3-788224be48be@amd.com>
 <fdb2d4ad-10e5-43ca-92db-f1dad48b7890@amd.com>
 <c4cae811-e3a4-4aae-8501-6de0977566a5@m1k.cloud>
 <6e1f5a30-82c3-4872-add3-7d46a266c37c@m1k.cloud>
 <6ac9fc7f-0493-446f-97e8-760a54e209d8@amd.com>
 <7fdc3c4f-c321-48f5-93f9-17a1a8ded9f8@m1k.cloud>
 <1356e93b-af76-47f3-afc5-29535a9518bb@amd.com>
 <aa3891fb-ed89-48e6-bfb8-86e704447a2e@m1k.cloud>
 <51219a7b-eeec-43f2-a335-06710809415c@m1k.cloud>
 <7a148774-3364-4ce2-9f55-2e77889bfb53@amd.com>
 <a8a3d8d1-ee55-4fc0-ac98-45d70ad0bd6a@amd.com>
 <deb792f8-70a5-41f9-bcf8-1425994aad14@m1k.cloud>
 <4e48ec7b-ac73-4637-9e42-9c328067ed72@amd.com>
 <fe88c29c-3fc3-48b5-b6a2-ee4c210e7a83@m1k.cloud>
 <e415c38b-4102-40e4-a195-0256caf34802@m1k.cloud>
 <9c37520f-ad9a-4fac-bd21-e92f2107ca36@amd.com>
In-Reply-To: <9c37520f-ad9a-4fac-bd21-e92f2107ca36@amd.com>

--------------usCnLlaQJjpybHAvLX0WpyZ6
Content-Type: multipart/mixed; boundary="------------VzSIO7u8120k10fsyw3l0gHF"

--------------VzSIO7u8120k10fsyw3l0gHF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgTGVvLA0KDQpQZXJzb25hbGx5IEkgY2FuJ3QgcmVwcm9kdWNlIHRoaXMgaXNzdWUgb24g
bXkgNzgwMFhUIFBDLiBCdXQgSSd2ZSByZXBvc3RlZCB0aGUgbmV3IHBhdGNoIHRvIHNvbWUg
ZmxpcCBkb25lIHRpbWVvdXQgaXNzdWVzIGZvciBvdGhlciB1c2VycyB0byB0ZXN0LiBXaWxs
IHJlcG9ydCBpZiB0aGVyZSdzIGFueSByZXN1bHQuDQoNCkJlc3QgcmVnYXJkcywNClNoZW5n
eXUNCg0K5ZyoIDIwMjYvNS81IDI6NDgsIExlbyBMaSDlhpnpgZM6DQo+IA0KPiANCj4gT24g
MjAyNi0wMy0zMSAwODo1NywgTWljaGVsZSBQYWxhenppIHdyb3RlOg0KPj4+IE9uIDMvMjAv
MjYgMDE6NTIsIExlbyBMaSB3cm90ZToNCj4+DQo+Pj4+IERpZCB5b3UgaGFwcGVuIHRvIHRy
eSBkaXNhYmxpbmcgc29tZSBpZGxlIG9wdGltaXphdGlvbiBmZWF0dXJlcyBtZW50aW9uZWQg
aW4gYSBwcmV2aW91cyByZXBseT8NCj4+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYW1k
LWdmeC8xMzU2ZTkzYi1hZjc2LTQ3ZjMtIGFmYzUtMjk1MzVhOTUxOGJiQGFtZC5jb20vDQo+
Pj4NCj4+DQo+Pg0KPj4gU29ycnkgZm9yIHRoZSBkZWxheSBpIGhhdmUgYmVlbiBhd2F5IGR1
ZSB0byBidXNpbmVzcyB0cmF2ZWwsIGFueXdheSBzaW5jZSByZXN1bWluZyB0ZXN0aW5nIGkg
Y2FuJ3Qgc2VlbSB0byByZXByb2R1Y2UgdGhlIHRpbWVvdXQgd2l0aCBpZGxlIG9wdGltaXph
dGlvbiBmZWF0dXJlcyBkaXNhYmxlZC4NCj4gDQo+IEhpIE1pY2hlbCwgU2hlbmd5dSwNCj4g
DQo+IEkgc2VudCBvdXQgYSBwb3RlbnRpYWwgZml4IGhlcmU6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FtZC1nZngvMjAyNjA1MDQxODM2NDkuMTY1MTMxLTEtc3VucGVuZy5saUBhbWQu
Y29tL1QvI3UNCj4gSWYgeW91IGdldCBhIGNoYW5jZSwgY2FuIHlvdSBnaXZlIGl0IGEgc3Bp
biBhbmQgbGV0IG1lIGtub3cgdGhlIHJlc3VsdHMoKik/IFRoZSBpc3N1ZSByZW1haW5zIGVs
dXNpdmUgb24gbXkgZW5kLg0KPiANCj4gKCopIE9mIGNvdXJzZSwgbWFrZSBzdXJlIHRoZSBS
ZXN0b3JlIDVzIHZibCBvZmZkZWxheSBjaGFuZ2UgaXMgbm90IGFwcGxpZWQsIGFuZCB0aGF0
IG5vIG90aGVyIGRlYnVnIHBhdGNoL2tlcm5lbCBjbWRsaW5lIGFyZSBhcHBsaWVkLg0KPiAN
Cj4gVGhhbmtzLA0KPiBMZW8NCj4gDQoNCg==
--------------VzSIO7u8120k10fsyw3l0gHF
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
8e9FddsLlMSoVV3z1s8dA1DK95ykSdIFtVZT
=3DoX+f
-----END PGP PUBLIC KEY BLOCK-----

--------------VzSIO7u8120k10fsyw3l0gHF--

--------------usCnLlaQJjpybHAvLX0WpyZ6--

--------------V05l3wiQttGMjSmIJzWbmAWY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmn5nMgFAwAAAAAACgkQX75KBAfJsRkV
FA/+KoYYXYNn2guDRwXpmhZXFVn10Xrm0/fkIfZAipowSkx9chGQXW3x4bURuI+TVuQjHzZ1/+h3
vBwKFENfr2LADNo9BiL6bbkPJxynxrqQDq6Y0lfGN56p34NskB1m1gZ7ZtE6OA6zd7z4ETvIARJj
sFH8DUJph4Fm/lIqLkoqb2mN/Fn8Gm3iqBXf6s/P+VCOJ43GqmGRtkV5a2shB/yXsZa57gdBI7y6
JdAgdds23btOT4tgc5J33oam8vmw+1yJGh3HXW9fQU/urHOCOdTTWxwuRvqU5Tji9T0cUCXbWj/f
PITYS/T8tjnnuLHWnr1qTZRZgX5u/JN+7lUeNI9Ch1T3gv8XBvjfYR5DJCXG4moypb+QtUQcjW1h
59Zk9s1WCcOMcKkb6Qlh7az1UNr+BsllfeOkJAwm0ew72JnuUQX8wJjIpB7+e8H8IowxDvot4ofK
3xPl/Bj/jJup3n9rMGVFiYyeS+457z5CsqKmAsXI8YAenZymFeIDOAM+P5fDXlXz5yZu4I9zAXEI
W/a8TZuxmPM3wUGFUWAVDoN6NNSBAuqXUKLx7/fSy9EdbxfaQpKejsNo0ArFt/iTCz9YKf3mcZzQ
cIFV18ek5P0mmmtW5VK6TWLrbXG55neE7WZIEi13Ca3xOukrnTuhYTOI8QbHh7DvlauHCCLzE1QN
k2g=
=9sGK
-----END PGP SIGNATURE-----

--------------V05l3wiQttGMjSmIJzWbmAWY--
