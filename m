Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30374C3DA45
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jul 2024 02:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1E9210E95F;
	Fri, 12 Jul 2024 02:54:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="290GsJ4G";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33D1310E95F
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 02:54:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baej+GAtiwPRJJ3uxyPKlPjhfGEU50Dg5gPd6vnewUfJ3qq7oT+muPXZiefEVvgYhNCaJRp0tRqV511g7vQN6rzNo9MrNQlpOmFpNCh7BYZNotKSiAV0fFQvsQlwVkKS8BaW8TTsXgIoY32YLjeqOByCwdQ8od0pSr0TPQu018S2JzufzGEQYEa6w/aERj3R9N9S4Jrj58sI3tWx4PqoTyfIy61FbnVj8oP7e9gC3d1K3kBATbT713xF1tL3laL4blS5Z0IPZQ2RT0n0IXl13LBBahuGKQv8+KdWtsJFmGZYXzAjtF5S742aMKbx5ZpFPVuymGMMn143vblnNHMutw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCOu+PVNdkavBeo59PeQiygHaoiC8LacRkJ0/K3nX7w=;
 b=hR3KSvkCOVBahKg7b2UrE9s79taX7A6ZMWbZ80LxvAhk3h8/gN30bQtOrQcp+hLRIQ/VTYXxIcI+p3Xrjf1AmCxLDXCUDUPV8GPRm602jfAO4mLoHDwrZlgtJfcnr+a0rPvLx5oTQ1DKv40w+INkzq9e1YAssI+UmABEC/aMkUCK9ryOQxgLvoMuwjOqcg8vCfkRduhyNdVl7qQplYz906kR96/ThipSlu9+ybxtrRhU/RRX44O/6cdOfeTeBHEZsWVxIq0KAh/13SSpz3WSzv9JDo9/QCJnLSY6d26zRGqUXnfgaWidB1PstpfT7WI7KqGBNHiaUzfOSIpoPvxzeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCOu+PVNdkavBeo59PeQiygHaoiC8LacRkJ0/K3nX7w=;
 b=290GsJ4G9Bfsd4GB8DUd8qKhfr8niQx/38aUuISeMrYmrFtze2AQKNual4KJmwqvGorIBtR0E6iup24l30ydR+dADhrUAA1EQ+hAB04PKOorVioWKo6hrXXv6IeHrFIKr3CVKN5yorxzglN87q+pYuG5vV19VCJKaoJgZOqmL1E=
Received: from PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Fri, 12 Jul
 2024 02:54:45 +0000
Received: from PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::dd32:9eed:14e9:33f1]) by PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::dd32:9eed:14e9:33f1%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 02:54:45 +0000
From: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
CC: "Huang, Trigger" <Trigger.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
Thread-Topic: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
Thread-Index: AQHa03IfEhVVc7NTr0qjBS5n8EetiLHxa8WAgAAL+QCAAOud0A==
Date: Fri, 12 Jul 2024 02:54:45 +0000
Message-ID: <PH0PR12MB542037268A58AEDF49E84D35E0A62@PH0PR12MB5420.namprd12.prod.outlook.com>
References: <20240711090947.478919-1-YuanShang.Mao@amd.com>
 <SA1PR12MB74429E91B411DEEF22D29B70FEA52@SA1PR12MB7442.namprd12.prod.outlook.com>
 <d7d59834-7907-4100-8f7e-4c864674f00e@gmail.com>
In-Reply-To: <d7d59834-7907-4100-8f7e-4c864674f00e@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=37286465-db4e-4f82-a6c8-191bd63383fc;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-12T02:42:23Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5420:EE_|DM6PR12MB4217:EE_
x-ms-office365-filtering-correlation-id: 880ac619-18f7-464d-ec57-08dca21dfc88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L2VTWXY3THVGSTJQZ1ZxcnptVExRQjB5ZWV4aitqaU4zRXdVUXl6UWlCdHpV?=
 =?utf-8?B?WGpGbWVmV1ExcUFuUGZPVDQ4VmljSVVpc0lQc3Q3eHhqT2Y3Rm94OUVCOEly?=
 =?utf-8?B?K2hHaWFIRVlYNndRUE5rL3o4blNKUTVvNmY4TnZMMi96N3JUZDJ0NU1OWXVs?=
 =?utf-8?B?bWxGWU9pMktjSjJhMmo2dTk0VkZicnk4dlpxckhFS3BIa1k0QjJFZjNOcUxr?=
 =?utf-8?B?cm9tbTZTVTVVN0VYOGcrSStxajRRMTExYldndUw4K0VCclNmd0NRV1NoUU83?=
 =?utf-8?B?T2crVmhCOE1yMjMwbnl5QzZpVTZoYmQ3SDdkYksyT2N3N2xOdGpiV3JTQkk4?=
 =?utf-8?B?RjRMS1cwVjFRa0V5ckF0ZThkb3pxcUV3SlQyQUlIRXNmQlZhc0gvYnd0TFVP?=
 =?utf-8?B?a2wvcDdSZEg2N3Uvc0NaYTBpOHhPbHZJLzVPKzZ6Q3owNzlMOWJDUkVrTzcy?=
 =?utf-8?B?WFlFWUFQeUJEdEt2RHVYRjNXVFRDZlFTMmRWUGg5TndkdHJLVjhCWlZESjFE?=
 =?utf-8?B?OHdQMUJMcnNNSC9pSnpNcXpndXhLbGlXZGVlUmpLNTNkQlJUY01SRG80QitR?=
 =?utf-8?B?OHp6L3ZoMzhkTk9takNPRGlZeDdoUzJkSTVtU0lqa1ZUTmpoV3dOOXRoZHp5?=
 =?utf-8?B?enBCWDF6N1lRWFcrd0tNQjlpUHhpOUZEQTlFcXAxdHVoQ05HZkZQa2kzUTlZ?=
 =?utf-8?B?UTJGUWNpMzdCRVpSZEVIemtvK3A0cDNQRXVoenhRMU5wdzVYOG13eTVGZGN0?=
 =?utf-8?B?VXpKMGsrUkpqRGVxRzk5dTY1d0NMMzMxdnBkcmNaRmxQRzVlc0RscWhObTZw?=
 =?utf-8?B?S3ltN003Nkg0ZHlobGVsMVRlUnhZaTdkZUk1d3FrQlcwa2dVd3J2c3haQUd3?=
 =?utf-8?B?b3dRc1NDMWtvTStmOTJhTjFMaXFpb3lKOWxKVit5b3Z0SWRwOW9VUnMzSGxv?=
 =?utf-8?B?Mjc3d0NrMFR2emVuUk9oVzNDbGhmYWZCcmtpdnBiMm9rZldFNHhFTDUvTzZC?=
 =?utf-8?B?SHFuazBHOUFhWndBczNQOFlpQndpMnIrNnJyb05hRU5MUHQ0ZzhhcDRqbHVL?=
 =?utf-8?B?UGcxTlhsMFJ3eTF0dFNLaWVTQU1HdGdhaWQ3Y0JwYUZSZWF5RHZuVlp5Y1VC?=
 =?utf-8?B?ejRwR0NWbllpNHVuangwRlBQQmE3blgwRVNwTDQ2ZkpEZzBnQUF1Tm1Oc1V5?=
 =?utf-8?B?OEhYaC85RkF2S0w5T0IzYkc0S1hJZXFGLzdsR25PQ0M3RXBJRWF1ZEJIQjky?=
 =?utf-8?B?TTJYMEdOVVFzTUVUaDNLUnZNdjFpNDQxd1UyQlZ1SEZMa0tJRk9MZUFuZ2hl?=
 =?utf-8?B?MU9ISERxZ0REV3RVSEc0WjdpZGxOZVlaQXo0TmZvVW1HbzQrWlNhblJhQjJu?=
 =?utf-8?B?bzl4b05aQ1IxSXhGMW9mTFF2ZGhEbkgydndUaXR4L2p1RUlPaitYZmRFWHUz?=
 =?utf-8?B?U2tlUnFFYXQ2cVJaRU9ZbGlVeW1HRmVRcXdCVXdoYUExRHhQbCs3YW82SHFQ?=
 =?utf-8?B?bkticTkzNnlJc0FvQkU0RHlaRUdRTVNRN092Y0o5U1RkbHA3L0JwTnRlVFVs?=
 =?utf-8?B?VFk0WUxNVFZ2SkJnNW9IRy9IQUdSSWJ2d016elNhRnk5WnEyRUR5eDl5bW9E?=
 =?utf-8?B?QXFzUFo3S3BsRnVFT3dhM29pbDl6dGlWdXdBKzE3SjNQOVRxNTRaUUhJcDlw?=
 =?utf-8?B?ODJNSnJhR1l4LzlxUEpwZGJJc2IyZHFPSTFkcE1GWUFFKzFMcUdMcjJic0R4?=
 =?utf-8?B?Mmd1bHV3SHVUWk8wOGd2aGx2TzY4T0x3aEQ4Nmk0MERCdzdvRFU5Y1pQYURC?=
 =?utf-8?B?UzYyN3hFV0NHMlVVY0V0VXk0ODM3blZRNDk3UUZ6TGVuYitiN1BONHdNd0lD?=
 =?utf-8?B?ZGZSVWk1RjhzK3JhbmVucy9TYlYzQVloMUtranlidGwzS3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1RNcU5iM05GRDZRWWZqbmEydmtNenZCWldiTGY1ZHRJWmdLTFVHdmd2enJp?=
 =?utf-8?B?L1lDYis1eEtLbmE4NFNBVUVIdXJuTHlpZUxEV3k0TjR2dkVDT1JteldyRUxU?=
 =?utf-8?B?WHpsN3o0Um9nSHZmOE9zM1M4M2tSZUNUdE5DR1h5TmZrUE0xdStHN2Y3bHkv?=
 =?utf-8?B?UlRGL29qc25Fc0hYTWRQYTkrSDJ2WWdxbkRYQktGYTZKSUhBWmJFbVlzM1kv?=
 =?utf-8?B?Wit6aUJDbU5oSzlXakFmb0RORHVuOWlsM0xseUkrYnZBMm4rbFBtQUV0NkNU?=
 =?utf-8?B?Sy96ZWp5THlIMGdxYWo0Tjl3QnV1eXl0WjAvYVlaQ0xUTW8zSmpCb3FPL2ww?=
 =?utf-8?B?M055a0MrWWFDdEwrYnE4anRlM1NwaUcyV3lwcmxrNEJMZFpHSm0yN0tyT0NY?=
 =?utf-8?B?N3Bpd0YrREJrVVYrV2tsbGRZSU1RZERUMkVjZzJkTXpybnhzeU5SbzVSc1JZ?=
 =?utf-8?B?elNTczlaSzExWTJsb0ppRSt1b3FDWTAwT2JoZXYxa3p1S0pENUFPQU14TEdS?=
 =?utf-8?B?amQyTWdRNGx5OHhlVG9hR0E0dFJBMFoxdFVXZk5kMHhJYUk2UzgyS3ZoTkNz?=
 =?utf-8?B?SWhOc3pqZW43TE1ZOHk0RHFxV2hocGdUYXYxc090a0xGckhMU041UUt6UUtO?=
 =?utf-8?B?cWhma3dGU2xwNHhWeERRNnFqMmw0VkNGbkdTa0lCZkxFYWpVbm1QWkNTRmxL?=
 =?utf-8?B?WEJjZU1tcCswRTdIMW16ZStnWkcwUWVJMGFmM3FzT1F2bDIxS1BtaFVzYm1Q?=
 =?utf-8?B?ejZTYzVUUnFIQVQyUE1kbnFzZEJhb2Y1VW1MNVlGdWN1MnNjbEdyeEVkZG11?=
 =?utf-8?B?YlBkUURESXpFN1hZNDFnVXJCaGMyYThNYmpTNndlZVJhcW1WcTgzOFJhUkxS?=
 =?utf-8?B?aFoyeWtIVzc0Qkp6OURIT0VsU0oyektlM2ZkeCs3cUxHTnJmRmJHQlpwNE9v?=
 =?utf-8?B?OVUxbC9JVnZYdFVCQ05qbkhyYjgvN1AxR2s5bHpFeDRoSGI0TEY4NysrWlVm?=
 =?utf-8?B?c2tFWC8vRzBjbDhaT0U1Nk1NdG5icE5zN0RpVHMxV2tXRHk0SnBVTHQ2eE1I?=
 =?utf-8?B?SWh0dnRjQU5KcWs3VXNJc0JZQnJsZHFaQnR4SkpWeUdsQzNPbFdIUmk0Ny9C?=
 =?utf-8?B?QVdDZDJpNzhKYTNJZVhqcHcwTjZya0dKNlRBeGk2TFNCaDFHMGJaNVlYMjNl?=
 =?utf-8?B?RVEzQWlEbmlWeW5LKzhZbit3QS9rdmx3T1VjTksvTDEyQS9ra2QyVlFTMkFy?=
 =?utf-8?B?czFoU096cTBsTWo5cjQwcE5ET1E0ZnRLbmhuMEVwWFU2eGdycTRkNDQrTU5D?=
 =?utf-8?B?YnZWS25YNHNCWlNjZFVkSVc3SFFiWGU4VWFpeEhNVk94QkczRktuOXhQTHpG?=
 =?utf-8?B?Z1J5V0E0VlJZd0hWckpvWEoxMXpqeStucnJRS2pmLzBJM21CSUpMWk5ydHJC?=
 =?utf-8?B?SmtNdXBxb1BTMnBnUURMQ1lPMWNDMko1eWVyUnZ2QTNSTEFrdUhaeEsxNE1P?=
 =?utf-8?B?aFFBR1BrRk5odXpxQ2ZPcG10aHowcXhNN0RTckptVVNKdWdkL0JLMFg0U3lm?=
 =?utf-8?B?b0xqUDRrVzM5SG1Vdm1maDdyak42L2QxMERSbUhqZ2RsZE5TQURlVzArWk1t?=
 =?utf-8?B?Y2MwUlg1THhPc3phRlhMZ2tjek9ld1QyWE5ya3dLQ2syanBpVURaaTE5WDdV?=
 =?utf-8?B?czdWL1h0ZXpaQkNBWnJwSEVtbDlKZE9sZVRMVFlWYlBhQzRrSmd4LytYeHh6?=
 =?utf-8?B?eklkU3QwYXV4S0tKYkZRSXB3MkEyTjlna0JkR1h0R1VWWGpjbnpYcS9DU25B?=
 =?utf-8?B?NzNtdGRoNXgwVHZmRzY3N29aT0ppMVpiOWpXa2FyVDRGdVNWV1J2NnV5VVJp?=
 =?utf-8?B?bElpQ3ljcFJFOHZIZE82MENnbWNHNWx5YTE4NTBBd3NWSUNMMXV2ekNXcHor?=
 =?utf-8?B?dWtwQXpQSmwybWdoNWk0YUg2WnMweUVJVTc5dXpXUitZSEpmbk9qcFJtaEhV?=
 =?utf-8?B?ZFhuRURuLy96d3JnMjhLUm5PajFHczVxbHhjOE9URDVqY3NVRWpaaldxUnNO?=
 =?utf-8?B?cCsySUtzN1ZGa3FKVjFVTDA3YzV2aUJObFBBYUd2UGpQWUhyWWM4azh4K0dX?=
 =?utf-8?Q?5yuk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880ac619-18f7-464d-ec57-08dca21dfc88
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 02:54:45.4251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WcZShKZkAENlSLveOm1YWHr4Iswh2mNAsxloOKQ3kxWSBEIiftpQAtsDdYO/7K+Y+PLV+p5dRHLXHZXcuiw+uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
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
Cg0KV2UgbmVlZCB0byBtYWtlIHN1cmUgdGhhdCBhbGwgQk9zIG9mIGFuIGFjdGl2ZSBrZmQgcHJv
Y2VzcyB2YWxpZGF0ZWQuIE1vdmluZyBidWZmZXIgd2lsbCB0cmlnZ2VyIHByb2Nlc3MgZXZpY3Rp
b24uDQpJZiBtYXJrIGl0IGFzIGludmFsaWRlZCBiZWZvcmUgcHJvY2VzcyBldmljdGlvbiwgcmVs
YXRlZCBrZmQgcHJvY2VzcyBpcyBzdGlsbCBhY3RpdmUgYW5kIG1heSBhdHRlbXB0IHRvIGFjY2Vz
cyB0aGlzIGludmFsaWRhdGVkIEJPLg0KDQpBZ3JlZSB3aXRoIFRyaWdnZXIuIFNlZW1zIGtmZCBl
dmljdGlvbiBzaG91bGQgYmVlbiBzeW5jZWQgdG8gbW92ZSBub3RpZnksIG5vdCB0aGUgbW92ZSBh
Y3Rpb24uDQoNClRoYW5rcw0KUml2ZXINCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPg0K
U2VudDogVGh1cnNkYXksIEp1bHkgMTEsIDIwMjQgODozOSBQTQ0KVG86IEh1YW5nLCBUcmlnZ2Vy
IDxUcmlnZ2VyLkh1YW5nQGFtZC5jb20+OyBZdWFuU2hhbmcgTWFvIChSaXZlcikgPFl1YW5TaGFu
Zy5NYW9AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBS
ZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBNYXJrIGFtZGdwdV9ibyBhcyBpbnZhbGlkIGFmdGVyIG1v
dmVkDQoNClllYWgsIGNvbXBsZXRlbHkgYWdyZWUuIFRoaXMgcGF0Y2ggZG9lc24ndCByZWFsbHkg
bWFrZSBzZW5zZS4NCg0KUGxlYXNlIGV4cGxhaW4gd2h5IHlvdSB3b3VsZCB3YW50IHRvIGRvIHRo
aXM/DQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCkFtIDExLjA3LjI0IHVtIDEzOjU2IHNjaHJp
ZWIgSHVhbmcsIFRyaWdnZXI6DQo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJu
YWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+DQo+IFRoaXMgcGF0Y2ggc2VlbXMgdG8gYmUgd3Jvbmcu
DQo+IFF1aXRlIGEgbG90IG9mIHByZXBhcmF0aW9ucyBoYXZlIGJlZW4gZG9uZSBpbiBhbWRncHVf
Ym9fbW92ZV9ub3RpZnkNCj4gRm9yIGV4YW1wbGUsIGFtZGdwdV9ib19rdW5tYXAoKSB3aWxsIGJl
IGNhbGxlZCB0byBwcmV2ZW50IHRoZSBCTyBmcm9tIGJlaW5nIGFjY2Vzc2VkIGJ5IENQVS4gSWYg
bm90IGNhbGxlZCwgdGhlIENQVSBtYXkgYXR0ZW1wdCB0byBhY2Nlc3MgdGhlIEJPIHdoaWxlIGl0
IGlzIGJlaW5nIG1vdmVkLg0KPg0KPiBUaGFua3MsDQo+IFRyaWdnZXINCj4NCj4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+PiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YNCj4+IFl1YW5TaGFuZw0KPj4gU2VudDog
VGh1cnNkYXksIEp1bHkgMTEsIDIwMjQgNToxMCBQTQ0KPj4gVG86IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQo+PiBDYzogWXVhblNoYW5nIE1hbyAoUml2ZXIpIDxZdWFuU2hhbmcuTWFv
QGFtZC5jb20+OyBZdWFuU2hhbmcgTWFvDQo+PiAoUml2ZXIpIDxZdWFuU2hhbmcuTWFvQGFtZC5j
b20+DQo+PiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IE1hcmsgYW1kZ3B1X2JvIGFzIGlu
dmFsaWQgYWZ0ZXIgbW92ZWQNCj4+DQo+PiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRl
ZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3Blcg0KPj4gY2F1dGlvbiB3aGVuIG9w
ZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPj4NCj4+
DQo+PiBJdCBsZWFkcyB0byByYWNlIGNvbmRpdGlvbiBpZiBhbWRncHVfYm8gaXMgbWFya2VkIGFz
IGludmFsaWQgYmVmb3JlDQo+PiBpdCBpcyByZWFsbHkgbW92ZWQuDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogWXVhblNoYW5nIDxZdWFuU2hhbmcuTWFvQGFtZC5jb20+DQo+PiAtLS0NCj4+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIHwgMTAgKysrKystLS0tLQ0KPj4g
ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMNCj4+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jDQo+PiBpbmRleCAyOWU0
YjU4NzU4NzIuLmEyOWQ1MTMyYWQzZCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV90dG0uYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3R0bS5jDQo+PiBAQCAtNTE5LDggKzUxOSw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1
X2JvX21vdmUoc3RydWN0DQo+PiB0dG1fYnVmZmVyX29iamVjdCAqYm8sIGJvb2wgZXZpY3QsDQo+
Pg0KPj4gICAgICAgICAgaWYgKCFvbGRfbWVtIHx8IChvbGRfbWVtLT5tZW1fdHlwZSA9PSBUVE1f
UExfU1lTVEVNICYmDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvLT50dG0gPT0gTlVM
TCkpIHsNCj4+IC0gICAgICAgICAgICAgICBhbWRncHVfYm9fbW92ZV9ub3RpZnkoYm8sIGV2aWN0
LCBuZXdfbWVtKTsNCj4+ICAgICAgICAgICAgICAgICAgdHRtX2JvX21vdmVfbnVsbChibywgbmV3
X21lbSk7DQo+PiArICAgICAgICAgICAgICAgYW1kZ3B1X2JvX21vdmVfbm90aWZ5KGJvLCBldmlj
dCwgbmV3X21lbSk7DQo+PiAgICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPj4gICAgICAgICAg
fQ0KPj4gICAgICAgICAgaWYgKG9sZF9tZW0tPm1lbV90eXBlID09IEFNREdQVV9HRU1fRE9NQUlO
X0RHTUEgfHwgQEAgLQ0KPj4gNTMwLDggKzUzMCw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2JvX21v
dmUoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0DQo+PiAqYm8sIGJvb2wgZXZpY3QsDQo+PiAgICAg
ICAgICBpZiAob2xkX21lbS0+bWVtX3R5cGUgPT0gVFRNX1BMX1NZU1RFTSAmJg0KPj4gICAgICAg
ICAgICAgIChuZXdfbWVtLT5tZW1fdHlwZSA9PSBUVE1fUExfVFQgfHwNCj4+ICAgICAgICAgICAg
ICAgbmV3X21lbS0+bWVtX3R5cGUgPT0gQU1ER1BVX1BMX1BSRUVNUFQpKSB7DQo+PiAtICAgICAg
ICAgICAgICAgYW1kZ3B1X2JvX21vdmVfbm90aWZ5KGJvLCBldmljdCwgbmV3X21lbSk7DQo+PiAg
ICAgICAgICAgICAgICAgIHR0bV9ib19tb3ZlX251bGwoYm8sIG5ld19tZW0pOw0KPj4gKyAgICAg
ICAgICAgICAgIGFtZGdwdV9ib19tb3ZlX25vdGlmeShibywgZXZpY3QsIG5ld19tZW0pOw0KPj4g
ICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+ICAgICAgICAgIH0NCj4+ICAgICAgICAgIGlm
ICgob2xkX21lbS0+bWVtX3R5cGUgPT0gVFRNX1BMX1RUIHx8IEBAIC01NDIsOSArNTQyLDkgQEAN
Cj4+IHN0YXRpYyBpbnQgYW1kZ3B1X2JvX21vdmUoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpi
bywgYm9vbCBldmljdCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcjsNCj4+
DQo+PiAgICAgICAgICAgICAgICAgIGFtZGdwdV90dG1fYmFja2VuZF91bmJpbmQoYm8tPmJkZXYs
IGJvLT50dG0pOw0KPj4gLSAgICAgICAgICAgICAgIGFtZGdwdV9ib19tb3ZlX25vdGlmeShibywg
ZXZpY3QsIG5ld19tZW0pOw0KPj4gICAgICAgICAgICAgICAgICB0dG1fcmVzb3VyY2VfZnJlZShi
bywgJmJvLT5yZXNvdXJjZSk7DQo+PiAgICAgICAgICAgICAgICAgIHR0bV9ib19hc3NpZ25fbWVt
KGJvLCBuZXdfbWVtKTsNCj4+ICsgICAgICAgICAgICAgICBhbWRncHVfYm9fbW92ZV9ub3RpZnko
Ym8sIGV2aWN0LCBuZXdfbWVtKTsNCj4+ICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+PiAg
ICAgICAgICB9DQo+Pg0KPj4gQEAgLTU1Nyw4ICs1NTcsOCBAQCBzdGF0aWMgaW50IGFtZGdwdV9i
b19tb3ZlKHN0cnVjdA0KPj4gdHRtX2J1ZmZlcl9vYmplY3QgKmJvLCBib29sIGV2aWN0LA0KPj4g
ICAgICAgICAgICAgIG5ld19tZW0tPm1lbV90eXBlID09IEFNREdQVV9QTF9PQSB8fA0KPj4gICAg
ICAgICAgICAgIG5ld19tZW0tPm1lbV90eXBlID09IEFNREdQVV9QTF9ET09SQkVMTCkgew0KPj4g
ICAgICAgICAgICAgICAgICAvKiBOb3RoaW5nIHRvIHNhdmUgaGVyZSAqLw0KPj4gLSAgICAgICAg
ICAgICAgIGFtZGdwdV9ib19tb3ZlX25vdGlmeShibywgZXZpY3QsIG5ld19tZW0pOw0KPj4gICAg
ICAgICAgICAgICAgICB0dG1fYm9fbW92ZV9udWxsKGJvLCBuZXdfbWVtKTsNCj4+ICsgICAgICAg
ICAgICAgICBhbWRncHVfYm9fbW92ZV9ub3RpZnkoYm8sIGV2aWN0LCBuZXdfbWVtKTsNCj4+ICAg
ICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+PiAgICAgICAgICB9DQo+Pg0KPj4gQEAgLTU4Mywx
MSArNTgzLDExIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2JvX21vdmUoc3RydWN0DQo+PiB0dG1fYnVm
ZmVyX29iamVjdCAqYm8sIGJvb2wgZXZpY3QsDQo+PiAgICAgICAgICAgICAgICAgIHJldHVybiAt
RU1VTFRJSE9QOw0KPj4gICAgICAgICAgfQ0KPj4NCj4+IC0gICAgICAgYW1kZ3B1X2JvX21vdmVf
bm90aWZ5KGJvLCBldmljdCwgbmV3X21lbSk7DQo+PiAgICAgICAgICBpZiAoYWRldi0+bW1hbi5i
dWZmZXJfZnVuY3NfZW5hYmxlZCkNCj4+ICAgICAgICAgICAgICAgICAgciA9IGFtZGdwdV9tb3Zl
X2JsaXQoYm8sIGV2aWN0LCBuZXdfbWVtLCBvbGRfbWVtKTsNCj4+ICAgICAgICAgIGVsc2UNCj4+
ICAgICAgICAgICAgICAgICAgciA9IC1FTk9ERVY7DQo+PiArICAgICAgIGFtZGdwdV9ib19tb3Zl
X25vdGlmeShibywgZXZpY3QsIG5ld19tZW0pOw0KPj4NCj4+ICAgICAgICAgIGlmIChyKSB7DQo+
PiAgICAgICAgICAgICAgICAgIC8qIENoZWNrIHRoYXQgYWxsIG1lbW9yeSBpcyBDUFUgYWNjZXNz
aWJsZSAqLw0KPj4gLS0NCj4+IDIuMjUuMQ0KDQo=
