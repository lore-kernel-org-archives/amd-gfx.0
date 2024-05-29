Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43022C27C43
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 14:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D850A10E849;
	Wed, 29 May 2024 14:31:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BrNRQvmr";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A21610E849
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 14:31:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eh0mavt/V5s6f7EWtZ27ycay9nv1qKw+CzN/+Adeeu9wZzEb7jUZLSc73p8VKfkO24OhSZ+uzPC6uZreWia7mW5tZJHxYfgiCO+FF5CZMRsfpg7fgsbLzrGQAAupCXqvNtLaCCJL2fySbLPgxct8Tlr3ukUMbf+bY82ZwYqzaE/GxjSa5PsD2I8KnE+hb2HzYaRgsm3to4koHMEMQnTATbwNPzx0m94YvQ7WggKP5vgT6N95srKivKEcViaw27kM81HYDICcPHQaNBxzXsEyluv3R2yVKC3dkHntnMn/QpmH1MmSBH+nfMYhfXKgJscVrTKXnamHSw3BEnqUqbcaYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEPzU0m0l/v5aYctHpPrsNEVKKQGOT+J/SJULpZ6Zy0=;
 b=F0ixztR29UU6OgL6QO7E3SYohaIZ5SBpPlIhXGT2pSWCVcu5nmPqRLNmIbW9/fnkIjePrS+z8WGWxQ2EYTx3mx0G6gzHxBKwtIAXTjc86Ca/dXdLXdrotUex0bYYGG6xTip3zvpBs5No6Kjrtt2aIZeyyV+doiYG80wj9VreqvjlCpHxWuvHls025gliUfVt/S0oqLRHhuB8kj7HJ5rRF3n0wCw+sXdri0A7E156A27cVynf9BQXFAlb4KyWNFgRKsX/vHJHp7NkOvoupmtCyLaOWstVihu6eTANvtov83zf+2PemChfHmW5yVuADubhiTfFLKGl79MlLcsbyRRwow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEPzU0m0l/v5aYctHpPrsNEVKKQGOT+J/SJULpZ6Zy0=;
 b=BrNRQvmrFScVwjHVFtvKBlETftiTrUUFwCH0baOrea/fKRIjOXj52kyxoHqPSaQAoICHNIY+fYrxSwQEOsbJyvYlCp/M7zr3NypUnwCUK5vHH+Mk830XZe/TKoq4oP1wpwQE75nsIcNX6IQxTBfoPMbrT9BH67EwJ7WhIBqX2yA=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by PH8PR12MB6964.namprd12.prod.outlook.com (2603:10b6:510:1bf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 14:31:26 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%4]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 14:31:26 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 03/10] drm/amdgpu: abort fence poll if reset is started
Thread-Topic: [PATCH v2 03/10] drm/amdgpu: abort fence poll if reset is started
Thread-Index: AQHasSPj5dWiHd7YP06y4F37f071D7Gtw2cAgABr2bCAAAeagIAAAj7AgAAEfoCAAAmBwA==
Date: Wed, 29 May 2024 14:31:25 +0000
Message-ID: <SA1PR12MB859960F8F2B9B22E726EF6D2EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-4-Yunxiang.Li@amd.com>
 <32ab9756-ca28-4ec0-919a-1d1df950aee7@amd.com>
 <SA1PR12MB8599F850C7BD44B5F66D80E8EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <a1e40066-f980-4490-a0b9-d8f3be34ad8f@amd.com>
 <SA1PR12MB85996538350B30F80330C0EAEDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <b646408e-9b50-4e2a-b2b1-ab1ff9f4b366@amd.com>
In-Reply-To: <b646408e-9b50-4e2a-b2b1-ab1ff9f4b366@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=951c1c4e-a1b6-4049-82b5-478558ccdb72;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-05-29T14:30:12Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|PH8PR12MB6964:EE_
x-ms-office365-filtering-correlation-id: d64a76fc-1544-4578-f603-08dc7fec056c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?N3RPdHhRTExhNXNmMG5vSXVCek9pSng2OVdYZnh0bGZvRG5BeC9tYzFnZ250?=
 =?utf-8?B?L2MvdFNDRXpseHRVbTVTSEs4K2w1eEJWaFJET1Y0WXBZZkc1d01Ibjc3RzJ2?=
 =?utf-8?B?dDhxTy9qWFdKYk9pUDlxZ016aXVCOEc5Q1FYYWE5bzh0dGdlSXIwbW4vUUpD?=
 =?utf-8?B?YmNxNlZyQzdleTk1NE9EM2hUa1JqODJFMkhpandMSW9jaWtZZ2tyMG5xSS92?=
 =?utf-8?B?Q2pWSUhrWGY5cDE3OGlLV2hNaE9rOW1tSjN5SUUweU5hY2Zxc1ZDQ0NvTkp4?=
 =?utf-8?B?eGNadEZvaW9NNHlCSWpCanJFU1dYNHNCTGErbEpQYVZJanVuR3Q1bHlVOGpU?=
 =?utf-8?B?QmtRTWpBZGtNZ0Y0QThyTVROWUhqN0lDWVZja3EvUmpMN0dYMU1IZFFkNk1n?=
 =?utf-8?B?aGlFNkxWVUsvdUdBbVpqMmVxY2gyMHJNb3FaUkExQmhTVFllQmhLV014Rm51?=
 =?utf-8?B?Mlk3RytWNVdMdzlmSFVUdDVia2tMaGxHQ05wV1hHT2VlNVBSN09YT0JhT2RK?=
 =?utf-8?B?WGJ5USttMzlkUkdpNG11amJ1d2diWElKWWFmcDFPVWhjOVBFVlZGT2ZHbXFU?=
 =?utf-8?B?azJKKzVRK2VzTEgwU3A1T1BsK0d3TWQ5Tk4weWR1c1d5VERETS9uczlmZnFK?=
 =?utf-8?B?M1oxaUJ1NkpMWU5ya2FFWGs4MGd1OHpyOEY5L016ZjB3THV4bUw0dWdSaldV?=
 =?utf-8?B?V1hwQ3ZpNzVlNkRuQytYTzQxMzl6bCtFdUlmSERBMXU5N0FHcnhHbGtvUVQ1?=
 =?utf-8?B?aTJ0dHowWDY5eWVINDA4ZkNrVVFqWnZ2QXZKazRacFFDUDlZKzFXbTVRNWxD?=
 =?utf-8?B?U0hwTFZRUnBSeHBOVWh2SEN4S2JQeVUwNmVvcU93ci9KUkhUZ2g1RzAvZTl5?=
 =?utf-8?B?N3dwaSs2YzRxdk5XbURuamhONWc1aThtR2libm5YUzV6dUxHRXFJeVhSNklS?=
 =?utf-8?B?ZWhraUZGdG9FRVdkeU9FNmhzUnZLZkxWb011dzdTQjNDRHJFa0lya3JEd3J2?=
 =?utf-8?B?R0RoakM2dkZQdE5qOXkwUTI2bFV6NjJHdFhYeVRiaWYvZ01MSDNBMURKc2E0?=
 =?utf-8?B?R1JHOUpyTzJSUi91YmlESkdNTEQyL3piZmdid3dRNXV4RllSUmRrVGY5cjM3?=
 =?utf-8?B?VzhNZzMxUGRYOXBrUitpZm1DSEl1dDY5c01BajRLVGlONmR4K2lIWWdSMGgr?=
 =?utf-8?B?YTh5TDlCc1RqZXNNdjBvUFhJUFBYWlV3N0tadFVUWmxBeE1aWEpjTHlrdWZX?=
 =?utf-8?B?ZWkxNTFQWlBRQjFiN0JuSm81eE1DL25aaWVoQmtDRElnaWR1eEU0QTNUY1Fi?=
 =?utf-8?B?WUZzSkpNNW95UTZPRkdteUE1N3V1VGx6UDUwdjdSYk16V2ZodHpiL2Z6OEF6?=
 =?utf-8?B?dWhaekN6MHErUjlSK3JzZ1c2WU9WcHFhZkYrbEdRQWEzSDRzT3lMNzJsL3VE?=
 =?utf-8?B?bzJxcE1RVzFVeVlwSHI3WERhSE03NUcwSnFMMWVBUjloZk54aHl0bHNHOGk3?=
 =?utf-8?B?cjQzYy9TM3VwWjVsWXA4MllvS3ZGY1hBbm1lR3RXSXh2TldPTTFwR1F6eUtW?=
 =?utf-8?B?RlpaY0RQRXMwa2JaZUFZQmt0UW9YQ3FBV3NLMXUwalNSNktRcEFBUDIzbnhP?=
 =?utf-8?B?MnVKejFpU09iMG1BQXpoR3lQWjNKOEN0RE44ZzZzc3BlUzV3WmtnWW9Ua2Fn?=
 =?utf-8?B?SEdnYUdqcmE4d2JVTERnVHdIZkQ4T3JzV3pkQnlSenpCTmJUcDRhdVRYR2hG?=
 =?utf-8?B?ZGg1NEFta05kTFV2K3dQMGpMdndaV1Z6TlM5MEZqUFdFdCs3NklEOE5kbmJV?=
 =?utf-8?B?T2VnNHI1bVNBWHlpYXJxUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0wwb3pER3JxSkk2TVppK25hb0hpQkdzc1cybzVKeC9PVGwvVDk1bTgrZ055?=
 =?utf-8?B?VFNhMTlqWDhnMDBaNndqcDVodWhXYVk3Q1drTWtjSlJvZXJwRTFHNGZWanRM?=
 =?utf-8?B?VitEYnU3eHoxSHJpRWdEVmNaSzJ5NWUwNVdoK1I3Y1RzNUl3TWRXSzNjMjBi?=
 =?utf-8?B?MmlXZ1ZKYWR6bkxmdjc3OW1Uczg3eEU5TEE4cEdFRWZTK3lJTFc0cDlEc1p5?=
 =?utf-8?B?U3d3TTZKTXd0MEc2WG1VemlkektHeWJkcElubkRjYkNSbW1IZVVsejBlY0k1?=
 =?utf-8?B?ZVlDNmNYaEFiaVBWK3NWWDIzWEhKOE55dFVCM0J4SzVWSlVhUC9mRGk0YUI0?=
 =?utf-8?B?bUZpYjB2WWVsVXkyT0FobjZvOXJNbUlnMDcreVJZOVE1WmFKaTZLa1hGSDJv?=
 =?utf-8?B?ZTdkQ2N2TlhibktZTCtndERBdVM2LzRQOFhELzI3VVVpamdEcXgrdUVCN1px?=
 =?utf-8?B?UFpqSkxkTEgxdUpiNlhQSzcyckpGbEtIb3padmV2NG9iL0FVN00vS1A1Kzl0?=
 =?utf-8?B?bVZhTWV1YXhBUlRMTXRaMk9GTmttZkdBWkJlL0NScXFJVHBNZzNURVY4RGJh?=
 =?utf-8?B?Z0pIUXJka0loamVXSnY3VVAyN2FIbHVSbU8wUXpVZnFudmxKT21WVFc5ZHZz?=
 =?utf-8?B?aGM0RmFPaXhtM3J5OUIxWlBLd3BKcDlZdWxYaEJnV2NVK2l4QjNrTXBncW1m?=
 =?utf-8?B?MDAycXh5T0dPU3pIQXpDeWV5RHFEM3hIY3hoQWJDRjB0SVl5RjhtUzZFb1lW?=
 =?utf-8?B?N0s0ejZmZ0twVFJKdk9hZFhodkFjelhrSEtVQ3orL0JHQUJ6R3VOamY3bjdZ?=
 =?utf-8?B?K3VKWTZBMVkvM1NXUW15UFJOSWE3N3dUdDZsMFc5TXViaVJ5TEhMcFFSMlcz?=
 =?utf-8?B?blpJNTRsTDFPTnhxbURLRTJta2RJNFZKdnRZOU1rQmlML0ltcmhMYWFjdGxu?=
 =?utf-8?B?ZUdRVi90V3daalFqU3JtM3BCWDhwakNMZnkzd3RnQkNabDZyNkFNc29vVmdT?=
 =?utf-8?B?YnR3WkxyQzBTSXpZOVlxeHNXaC9sYXJoeEpSb25wK0hvYkR1ZXlRZ0w4UmR1?=
 =?utf-8?B?Z3doZURWYnFEbUNxQ3RrMkZvZnNHSmNRL2FFYmZxQlZTVnJ1aWlvcFBqUytM?=
 =?utf-8?B?UjVjS2RUUTEyZHora1JLYXU0NGtaNWtENEhnQ1JUQ0dFZ01lZEwzVHVDZnV3?=
 =?utf-8?B?cUFZV1dlUE1CVkQrdTRObUJXc2lJUHVSZ3lYRXdZU2o4WHlWK3Rjc3o4WHds?=
 =?utf-8?B?SEhDbjNaWnJmaUVkRVc2UzRXbVRPbGxqeVFiTGF2NXJ5T01PYnhYaFJMaERv?=
 =?utf-8?B?OWt6anRqeVVaNmNnMFZ3UWNjUmR1eUxad0FwcXc4WEU0QWVJN0I5QUdLUkZk?=
 =?utf-8?B?amdIUTRXTlNnZG9QSk1TTFdWSytoOTBtcTNhNjY2aUZvS0ZkdlVVYUxDbC9U?=
 =?utf-8?B?WVhjQ0kwVUZ5NmxjZGc3Y0lRUG1WWkk5N3ZNNytXRkN4aHN6dWFoRENTWnVa?=
 =?utf-8?B?RmlMWmE4OXlYS1ZVSENxMDRXWUdQWlcrQ0FDTTFwS1hGaUVsSm0yRXlCNHJr?=
 =?utf-8?B?emZJTlRYYzJQR05DaC9CMktnYmttamFJdWFvdGJ5WlpMYmkya2p1b0JNUm5z?=
 =?utf-8?B?dVM2U1o4aFhBeU85S0wvaUhBY2NCSFp3M1BPNWJ6cU9IVXo0a2xwTFBvc2Er?=
 =?utf-8?B?Z1BqaXBVWlhmcm9ZWWtTc3VwMUZ6bmdpYXhPME82RDlwNXVFbUk3TC9jdkl5?=
 =?utf-8?B?L2VuR1ZPbWgrb2dKSy9wTk5rU0JpWW9WTTRQOHZpdDBvaFdLY2h2eTErT1Iv?=
 =?utf-8?B?disvTm5IQ0thUEIrYWoxMWZFbWdmL0tnamVKUXBTRXNQUStLUnFsZVlhUWJj?=
 =?utf-8?B?Wm9WZFNwRUJtL2dmOFVJYmp1cXdEVzRSSGFPTGpjM1NxOTZ1azFiMmVFdXg3?=
 =?utf-8?B?R2pGdkVhZ2l3N0lma04zeERpd1ZnclQ0OFN6VnN1cG9KRmN5V1RFamxZc254?=
 =?utf-8?B?ajB1WURsVTM4VTFKcEJDQ0J6R2dqOVRlaHVhbUpTZTBpTDlvYUVlek5PdGE4?=
 =?utf-8?B?NXFhWTlsZmppNlowRDVKZ3N2SWZFU1ZYWmkwSGlVVEpBTkRmOHEwM2UvMkg5?=
 =?utf-8?Q?moFs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d64a76fc-1544-4578-f603-08dc7fec056c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 14:31:25.9428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gk0cftqNzRGGRxBPf0DEOreZ1VLvBdiiDjK816TPTsVsokLjUgx+RbnxaXtQZWXgMrlgngWE6o8KTacvTnnxfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6964
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

W1B1YmxpY10NCg0KPiBUaGUgcHJvYmxlbSBpcyB0aGF0IHdlIGRvbid0IGZvcmNlIGNvbXBsZXRl
IHRoZSBub24gc2NoZWR1bGVyIHJpbmdzLCBlLmcuIE1FUywNCj4gS0lRIGV0Yy4uLg0KPg0KPiBU
cnkgdG8gcmVtb3ZlIHRoaXMgY2hlY2sgaGVyZSBmcm9tIHRoZSBsb29wIGluDQo+IGFtZGdwdV9k
ZXZpY2VfcHJlX2FzaWNfcmVzZXQoKToNCj4NCj4gICAgICAgICAgICAgICAgICBpZiAoIWFtZGdw
dV9yaW5nX3NjaGVkX3JlYWR5KHJpbmcpKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgY29u
dGludWU7DQoNCkFoLCBJIHNlZS4gVGhvdWdoIEkgZG9uJ3QgdGhpbmsgdGhpcyB3b3VsZCB3b3Jr
IGZvciB0aGUgbWVzIGNhc2UsIHNpbmNlIGVhY2ggc3VibWlzc2lvbiBncmFicyB0aGVpciBvd24g
d2IgYWRkcmVzcyByYXRoZXIgdGhhbiB1c2luZyB0aGUgcmluZy4NCg==
