Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BE0C5AE59
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 13:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DC2510E989;
	Thu,  5 Jun 2025 13:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hAphObJd";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F51D10E989
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 13:15:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TD+lIQ7NOOS1jgYSIzGE6gAoHBzX7TezGPikqqBsjdv/IWSOTNhdSD/rCF4g8MqD+LVRJnZQkY5mLT8ks++7NFmOXDkBD8/JlgUEJZp+1b749vhB7UrwX5p9ymSyqi6lg+TEqJLiz8GtLsxPD2ybCyipDtssXvzDzkTU6bTs9FBi7HXI4AW6bfj5a0oLlsg4iOfdvXdMphfpH2jOcXpKjbMZlF93p/QMq/eWwlItacmcJiHMaqNyn7C74Uib0vx4BR/A0hUbYKi24WGyFiDEqClXkSL9naYXICaC7sKQmb7mIRokUkBarLOjH7f6MFctY6a6+DDaqK9lSMGim4UncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZUpyv5h9ZJsLliVGV/sQHQV43SlZ4GhQ8EOS6PqzV8=;
 b=Ej2wkvFK4x0/HHiZ9AvLO9tRsTT6JKGXy/c9e8HXj8oYbDcWrzD6W48uI3UW2J6dkj/6F3ATDlF9D6VmdGxMa+5IhQ3EqC75l60IjoVhVuqXyIXJs0ul9+Z03M7RAb4p+REXeIiCKSCCcMywswS8seQgq/zW7U4KF9Izgh/ZzkKwVvbI5/b/sAbvneH7eli5FaY/SK2ZFEY5KX6AYaZ3BC0AgYuozLF7m+qE+iEjVSrbJSwjyIusMIkUZNvUgnj0VEblzow9ohOOwoc1mZumMnbSu+CTDfu3oxAv3YGBv//Hm4W1BZ+KWKXj5lAkrZSwNtr493MXu4MWSMYTHiTqdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZUpyv5h9ZJsLliVGV/sQHQV43SlZ4GhQ8EOS6PqzV8=;
 b=hAphObJdzv5tOb57BVmJhXR7w6IwVj5Tir9TdMmIO6pPNdzMx7v5x54vR6iwxC2kkr3vFvJCGeZyERFMruSmUIpb4xexYXHXZKRzUCV8pA3Iu5Dl5KtlEDMEmi140jOcfoaRBMZAnTBZg1uv5hP5UCX6HehMFwy4rh6WpQyj6cQ=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 LV5PR12MB9801.namprd12.prod.outlook.com (2603:10b6:408:2fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Thu, 5 Jun
 2025 13:15:44 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%7]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 13:15:44 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
Subject: RE: [PATCH 3/9] drm/amdgpu: wait for the user objects done before
 destroying
Thread-Topic: [PATCH 3/9] drm/amdgpu: wait for the user objects done before
 destroying
Thread-Index: AQHb0TgzsvvuSO+E80Oz8dMCPvga+7PvufqAgATVRSA=
Date: Thu, 5 Jun 2025 13:15:44 +0000
Message-ID: <DS7PR12MB600514C513A65F0C3298D02EFB6FA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250530075505.882004-1-Prike.Liang@amd.com>
 <20250530075505.882004-3-Prike.Liang@amd.com>
 <ba16b7a2-130b-433c-a305-fa756bead449@amd.com>
In-Reply-To: <ba16b7a2-130b-433c-a305-fa756bead449@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=0f045ec2-e163-4243-9a1e-937927daaf45;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-05T12:53:44Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|LV5PR12MB9801:EE_
x-ms-office365-filtering-correlation-id: 84b73ea6-ccc8-432d-42a3-08dda43313ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?bmtYOXRnd29Wbks1QU4zMlBaNkhyc0lJTDJKWm85R1Y5VnhnYXB1eSs0VGpr?=
 =?utf-8?B?QXpGUTFPa2pLZVFHY3RVTng4YjlzR3Evc0E2dWVhUEFCNmpyZnR2QVdmMTNG?=
 =?utf-8?B?cXQ3K3REUFR2ZzNGSWhPWmN6YnFzZExSQlM0QlpERFJ3bEt3NCt2S1NHWG9S?=
 =?utf-8?B?d0JCWjRIay9vL2R4S1lnL0tPQm5jd05tNGlydTAvYXRmNDh4SHlackVMZEJu?=
 =?utf-8?B?NUUvSGdzcnNjR2ZueER6Qnk2QjBPVnZJdEw4dWZmSlJFZ3VmUXlBbG14RkdO?=
 =?utf-8?B?TDlZMmxYZFJNN29GUEMwYzBvOTRJb1NaMXV5YnBlN1l1alhGQVFFVmxEWkNP?=
 =?utf-8?B?bjFGOThYcEhwTVo1OUgwL1FYTGVSdWhLUTlzbnZlU1IxbkdIeHdtbUh4SW1Z?=
 =?utf-8?B?cTJYUm9xOVUrN3R6dzlHTnEwUk9wVUlBclgrcXdMSG1SSnEyc2xYd0NSUXRX?=
 =?utf-8?B?dmZ2dnlsZUg5bk1hU0hBRlR0WitmNFA5SWNxZUpsSmMyZFNXeWIxWS9tanFW?=
 =?utf-8?B?SGFFbDk3d3hYOWo3bFlCcCtqNTQvaER2bEJBMFh6eEF0bWRBV01sUWs2NmY1?=
 =?utf-8?B?TGZpamlXc3J0RWdQZmx6Q0hHeUR0ZFIzRXhGQVI4REEzQXIvWmYxU1d6ZjJ4?=
 =?utf-8?B?TTFwa2ljcW16S3JRK1pjdUszakRVZnRoS1ZrS0V0L0RVcjF5aGlQY1hDTDJp?=
 =?utf-8?B?U24vbTJQNWFJY0RLUmlZUVo3dWwwQkdIVlpXYVNvN0dpbTNCeFJTMSsyaWkz?=
 =?utf-8?B?c1Y2SWEwRklsOHFBQnJyR2FWOEhpd2dWRm5LaFdSMHNjckN0MGF5aTZuSEV5?=
 =?utf-8?B?ZW1EVER2WDJ2L2dTUGg0YmI5ZVNTQktYQUs0aStNdGpaQW5zZ1k3bnVoTURl?=
 =?utf-8?B?dGQvamM1bElYeFF4K1FzTEN0b1VxeHQ2VVk0YVFHa3NHSWZFdG1venlmU0Rk?=
 =?utf-8?B?eEUzSWgwOXlCZFlOVmNocGxZUWhWaGFPdHY3azVYU1NaQXBnU1k3eVNpK2Nk?=
 =?utf-8?B?UVkwajZNaU5leERyS2hLamxnNXlPR2lqK1hZeXVBclBzSUJEV2JwanJ4ZWFK?=
 =?utf-8?B?cmg3cU1PdkYrWENBK25YVzBSK1loZi9zWDBnT2lwUC9OeXNMYlRFSUpYM1pB?=
 =?utf-8?B?YUFZcUx0bmh3bHBicTgxV1czd2szUnJyNkx6MjhsYmRZRk9YVGNFdnNQN0dy?=
 =?utf-8?B?UWtxSXE3c2RBWVd2UENhaUNkdzhZWERibXhJSXlGTHlkQVJNSjdhb0l5YldZ?=
 =?utf-8?B?NUc1aUpsZ2EwdHBjQ082ME9yOUM3ZUVBRGZLbW9EVmZtRHlSWkprR2xQdVBz?=
 =?utf-8?B?eXVhZzg5bHQySXF5ZmVackZ1UHFSdnBwY3NFZlpaMXpvL3MvU1NjU1E3VEZa?=
 =?utf-8?B?cVNBQkYvbkJCaTgzUUw5OGZuR3FYYzhTL2o1dkFZUWRQSmE5elhuUkhVUno3?=
 =?utf-8?B?V01CQ2dyRWtTNDFDRHpuUFRPeDJLRFVzcFExaFZKc1N4dTlnQkhhU3I5K0pl?=
 =?utf-8?B?R1pLMXIxMHJxQWJ2bE9KNkF0V2ZVaC9ZMFlHZkp6MDVBcy9DeW9VSnAzVmY5?=
 =?utf-8?B?TEdzZWptWUt0RFpFNGFOcktlSnBJeWllRnMxdlgrOEZIbWxra3RnVzQ5YjRp?=
 =?utf-8?B?UEVITG5udE03NC91REVwLy9RQnVaQ2MvQUVEK2h5T29jQWlJWUJHUEJtSGtQ?=
 =?utf-8?B?Qm12akZBSFlxK2xpV0JWdmhkUUFMbERkU1hDTDg5NHVPZSt1VjJvZ0pMYXE5?=
 =?utf-8?B?bGk1VkNDN3RNdlhRenN1MWhWbVRmejQ1dTBxekIvZXIzamJkOVhFVHpjTDdK?=
 =?utf-8?B?YlZyVEM4c2dyQzhXOUgvMVRjOXVwS3VPeEROcC9CVVcreUxZNmxuYmYvdFZa?=
 =?utf-8?B?OE5HeU90eFlRcXBVZG0yVFhQZ3NaMjdYVFdoa3FiOGQ1akpOVHV5WERETHhv?=
 =?utf-8?B?d1ZjdlFlZ0ZzdFhDaHZwUWM5a2ZTaEpMTi8rSC9VTlcvQWhNS1N5UUFCYmhD?=
 =?utf-8?Q?LogugoGSuFeyLZLqAskZugbFonnqo4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzhZVTNkQk1XeFJHSkNqOVo5bXJjMFQ0TTVNRGd0WEE5MTl0dUpnT1llSW84?=
 =?utf-8?B?V2ZubUFYSjJXSUsyUWRnQ0NUMDJ1VEZybmVpYytqRCtEQm12NEJoK2RCYWJT?=
 =?utf-8?B?elJnOHF3c0p4NUd5MGpsRXRCMS9kNW1MTklzY1h0WUxubHFrNTRJMmhtVjVM?=
 =?utf-8?B?eGVBWlBVZ0NrbFdjUzRXczFuRWF3SDUvdmREY3JrblVER0lFbjlESzZLOVMr?=
 =?utf-8?B?aFhYTGNSRTV4SHZvTUhHMWtwUzFjUlhRVFpzVTQ5ZWIrbGdseDBkMjZCSXRl?=
 =?utf-8?B?bjk0L25xTDRHWGxBTEhzLytYaHBKRWlDdDdCekFsbXB2NERtdzc5WEttS3Q0?=
 =?utf-8?B?TmNzbGg0UE5Sd28vK1gwUmc3YTZPcGhaTXhsMWNHekh5ck9UbEVXT2lhc1dr?=
 =?utf-8?B?S0o5ZzFEU2tkQXIzQys2RE4yMUM4Skt3c2JwNm5MSWhTMTF6VHFDZmVPZVU2?=
 =?utf-8?B?Y2RhVG0rMExFcWtuRlJSa3QzVG1DZDdiekFHbVEyUHQwT3JVL3d6ZndUaU9v?=
 =?utf-8?B?RVpNcnE2VFFCSzBvUDFMWGZwdFpzcDBGRWE5OXp4OUVJdFQwS0JNcVArZ3Vr?=
 =?utf-8?B?TGZUQ0dDMW8rUStTdlB4YjV5UExybmpiY1NnVG1hbFBLaTMyMFdJSmEvNnp5?=
 =?utf-8?B?TXYxdk03S2NYaUIvTFJuRFZDeGNsYm5kczBlZVpyVG81Vko0RUlkOHg5MUps?=
 =?utf-8?B?bWhKbmJJV1QwQmJudzVGUlVzOTJJRExwdUozV2NjNGZjcDVZZERMSThEMWgw?=
 =?utf-8?B?a2RIbk8zL1d4ZzJyc1YyZGs1TlVKQWNYc1VTTy96aG93ZCs3RDRMZFQ4amh5?=
 =?utf-8?B?MnNDd21mOWZLaW43WUFFNytybmRuSmFXbEpSNm1VL3BIdERjWm5CRXBwK1lv?=
 =?utf-8?B?V2I4SVZBK0FPaTVrUkM4L3V2SWpuZmluVHJCOHR6aXFCL0dsOGxZd3dBZHc2?=
 =?utf-8?B?cVRwRytacU1ZK1FKbjA2R0RZSmduQ1VJZGFsYklkN0dodG9KSmlRNm9HNG5F?=
 =?utf-8?B?bTU1VTZpZERNOGFIR2gxYTdoaUNKWDFqWlV5VEZiTmhUSzcwVCs1VDgwNzA4?=
 =?utf-8?B?RUN1TG5sZDZwdjJ6WnFzNnFwZ1R6OGcrOU0xaVNIU1VPWFJBNFdrV09PUGFK?=
 =?utf-8?B?c3A0ditKeGZSeEpDenBISDFaV3ZDSzB3ZHBuUEh4dXlib0VFbjgraVFoRmhi?=
 =?utf-8?B?TTVrK3kxM0NnR1BOMWtUZ0g5YlI5aVQrOFRCbjlDdGVYOE95dXlqSVV4eEdC?=
 =?utf-8?B?M21QZ0crLzJ2QXUzNzVDM3RGWjBsNG44QlVZTHlHMjVuOUNQcHdMVElmWTZ3?=
 =?utf-8?B?R09iUmRvakxJb090RCsrMXBqazIxNDF6TG5iS3RuVHlOc25xdWt5RjVCZWVO?=
 =?utf-8?B?TDR6WjdxaWRqdVNSOFY4dnpvZXJ6YStrb2Jodjc1Q1R5aXhyaC9zc1VFKzR4?=
 =?utf-8?B?cTlsa2VmcDczWmtTVWYzKy91TVM5a1kwSm9VdUUxN3k5TGl6NlVoQnhsMUpq?=
 =?utf-8?B?MC8zQ0ViakdSeS9vdjlNOUJiejlpY3ZJV3M2WTBwaWJyOExEU1VsbWQxTEJT?=
 =?utf-8?B?S2JZWHlrdUhNYXNiSTlINXROb1FiZjIveWdJTGFhTktHZWtnRm9HdTRJRWtq?=
 =?utf-8?B?ek1CLzJMZ2Q2dVJ4T3hvdHBRZ1JNR3RWMjM4RjVoVVVPYlRRMG9UMVZYWnJx?=
 =?utf-8?B?eHFqTy9vWmtZcENJZk12WjM1TGxBY212RjRxTUJPbXVsM2NmcXJHZVh2S2RZ?=
 =?utf-8?B?eExzM2FrN0hzYVVlVnl3M0w0R2R6ekRFSDB0K0FyVHh4SW5zTHRFdEFCRWx4?=
 =?utf-8?B?UHEvVjVXbi9HbVlGWjhhaUpxYVdwcXJSSGFoYmFuZzMxRDNNWENENEpRWko2?=
 =?utf-8?B?Rzc3dXhWaHRaWXlxWVJnZWJPb0ZTMDE0RHVEdm1COVNORUdRUVV0bTZCTWVJ?=
 =?utf-8?B?YzNRQ1Z6aEIrZTgyL04vcTBwUlcyU2V5K1A5UTFGeGRwU3h2UGZ4dkVIUzZB?=
 =?utf-8?B?MzhQbk5rSXNYaW5tRUxBbS9HTFd4ZVBvOUxkMHRnNnlTZ3c1aVdtNkpsNGU4?=
 =?utf-8?B?TWU5ZUFEYXkxajRrc0s0eW5haVl3SkJuL2lWUE80bkd1ck1DNEFUMWFJVVcv?=
 =?utf-8?Q?PFT0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b73ea6-ccc8-432d-42a3-08dda43313ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 13:15:44.0838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2SCQ5hgwJX5AqGzTBmAiWgQYvCOlLOsWC0s+8MKBukAc7Ju3QA9WcSaXQ+yEoI8r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9801
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcs
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBNb25kYXksIEp1
bmUgMiwgMjAyNSA3OjA1IFBNDQo+IFRvOiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5j
b20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFu
ZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgTGF6YXIsIExpam8NCj4gPExpam8uTGF6
YXJAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzldIGRybS9hbWRncHU6IHdhaXQg
Zm9yIHRoZSB1c2VyIG9iamVjdHMgZG9uZSBiZWZvcmUNCj4gZGVzdHJveWluZw0KPg0KPiBPbiA1
LzMwLzI1IDA5OjU0LCBQcmlrZSBMaWFuZyB3cm90ZToNCj4gPiBUaGUgdXNlcnEgYnVmZmVyIHNo
b3VsZCBjb21wbGV0ZSBpdHMgYXR0YWNoZWQgd29yayBiZWZvcmUgYmVpbmcNCj4gPiBkZXN0cm95
ZWQuDQo+DQo+IFRoYXQgZG9lc24ndCBtYWtlIHNlbnNlIGF0IGFsbC4gV2Ugc2hvdWxkIHdhaXQg
Zm9yIHRoZSByZXF1ZXN0ZWQgc2lnbmFsIGZlbmNlcywgYnV0DQo+IGFwYXJ0IGZyb20gdGhhdCBp
dCBpcyB0aGUgcmVzcG9uc2liaWxpdHkgZm9yIHVzZXJzcGFjZSB0byBtYWtlIHN1cmUgdGhhdCBx
dWV1ZXMgYXJlDQo+IG9ubHkgZGVzdHJveWVkIGFmdGVyIHRoZXkgYXJlIGlkbGUuDQo+DQo+IElm
IHRoZSBrZXJuZWwgZG9lcyB0aGlzIGl0IHNob3VsZCAqbmV2ZXIqIHdhaXQgZm9yIGFueXRoaW5n
IG9uZ29pbmcsIGl0IHNob3VsZCBvbmx5DQo+IGZvcmNlZnVsbHkgdW5tYXAgdGhlIHF1ZXVlIGFu
ZCBkZXN0cm95IGl0Lg0KW1ByaWtlXSBZZWFoLCBnZW5lcmFsbHksIHRoZSB1c2VycSBkZXN0cm95
IElPQ1RMIHJlcXVlc3Qgc2hvdWxkIGJlIHBlcmZvcm1lZCBhZnRlciBNZXNhIHRlYXJzIHRoZSB3
aW5kb3cgY29udGV4dCBkb3duIGJ5IGV4ZWN1dGluZyBhbWRncHVfd2luc3lzX2Rlc3Ryb3koKS4N
CkJ1dCBpZiB0aGVyZSdzIGFuIGltcHJvcGVyIGNhc2Ugd2hlcmUga2VybmVsIHRyaWVzIHRvIGRl
c3Ryb3kgdGhlIHVzZXJxIEJPcyBhdHRhY2hlZCBmZW5jZXMgc29tZWhvdyBoYXZlbid0IHNpZ25h
bGVkLCB0aGVuIGl0J3Mgc2FmZSB0byBmb3JjZSBkZXN0cm95IHRoZSB1c2VycSBidWZmZXIgb2Jq
ZWN0IHdpdGggb25nb2luZyB3b3JrPw0KDQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYyAg
fCAzICsrLQ0KPiA+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYyB8
IDMgKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3VzZXJxLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2Vy
cS5jDQo+ID4gaW5kZXggOGVlYTBlMWUxYjZhLi5mNDU1ODViZDU4NzIgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+IEBAIC0yMTcsNiAr
MjE3LDggQEAgaW50IGFtZGdwdV91c2VycV9jcmVhdGVfb2JqZWN0KHN0cnVjdA0KPiA+IGFtZGdw
dV91c2VycV9tZ3IgKnVxX21nciwgIHZvaWQgYW1kZ3B1X3VzZXJxX2Rlc3Ryb3lfb2JqZWN0KHN0
cnVjdA0KPiBhbWRncHVfdXNlcnFfbWdyICp1cV9tZ3IsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3VzZXJxX29iaiAqdXNlcnFfb2JqKSAgew0KPiA+ICsg
ICBhbWRncHVfYm9fc3luY193YWl0KHVzZXJxX29iai0+b2JqLA0KPiBBTURHUFVfRkVOQ0VfT1dO
RVJfVU5ERUZJTkVELA0KPiA+ICsgICAgICAgICAgICAgICAgICAgZmFsc2UpOw0KPiA+ICAgICBh
bWRncHVfYm9fa3VubWFwKHVzZXJxX29iai0+b2JqKTsNCj4gPiAgICAgYW1kZ3B1X2JvX3VucmVm
KCZ1c2VycV9vYmotPm9iaik7DQo+ID4gIH0NCj4gPiBAQCAtMzE3LDcgKzMxOSw2IEBAIGFtZGdw
dV91c2VycV9kZXN0cm95KHN0cnVjdCBkcm1fZmlsZSAqZmlscCwgaW50IHF1ZXVlX2lkKQ0KPiA+
ICAgICAgICAgICAgIGFtZGdwdV9ib191bnBpbihxdWV1ZS0+ZGJfb2JqLm9iaik7DQo+ID4gICAg
ICAgICAgICAgYW1kZ3B1X2JvX3VucmVzZXJ2ZShxdWV1ZS0+ZGJfb2JqLm9iaik7DQo+ID4gICAg
IH0NCj4gPiAtICAgYW1kZ3B1X2JvX3VucmVmKCZxdWV1ZS0+ZGJfb2JqLm9iaik7DQo+ID4gICAg
IHIgPSBhbWRncHVfdXNlcnFfdW5tYXBfaGVscGVyKHVxX21nciwgcXVldWUpOw0KPiA+ICAgICBp
ZiAociAhPSBBTURHUFVfVVNFUlFfU1RBVEVfVU5NQVBQRUQpIHsNCj4gPiAgICAgICAgICAgICBk
cm1fZGJnX2RyaXZlcihhZGV2X3RvX2RybSh1cV9tZ3ItPmFkZXYpLCAiQ2FuJ3QgdW5tYXAgdGhl
DQo+IHF1ZXVlDQo+ID4gZm9yIGRlc3Ryb3lpbmcuXG4iKTsgZGlmZiAtLWdpdA0KPiA+IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3VzZXJxdWV1ZS5jDQo+ID4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMNCj4gPiBpbmRleCAxNDU3ZmI0OWE3OTQu
LmI0NmU2N2IxNzlmYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9tZXNfdXNlcnF1ZXVlLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9t
ZXNfdXNlcnF1ZXVlLmMNCj4gPiBAQCAtMzM2LDYgKzMzNiw5IEBAIG1lc191c2VycV9tcWRfZGVz
dHJveShzdHJ1Y3QgYW1kZ3B1X3VzZXJxX21ncg0KPiAqdXFfbWdyLA0KPiA+ICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCBhbWRncHVfdXNlcm1vZGVfcXVldWUgKnF1ZXVlKSAgew0KPiA+ICAgICBh
bWRncHVfdXNlcnFfZGVzdHJveV9vYmplY3QodXFfbWdyLCAmcXVldWUtPmZ3X29iaik7DQo+ID4g
KyAgIGlmIChxdWV1ZS0+ZGJfb2JqLm9iai0+dGJvLnBpbl9jb3VudCkNCj4gPiArICAgICAgICAg
ICBhbWRncHVfYm9fdW5waW4ocXVldWUtPmRiX29iai5vYmopOw0KPiA+ICsgICBhbWRncHVfdXNl
cnFfZGVzdHJveV9vYmplY3QodXFfbWdyLCAmcXVldWUtPmRiX29iaik7DQo+ID4gICAgIGtmcmVl
KHF1ZXVlLT51c2VycV9wcm9wKTsNCj4gPiAgICAgYW1kZ3B1X3VzZXJxX2Rlc3Ryb3lfb2JqZWN0
KHVxX21nciwgJnF1ZXVlLT5tcWQpOyAgfQ0KDQo=
