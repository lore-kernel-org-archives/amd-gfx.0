Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC4AD4A5EB
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 05:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 005F910E096;
	Mon, 19 Jan 2026 05:27:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i8W1lrij";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010015.outbound.protection.outlook.com
 [52.101.193.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD30B10E096
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 05:27:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j30n8B7pOXO8kj/3cj++gOizNwHxswMybOWxenbf6ryW6KgQkNZN5n4K+07f+biBmYIa4rRNhr9lt7FOwI9izYxqjtAsUkxKp1gxeH8+7U9FLYTz9ZrCdgATUBLNn7Ww0BHXh1m/KP3cyFaL0yq1U2ZGVaD7enqEy0djvKSp2oyHddfuyEua10L2ogc84ZApWo5qLDLLCHzacxEScQ2lqGmw/YKm2Gc6TEZbARgudPj+642oY1BfYqrvzdayhAyehtIRIiiNY9/tGq8Cz4bUvb3YbC/jDN68Bxjq4u/ttF26kvPwb4TzALqMmo8NnB8eSKdA3IVhwNUv2ePFKmBgbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzwxD7ki7lpHQ4nzjGm0ZKJL2JLO3H6aPd3lXetoTXE=;
 b=OHVZk02qKiuGW8aLCFWJigT0pAXO8FWFlHZESmG9mbFJjMMKDB8Pw/q66wUdV4tU2YbTdPns6vOHuFnhswFvbhkkAHrdQzJUnVW5cB32p2xkoSoiGETmTIxpyDD8vZLlLkddK2WeI9CKSSIZpNob0nPkq4gxfy9TfDK939bK6CaqDO1JBCw9GesWLslcWw/0rGhsMZYGRmxmXul39K1BaP35XJOK21GwqSlhmavmhZHaUKJGrXtPI3SfjQOlTyyO8UVlpehCY+YlOHyDkNA3u4Er6uu91P1NwyLYZrCfXy//y+SJc7PYnIoG4eZzaitXPg6qawN1dv/mBuQY3KIS9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzwxD7ki7lpHQ4nzjGm0ZKJL2JLO3H6aPd3lXetoTXE=;
 b=i8W1lrijCDjCNWfYlYgnuM+6CKU13xx9K3OPXZnS9tC0mv0O9Rye/WYgRGpxuCrP95AErtE7GwNKQYMA/q0YBHSqdlfcrDbNhBQYyVSBEE38ZcPEVJNXO/sum7Ax+wLXDPJ2AcE1pwD/JSraxZcRfr9PQpOmVKm30KwDR+1AuWk=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Mon, 19 Jan 2026 05:27:10 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 05:27:10 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?=
 <timur.kristof@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>, Dan Carpenter
 <dan.carpenter@linaro.org>
Subject: RE: [PATCH] drm/amdgpu: Fix validating flush_gpu_tlb_pasid()
Thread-Topic: [PATCH] drm/amdgpu: Fix validating flush_gpu_tlb_pasid()
Thread-Index: AQHciHoQTQHvCiULiku9PJWO956CHLVYvGTAgAA6LFA=
Date: Mon, 19 Jan 2026 05:27:10 +0000
Message-ID: <DS7PR12MB6005D5AA955F34114114F779FB88A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260118125746.40221-1-timur.kristof@gmail.com>
 <DS7PR12MB6005F0626EDB392DA9F554E3FB88A@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005F0626EDB392DA9F554E3FB88A@DS7PR12MB6005.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-19T01:55:28.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CY5PR12MB6083:EE_
x-ms-office365-filtering-correlation-id: 7d33afe4-f88e-4c15-2ad7-08de571b650e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?cnpFd3FLK2dSeUV3T1JHaTd6d2tmd0tSNVMvYWxRUFR1L1NBdHkydGRoM0FJ?=
 =?utf-8?B?Z2Mzb056OTFodFVpdHoya1I4b3NDcEZwM054RUdTMFVlVjZhUWdNUi96djF4?=
 =?utf-8?B?dGRXejYyNUVmVkNvOGltTGRpWlU2MDFKdi94L2l4QXRSclQ2K3o3N0dKVGFF?=
 =?utf-8?B?ZEw0Q2NPekNrZy9KL1lpNHplL1E5TzJZSUhmdWJuajFLam56Z21ObVgrVVRI?=
 =?utf-8?B?NTBEUUlKMnE3WkVzcktWemNwVFp6cHJNT0dkY1k2SThrbWdkK2dlcFhVN0Z2?=
 =?utf-8?B?Vmt1QTBNeTZYRmFIbDFUbkRJK0JUbHpjL1F5d2pNMzdvZGxVeENWTXVjUWwv?=
 =?utf-8?B?QkU3NjJLSERJRm1TNHh2QTVVMGo2NDJjVVZzbEszczhFT2tHYzNCRlJ3UmxJ?=
 =?utf-8?B?NlpkRytRUytRaUk2czE2b3llcnBFN1d4cDduQmhEQmJrOHJ2emZPOGRuUE1Q?=
 =?utf-8?B?Rkc4VDYya1Y1WDVPOXVoaE5PU2pUdnd1d2RhcUFZV3pPajZYSXdaRXFQNHJP?=
 =?utf-8?B?L0FKenBQZjMyQTRHOHcxVExqT0kySHpReFJiMG1vaDZEcTNkYk1NNWxLdHhP?=
 =?utf-8?B?aFZNVHc1Q21YM1doYkRNWnczckNDS2IvUS84MWNKM2ZhemJqYnQvMDFoTFZ2?=
 =?utf-8?B?ZUlhNFYvSllGcEtrUnFnU1dqWW16NjhLWHZYaDRrZlR5UzBNL0g3NDdTVi9T?=
 =?utf-8?B?WU1KVVI1T3lFQ05KdjQ5NTBtQ2RkRWI0VVFIZ2J0YklPL2VyWWlDSlMzQi9a?=
 =?utf-8?B?b0NLUHY2T2ZHdnJHRjJudHBER2EwcVlnaUxRQmZ4cDlVMTVENWpNdG9vY1lL?=
 =?utf-8?B?NVRGN3dkdVgzdXc4bnBDVjIyOUhtRUF4MndMckxjTnNkT0FmVzJ5SkFWNlBL?=
 =?utf-8?B?K1ZsbVNyVVZpc3YxQ00yUVV6TnpXckNIWXFFRGxsN3AwV2pXUkszTDBXbHBx?=
 =?utf-8?B?RDVzUWlmRTZEYnVadlIxTncxWFFIN29tbHRsalhYd2U4bnBrMkVxZHNzeXBp?=
 =?utf-8?B?VUU4VUt0aGNoK3RDMllrVHNHUzg1Tjh1VVFzajdlWHNHb3RyT1JmdlFwaElD?=
 =?utf-8?B?YW1obzZnWjl0UCtRbG4wN0FGaGp6aGlvVVFJeS9MNVpJa0hoMkhkYS8rdUhF?=
 =?utf-8?B?MG5VWTZkdURJR04xYWJ0WWxDdDM2R1RQa09MbkM3T1BwbVdZdUwzcUVIb3pt?=
 =?utf-8?B?Um05YkZRblhhZkpQTEowT2JPS2R3bkVkWHZzR0NIWVUwUmNGNG5qN2JLOEhG?=
 =?utf-8?B?ZUJIemsrZGowZ1BuWWdPOEprMVZqUm5KQzZFVE1IaytjU1h6MnBKdHZWTjlS?=
 =?utf-8?B?M3UzSytEV3J4WEg4WlVIY0VRUElCN0JsTHVtTnRQSTE0RC93QmQvTXowWkN3?=
 =?utf-8?B?ejJPL3BZQy93OVJscjU5b1hzZzVuSU9UUUNMcGU1cGFqVjRCQko3eUpYMy9t?=
 =?utf-8?B?NkVzenE0R1ZRT2tyV0ZDL0lKQldMdi9zTk1oUElpQWMyUU54c0dVSFNMcTA5?=
 =?utf-8?B?YTJkNitWQkVlK0FRR0lxZjlBcHVibnhoVysvLzF5RmNtdDRyMDh6d3pUMXp5?=
 =?utf-8?B?TktFQmRnT3hrTk1qSVhLZUJ4NGFHcmFSdDhSV2hYTWRRaDFoU2l2ekJJREVK?=
 =?utf-8?B?ZU54NXo0ekdoNEpDWE1MKzlmV0FUNlkvOHcwbkRMM0M1blZxMngvS01jTDBM?=
 =?utf-8?B?cTEzekxkTlRnS2I5ZTdtdGc1SHlSUHY0NlduaHhXRzRVNmE4TzZFYVh0bUla?=
 =?utf-8?B?YzluelY1S1FDUk1jWmpScVBEK053NUk4SmQ0OFE1ZUxKMGlTN0JrTGQyaTho?=
 =?utf-8?B?TjRhNk05Q1JhTEJqdjFQdmRkVVg4VkFRLzMwZmRrOXVHSmVwVGdna01sZGp0?=
 =?utf-8?B?U2JKZDFFZFREdTJxeDFQMTkxOGl2ajNKTHgrUGt0SWJCZ202WDcyN24wOGRa?=
 =?utf-8?B?QWRWM3lNajltMUlwWjYyUzNUeURyeHhoWXdsU0FtalJCNmN6NWZob09jQ0R0?=
 =?utf-8?B?N0NXanZWMjVHUjZzektHOFgyTVN4QmtYV0ZsOVhnUjRnc3R1S2NsUTMrSndl?=
 =?utf-8?B?OW9iQzR0RGxiTytFWlN6VlVUaVhLN1dNUEF0VGxFaklBcmNyMnAxQW9nMjBk?=
 =?utf-8?B?bkFFYUVaejNnMTBoK1cxaUgvNko1YS9aUk1XUTNoQmFHR2pQekFGMjd2blRG?=
 =?utf-8?Q?r2qEuIwXlZgCgz95xeNpB0jA9da8xBmBquiXOJhFN8ZD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(921020)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0xJMDlNczI0eUF2OGRQRUQ0cXYzUmpJbkFGaGFFRG8wbTFpNDBDaElobnpx?=
 =?utf-8?B?MjdKM3VwL3lSQUluVkt1eE1EVXRrWUtBZVJMakVzRDBxQk55Z2pnK2pGYnVy?=
 =?utf-8?B?c1pUdUlocEtpK0RwcURHMDVvUjFqZ0FnU0NlYWFiZXpQTjg4NS9ub1VCZUhW?=
 =?utf-8?B?amxVaVpSOTFPV2dJR2F2VVFLOUhmYkNySFBWclk3djY4MXd4QWlzUTJmM3ZS?=
 =?utf-8?B?M0F4QVlsZXNWbFppK1k1bTBYQXRZZTFUeHBtb1ZzUWJPZHNGM2xkM09sMFl0?=
 =?utf-8?B?TFU0clBwRE1FeVVWODF4a2ZjQzJSaENPNDdMSDlDaWZxSnNNNVRLNW5PQy9D?=
 =?utf-8?B?QzV0QlFsbTBXcHZoZnlFZzZuSTFmWjYrQlVOWjdvcTVuUlFGVnlYc1ptcXk3?=
 =?utf-8?B?bGNyek9LQzBwTEdMYzI2clRJMkloSStTZ3NlWDE2U1RNN0RmSWdXemZZeWh2?=
 =?utf-8?B?KzVtUWNyYlhFeTZ2V3FYckdmaE55S3FiNC9zMlAzTVk5SEk1cm1Kbm1tSjNH?=
 =?utf-8?B?OVRXeWJHZlMwTlU2RUtBL3JmOVJZVVdBUXpFUWFVamVuNndLSmJtMnlOOXdJ?=
 =?utf-8?B?NTFQTHBwT21WZURuUEkyK0pQQjAyY0ZSeUgzYTZtM3dVMGxpcmkvSDRMSGdE?=
 =?utf-8?B?cFd0U1NvRnJUZXFXNDV4SFJ2K2h3UFJGL0VEY0ZvLzF0b2FvbGE5dFcwcUNY?=
 =?utf-8?B?ZFJjd1JXdEc4NjFYSkF6N0hKV095am90Kys0c1luYXlwVE1TdjhKWTF4QWJu?=
 =?utf-8?B?cjNGTjJtMnhDbWdpSCtVeUhleFp3MHEvMXFhTGp2bUR2L1hicHN3dXJZRWdG?=
 =?utf-8?B?ekRBbkd0eXJBVGN0MGNGQUd3RzlwTHNjaGlLcHFrQWV6TlArcnlxSy9Eek9y?=
 =?utf-8?B?bWlybXJ5Z3hMS3JDU2VDN1puaFFmTjV6NHBDM2xiWVNpTERIOVFza1ZaNEVW?=
 =?utf-8?B?eGZxczBWYnNXWE5nQ2t2UEZ3djlZT0tuT2J3eVVmblJwU1NadWlHRk80YTVT?=
 =?utf-8?B?OTB2UjJOY1JrTkdoekVPV0hlN0xPNVlsRDBKZ2lvaVR4ZUJGNUJGMVIvS3pW?=
 =?utf-8?B?VFpwRTlhNXRuSzI5THdFUEE3dU5FaXI4eG5GOWJVZDFReEhXb2pQZ3RpcW9v?=
 =?utf-8?B?bEVQQVZONVpoUlRBKzR3N21WYjlnWWhIWDFEZlhNeS9WKzQ2TktvZ3o5YXpt?=
 =?utf-8?B?eVBibmNnK2JiTStOaHl2S2Nma1BPank0Q2szZVZNMDA5SFFEdFkya1NiVTRt?=
 =?utf-8?B?U3ppUGtCOG5jNmNsb3o0Y2I4MUZJUmJXTEY3RDUzdDNLUS80TnVodkJ2dk0w?=
 =?utf-8?B?MmRlNFBodjVFSlZUblJuNEVxMEJGaXRLN1g4MFVtNCt6SHErd1RtKzBsMHBo?=
 =?utf-8?B?RVg3OCtHMm1ZY3N4dTJqZGljWXpWc2J5bSsxakMwbHdPZk0vYzBuZEZVV2Iw?=
 =?utf-8?B?SzBORTJ1a1FEelpPanFuY1IrQnF2ckplZFZaVjZtV3oraWlPYXZGTmpyNDdY?=
 =?utf-8?B?UjJnVXRzM3ZJTUozTjJkeUNQa1pkc0c0T0daR0JJYVZndnl5YjF2N25sN2l6?=
 =?utf-8?B?UVlsMVZGYzlTRjBSSUdRSm1KZG11b254TTdRQ1o3NWFGbmlhVlJ0YzVQTlp1?=
 =?utf-8?B?YTVwUEFTRk9oYmxVcnRIQjdoZkhicmxqVnhNTU93QlNUUEY1OXVlWXBtUUo5?=
 =?utf-8?B?Y01OU3RWM2w2ZGVjSGJpSHJ2TU43S0pPRlZUSGxIZGtDaTF5RnIzTVJnSmJG?=
 =?utf-8?B?SDBKSVoxbVkvdHBSZFhHMkNzalJlejZ0YzRuaDNpcmFyQ21GQmtQS3VlR2VI?=
 =?utf-8?B?MWdsZHlOdzlvWnVQRG5IcGFpcFd6V2RCVlhHT1BMMERKTUE1ZDdPUCtUbW1N?=
 =?utf-8?B?b05QY01jRnVUREVGdnZ5ZVNBaFV6WUZuK2RpYXhEUHRETms1aGRuNWU0VTZ4?=
 =?utf-8?B?aWkvMVVYbXY1VjQ1ZXlFcUZrdGxZZ0NFbVVydncvMHBSVi90dDdDMEQ0b0FB?=
 =?utf-8?B?WmN3WWtUODlaaDhBMmgwTEMwdHJQeEF6eVNMRUtFdjJvRHBIZzAwbmhuZFNk?=
 =?utf-8?B?aVc0TmNBUk1IT0JCSXowVlU3ZmF4SFVKZDB5L2FFUXlxTEVLZ2N3cE53WE5j?=
 =?utf-8?B?cDNRQjF0ZFNqc2VGd2FtK1hNanRUODJtK0pJQ2xka3FDY2dPVXdWazBKM3Vo?=
 =?utf-8?B?YTZVNXA2aUhlKzJUUHBTVGsrbzlTNUVKakpZR1FQck5KQ1FlV3JFbXZlVDF3?=
 =?utf-8?B?Sy9yV2dSRlV1NitoSUd4ZXg5Q0hJY0NDRkpQTE5zeks5cDRFdk5RNjNUK3NX?=
 =?utf-8?Q?Lul94M+RETYCOzjWGC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d33afe4-f88e-4c15-2ad7-08de571b650e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 05:27:10.4230 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MuH37clFVE650n2i9crQ0No/EVtsN7qMqoVTyBs9P7tMd2l3VN9gDb41kbyEdQam
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083
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

W1B1YmxpY10NCg0KSW4gb3JkZXIgdG8gYXZvaWQgYmVpbmcgYmxvY2tlZCBieSB0aGUgbG9jayBp
c3N1ZSBvbiBzb21lIG9sZGVyIEdGWCwgSSB3aWxsIHB1c2ggdGhlIHBhdGNoIHRvIGFtZC1zdGFn
aW5nLWRybS1uZXh0Lg0KSWYgeW91IGhhdmUgYW55IGNvbmNlcm5zLCBwbGVhc2UgbGV0IG1lIGtu
b3cuDQoNClJlZ2FyZHMsDQogICAgICBQcmlrZQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5v
cmc+IE9uIEJlaGFsZiBPZiBMaWFuZywgUHJpa2UNCj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDE5
LCAyMDI2IDk6NTggQU0NCj4gVG86IFRpbXVyIEtyaXN0w7NmIDx0aW11ci5rcmlzdG9mQGdtYWls
LmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOw0KPiBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8Q2hy
aXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNp
ZWxsb0BhbWQuY29tPjsNCj4gRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3Jn
Pg0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBkcm0vYW1kZ3B1OiBGaXggdmFsaWRhdGluZyBmbHVz
aF9ncHVfdGxiX3Bhc2lkKCkNCj4NCj4gW1B1YmxpY10NCj4NCj4gVGhhbmsgeW91IGZvciB0aGUg
Zml4LiBDb3VsZCB5b3UgcGxlYXNlIGFkZCB0aGUgZm9sbG93aW5nIHRoZSB0YWdzPw0KPg0KPiB8
IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gfCBSZXBv
cnRlZC1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0KPiB8IENs
b3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI2MDExOTAxMjEuejlDMHVtbDUtbGtw
QGludGVsLmNvbS8NCj4NCj4gUmV2aWV3ZWQtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0Bh
bWQuY29tPg0KPg0KPiBSZWdhcmRzLA0KPiAgICAgICBQcmlrZQ0KPg0KPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogVGltdXIgS3Jpc3TDs2YgPHRpbXVyLmtyaXN0b2ZA
Z21haWwuY29tPg0KPiA+IFNlbnQ6IFN1bmRheSwgSmFudWFyeSAxOCwgMjAyNiA4OjU4IFBNDQo+
ID4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIN
Cj4gPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+ID4g
PENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1k
LmNvbT47DQo+ID4gTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29t
Pg0KPiA+IENjOiBUaW11ciBLcmlzdMOzZiA8dGltdXIua3Jpc3RvZkBnbWFpbC5jb20+DQo+ID4g
U3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiBGaXggdmFsaWRhdGluZyBmbHVzaF9ncHVfdGxi
X3Bhc2lkKCkNCj4gPg0KPiA+IFdoZW4gYSBmdW5jdGlvbiBob2xkcyBhIGxvY2sgYW5kIHdlIHJl
dHVybiB3aXRob3V0IHVubG9ja2luZyBpdCwgaXQNCj4gPiBkZWFkbG9ja3MgdGhlIGtlcm5lbC4g
V2Ugc2hvdWxkIGFsd2F5cyB1bmxvY2sgYmVmb3JlIHJldHVybmluZy4NCj4gPg0KPiA+IFRoaXMg
Y29tbWl0IGZpeGVzIHN1c3BlbmQvcmVzdW1lIG9uIFNJLg0KPiA+IFRlc3RlZCBvbiB0d28gVGFo
aXRpIEdQVXM6IEZpcmVQcm8gVzkwMDAgYW5kIFI5IDI4MFguDQo+ID4NCj4gPiBGaXhlczogYmMy
ZGVhMzAwMzhhICgiZHJtL2FtZGdwdTogdmFsaWRhdGUgdGhlIGZsdXNoX2dwdV90bGJfcGFzaWQo
KSIpDQo+ID4gU2lnbmVkLW9mZi1ieTogVGltdXIgS3Jpc3TDs2YgPHRpbXVyLmtyaXN0b2ZAZ21h
aWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z21jLmMgfCA1ICsrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dtYy5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZ21jLmMNCj4gPiBpbmRleCAwZTY3ZmE0MzM4ZmYuLjRmYTI0YmUxYmY0NSAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMNCj4gPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMNCj4gPiBAQCAtNzY5LDcg
Kzc2OSw3IEBAIGludCBhbWRncHVfZ21jX2ZsdXNoX2dwdV90bGJfcGFzaWQoc3RydWN0DQo+ID4g
YW1kZ3B1X2RldmljZSAqYWRldiwgdWludDE2X3QgcGFzaWQsDQo+ID4gICAgICAgc3RydWN0IGFt
ZGdwdV9yaW5nICpyaW5nID0gJmFkZXYtPmdmeC5raXFbaW5zdF0ucmluZzsNCj4gPiAgICAgICBz
dHJ1Y3QgYW1kZ3B1X2tpcSAqa2lxID0gJmFkZXYtPmdmeC5raXFbaW5zdF07DQo+ID4gICAgICAg
dW5zaWduZWQgaW50IG5kdzsNCj4gPiAtICAgICBpbnQgciwgY250ID0gMDsNCj4gPiArICAgICBp
bnQgciA9IDAsIGNudCA9IDA7DQo+ID4gICAgICAgdWludDMyX3Qgc2VxOw0KPiA+DQo+ID4gICAg
ICAgLyoNCj4gPiBAQCAtNzgyLDcgKzc4Miw3IEBAIGludCBhbWRncHVfZ21jX2ZsdXNoX2dwdV90
bGJfcGFzaWQoc3RydWN0DQo+ID4gYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDE2X3QgcGFzaWQs
DQo+ID4gICAgICAgaWYgKCFhZGV2LT5nbWMuZmx1c2hfcGFzaWRfdXNlc19raXEgfHwgIXJpbmct
PnNjaGVkLnJlYWR5KSB7DQo+ID4NCj4gPiAgICAgICAgICAgICAgIGlmICghYWRldi0+Z21jLmdt
Y19mdW5jcy0+Zmx1c2hfZ3B1X3RsYl9wYXNpZCkNCj4gPiAtICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIDA7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyb3JfdW5sb2NrX3Jl
c2V0Ow0KPiA+DQo+ID4gICAgICAgICAgICAgICBpZiAoYWRldi0+Z21jLmZsdXNoX3RsYl9uZWVk
c19leHRyYV90eXBlXzIpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPmdtYy5nbWNf
ZnVuY3MtPmZsdXNoX2dwdV90bGJfcGFzaWQoYWRldiwNCj4gPiBwYXNpZCwgQEAgLTc5Nyw3ICs3
OTcsNiBAQCBpbnQgYW1kZ3B1X2dtY19mbHVzaF9ncHVfdGxiX3Bhc2lkKHN0cnVjdA0KPiA+IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQxNl90IHBhc2lkLA0KPiA+ICAgICAgICAgICAgICAgYWRl
di0+Z21jLmdtY19mdW5jcy0+Zmx1c2hfZ3B1X3RsYl9wYXNpZChhZGV2LCBwYXNpZCwNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmx1
c2hfdHlwZSwgYWxsX2h1YiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaW5zdCk7DQo+ID4gLSAgICAgICAgICAgICByID0gMDsNCj4g
PiAgICAgICB9IGVsc2Ugew0KPiA+ICAgICAgICAgICAgICAgLyogMiBkd29yZHMgZmx1c2ggKyA4
IGR3b3JkcyBmZW5jZSAqLw0KPiA+ICAgICAgICAgICAgICAgbmR3ID0ga2lxLT5wbWYtPmludmFs
aWRhdGVfdGxic19zaXplICsgODsNCj4gPiAtLQ0KPiA+IDIuNTIuMA0KDQo=
