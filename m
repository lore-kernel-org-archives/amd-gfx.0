Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0DFC3ABAC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 08:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B59E10E1E2;
	Tue,  6 May 2025 08:59:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iAq5yV24";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E477510E1E2
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 08:59:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Txb4spVKdYETw1alEvP6gZj3lcZCcTJOALVJRNy0RV3k5h6XQEr9OarmTHp2dFXJN8W8ibl4UpF6/E6PFfrSIc7Wak+5DBPRltyxLkU1VyLZ+Smmuz1CJ1BqvzWcm65DSrb+6VZKI4gE3IUQSCFO/Qsj0zOduXpwmQZoOlcHVS73r/FK9sHSKQqXLvenf5Svv365M4W45yHzwhq+PXDVD5oL++SjcUfwQJ/8c+YLAn9QoAkUOc6GR4RMz+zDnrKZj9Q8gmFfJasapKTHwS1O/AtpXhUDaOu/7HR1aDvNDAuFxc+/SZcjnKYKIHe2RppXlsxvuVxcZV8PAIT091ezvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jH1NLz5hkQoCThlopet9grbk66eH07vbm/BpcV1817g=;
 b=btZcNzuW9B1gkEBjeklPesM6UPbNtAgEJosHzXpQsOex6RQo9bKigcZI86iXvmcEQxnD1daKvmdew793Bn9+9ob8myi6OTPWnC34oCVnVokbIP64yOhEhaT7+slshFY+72dYk6RaDs+oHWnQwCB8TpreCsrjNBfYlvME4P8d8u7ziosnoiafQd90BVDAFp7EQffS4i2UI5p2iMScj5Sv29tnyYD+dYiw+DMUHAeMOR36RbPTNty4om4ylLHC1UQSPSjqPjHbEVytIjryto7kEhcKEwOTvFKHb429umEcSMAR/bVva5EJQSlW5mGFNtnLrSUx+VOrOemkC4aq0rb3bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jH1NLz5hkQoCThlopet9grbk66eH07vbm/BpcV1817g=;
 b=iAq5yV24z4Xk3WF6P0ZsoX/ppkytDNdOObC6IarsaJWYPZx/nZkz9wdpqTyGcab+xM1dc7/WDod89Oixl+sQvJ1GcaExg93DQng2mQNX94k+PnhzngeR3SewKI++M2M+xUCmczrfadTH+A0PdoHrRCEJldHGqx1OY+lJfryXTKs=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH7PR12MB6936.namprd12.prod.outlook.com (2603:10b6:510:1ba::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.25; Tue, 6 May 2025 08:59:06 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 08:59:06 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v3 2/5] drm/amdgpu: don't sync the user queue eviction
 fence
Thread-Topic: [PATCH v3 2/5] drm/amdgpu: don't sync the user queue eviction
 fence
Thread-Index: AQHbuXlUoFUeeNQp8UqjNwfLDP6lvbO8Gu8AgAjI35CAAGlpAIAACY9w
Date: Tue, 6 May 2025 08:59:06 +0000
Message-ID: <DS7PR12MB600510EF4659F6E6F530713DFB892@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250430024054.4093239-1-Prike.Liang@amd.com>
 <20250430024054.4093239-2-Prike.Liang@amd.com>
 <5f56c1c5-5bf9-42b9-b7c7-9e6508e803d0@amd.com>
 <DS7PR12MB6005F0A315798BE0F22E05EEFB892@DS7PR12MB6005.namprd12.prod.outlook.com>
 <6258d434-dca8-42e2-8e12-d14d0ef6abff@amd.com>
In-Reply-To: <6258d434-dca8-42e2-8e12-d14d0ef6abff@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=af2534d2-0315-496a-afb7-ac5dc8080b76;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-06T08:57:24Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH7PR12MB6936:EE_
x-ms-office365-filtering-correlation-id: 24554b36-fd9a-48ee-16e5-08dd8c7c41f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?MnNyVE1uYXZ5TGZsZnB6ZDFYN2F2YU04dzh5bEM4RFlCdnNTd1hjczJQUzFx?=
 =?utf-8?B?KzB5US9EUWozR3hWNXI5aGNEZlZNcWNEN1FoQXFYWC8wTUthN3ovUkpseFc1?=
 =?utf-8?B?c1BtWnpZSWUrNFdkZHdCaWNPNlFVSnQ2SStTbG1wc0ZncDJuT1N5R2FuRnpZ?=
 =?utf-8?B?ZDIrT0NmTHJYeUQxeGdydWpzbk5uUGdWcjJRaFh0VFNqcHVsSHVGNGx1YnhB?=
 =?utf-8?B?aUE4cE9zcDk2WjltVVFwVGp0bjRXanoyN0JtNVQvWlcvZFF2MVJrWUM2dDVP?=
 =?utf-8?B?S0NTNTVRMVViRGlCSWdvb0FCZ2t5ZlVWblFRVjJMMGhOcSs3d2FhZmxFdm5y?=
 =?utf-8?B?bHgvRlBsVDZORVNBSHRjVFpYMi9oUkZ4dEFEbGxMSnNxaDMyMFc5T2dDQkpF?=
 =?utf-8?B?VkpJMlR6Nzg2UVdkUWE0ekh6aWpROUZZdUtvbXRyK2VTWlhNbVAvcEVLOERE?=
 =?utf-8?B?bWN2SkFJamMvK05aNjZSbDUzSFA1WFZGeGc2aXNzVmlvR3UwZkxQTUR4VXUw?=
 =?utf-8?B?cyt1cERkK2J6QjNHUEE3ZGRBeEtRWUFVclZnb1gxMjJPN1hLcnJ5RHhybk5w?=
 =?utf-8?B?U2xsbVlQcHlVWFlnSUZpS0tyK1A4MjJnb1RQTW0yazVENGZIQkQ1c0ZLam9M?=
 =?utf-8?B?VUdHYy9zZVZDT0FkQWFNRjVNS2JHdXN3WlpFbGh3LzBxV0kyMW5URmZGSWQ4?=
 =?utf-8?B?aTlTbEJhTm1vUjBhOFUrd1dqSUloZ0JaV1ViUmNqTzVKWGl2WEU2bDZEQXdS?=
 =?utf-8?B?WG8zeXN4aHErTDFxYWVHM3UyckN2ZTZXNGZDQ2ZxUWtGNDlpMW5FZFVkZlVD?=
 =?utf-8?B?RENrOW5UVmlRVDhPREJLUkk2SXZSdHFCcVczc0I5Tm1WL2lFSmhmSkkyL2ZJ?=
 =?utf-8?B?d0ZHemg3UTIyUXlsTWdlUlFhZUJaVklORzBPVTJ5YjN4S2pmS09KSjcyaDQy?=
 =?utf-8?B?YXdCREtHREV4QmhRU2k4a2pvOHpjQWVCVjd6Y3lDSlc1SWhZWVREUW9Ubi93?=
 =?utf-8?B?eEZ0WUlmZHh4d0RIYzI3ckFUaTdZY3lsbktGZ3BnWmp4YmlqOFNCM3k1TkRy?=
 =?utf-8?B?ZlJpVTA4SFZYc0ZHaU1Dc0ZTT0d5R1RJdEcxZ1hRMmtnRkVienZUSVlSUkpp?=
 =?utf-8?B?UDFOM0lKV3B4M1JrcDRmWEtldE5ZRGtQNTRqdGYvUitrWGpXaU51MzFvYUtU?=
 =?utf-8?B?WkxXSS9hUWpJUnhqampNZUdIMlhteElGbVdDdUd0bUhnNnl1Z3djVEx0ZWlh?=
 =?utf-8?B?eVp0Q2Q4MDJiSEF1Nng0ZEl1WmtMU2ZwaXk0czQ5Skt5ZlcyZEdaK2x4M2lu?=
 =?utf-8?B?NDgrb3R2N1gybHI2RXAwbDhEZ1RVd0QxMll2aUZGSjQyNWQyZEZxckE2cTNL?=
 =?utf-8?B?OG5CS0hJdkdjWGthNXEzckVaM0RsbSt4ejZnVmYyNE5ncldhMjBobTlkbzUv?=
 =?utf-8?B?Yzducmt1bkRMaFV5anFNbXlGMDk3dEFVdlZVT2ptUWxEQmRwb2dWa2YrNWp2?=
 =?utf-8?B?bW02Y0JVTzVjT1JOZUhmeHl1Zyt2ZDdnT1Vzd0djRmNVYWt6SVZNZ2ZzZU5R?=
 =?utf-8?B?MTFzVXpGZXV1TW4yWFI0c1ZvQW9uMS9QNXV4eUcwNWpEVytBNDFVWGhIb0tM?=
 =?utf-8?B?TGJHY25LUGwrNHZhVDRydndBVm9seWltVURrd3NHenpGT2dsUXVVWk1aM2ox?=
 =?utf-8?B?K3ZOME9RMFVzWlVpSkdqZmkzM2RGVmNJNVdyd1JMKzBackF3OFdtT2U4YnI1?=
 =?utf-8?B?TW50V29waFRvU1ZCZDNuQkw4aVhmeTZmcGRKZ0hrVnV2d0dON2xKMWFEdSs5?=
 =?utf-8?B?RkU0YnZRRURKWXBJZ2lEamdxZXV5WFdiQTl2eTBrNGdOU1FVK2wyRUpTdWJW?=
 =?utf-8?B?Z3VHZTVONUowWHliVlBWMUYxK1AzR2ZqbjExYlBRMWMrZzhUdnkwSTBoSDdX?=
 =?utf-8?B?V2s1bGNuWkRoVGVhaENNRlZSVC92UmdEcTJLYnduaExEWWhCUDVYSXJZd3Zn?=
 =?utf-8?Q?n1eQZTnhmLl7xZxhLwPejbxgOlT1Tg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkFaY3JJQ3lNUkF0NHJyVE5raDlBNTVpeDlYVzhiMEdocFNrU0NrMnB6UnF0?=
 =?utf-8?B?Ynh0WU1FcDlrdnBCRGVqTEF4SHlUSk1wTkRNMWtaM2p2RkpmdVQ5OWZxeWUz?=
 =?utf-8?B?WjdQK2o2YkN3TDZTR0Rabjl4aG9XWkh3bTVRdy9Dbkd5TnB6b3p5WnNvQm5r?=
 =?utf-8?B?SWZYNitoVnVIQ0c2djVRMnhxQTFnd2x4YlNlREhoVkFBbkFXZUtoUHQvZFpG?=
 =?utf-8?B?dUlKdWVVdnZkNGY0akNaSlNLblBjNDBjcXZFd2ZuTnhVU1Q0cVV0STZOT2hY?=
 =?utf-8?B?dzg2ajFFRHRBRTlERHMwblp3NEtVNktxVGl6R2o0dXNwVFRHQU1oZ1dHM1Zp?=
 =?utf-8?B?TXlLYWJjNzlXdE9LUDhjSDFSMTc4QUFKbnZKaFhGTzFWTURFY2hBcjBSUG5y?=
 =?utf-8?B?SUdkejZyV2ZpZDJNdjlXMVgzYy9TeFczLzFVUWN0YUhQbVpYZVNZZmtJWkFX?=
 =?utf-8?B?SUhKcnl6TUkxSFI1ZTluVGdreTU4Szl2Z0JZL09nTFNMSnNFS3EyOFBxcjFF?=
 =?utf-8?B?bnJOa2ZSbko4d2tRZmxsakdNWC9kSU91MWkwR0NtK0VQd2ZaWnRKejhjOVhR?=
 =?utf-8?B?WFNvZVpGTVVBREZSTlE1YWh0dHE5aUkxWXhEOXp2ODdzc3pJaFlKYmg4MFhN?=
 =?utf-8?B?eWFIMnRqRFc5T1VvU2dnTHVSK1ZGSkUzSy9HZjZ1SDcyaldlN1JuSmQ4bHlj?=
 =?utf-8?B?NWpmQWh3MUlZYlNwcWZBZTFIa1g3b3FjbHNheHJ3TktianRaVkFET2hCRk5h?=
 =?utf-8?B?WmJPVG5LejltUjRnZVFiR1pDdXhxZGFSV3FZaWd0ZWdnaEM0anB1QnlPbHZo?=
 =?utf-8?B?ZG5tRlMvNm5nN25VODlCUTUvTzFMd1B5T3E1bU8wUEhXQnJJdm1yY3dGTk9p?=
 =?utf-8?B?OTduMzZEaDFsSjlCVnZjU3FMY3RCZFl4QjJhMjZJck4vbThQcUswekhKS21P?=
 =?utf-8?B?Rm5rVjNlOGV5SndrSHdYc3NZcmJiZ2UvY0thWEtRR3BHOEl2bWRZT2JhTFJH?=
 =?utf-8?B?VE9aeFFiekQxcGkyYmpqeEdBUDM1VDZzUVN4OFZPK2d4d05oeXBtWkZ4RlFP?=
 =?utf-8?B?MkQ3ZzlrVUxHb3VQUDZ0RFEyY3NlSmtaYzVMREpsenM4alRFSzhSWG50eXlz?=
 =?utf-8?B?cGNZK0cwTFdTRXo4N3V2N0dqOUdJZjFXRkV5NS9iUjZkSHZRdFBVQndudHFW?=
 =?utf-8?B?OXhibXRvcW1mcFpyZ3ViWjNUZkloMGRMcmI5ODZNSXlhMkQyRzZaTHpxWmdG?=
 =?utf-8?B?THFUeC9yMXNlRmY5bytDczEwT2tveHdUaUU5YjRId0E0bFh5Y0loVHRxYks3?=
 =?utf-8?B?Q25IbG1jYXk4dnN3MkUveWJlRXhpWktULzJJZkxqaU1GOEs4a2plVzZCOXNY?=
 =?utf-8?B?TjU0NE1GditCU0M4NWJPSUUxZG1Oa1hXc3BBSFU3dUdLVlhLYWRTcGh0Rm5I?=
 =?utf-8?B?czIyR2R2K09kWXZTVUY2M2lSZGFDZi8xWENTYmkweFc4M3d2b2FBaVVjU3Z3?=
 =?utf-8?B?MGozUXJ0SGRqSDl6VEpGYWtIcW5LQjB2ODJNVzVSSk5nVjRrUzNxQjRkN1Fp?=
 =?utf-8?B?N1k4UlpQNmNKNnRhcG03ZTY5NW9VT1VHZVRMdDVGbTg1VjJUaGQwRWMvbkFY?=
 =?utf-8?B?ditpKzZHR2lqVzlqMm01aEJ5UDVkOEgvR09XWXpZc2RJZU9xdUpVUGxDRHQw?=
 =?utf-8?B?eVRsZkQ1eXZxNDFZWjgzcVQwZ2ZzVkpITGM5aHdRSmc4TjkxbGdUckEwdi9Y?=
 =?utf-8?B?SmJXdlc1alRkVTF6NklFWTdUSzVQYzNWZnQrTzRBczlNdzRldFRtRHlybExZ?=
 =?utf-8?B?dlF6TW9JK2dsUEtDUUZ2SnlQWW1xZUtaKzZwNlBFM0hoU0lMSjd5RXVVZklS?=
 =?utf-8?B?VGdQZWRvT0w1TTJpdVFZWUxKeXZPR1hVWTNaTFVCaXF3SWtueXVXNHN6RGV2?=
 =?utf-8?B?VjdpQkw0QkIyMG54MGZ1QUlUSHlyUjZrV1VBRUY1ako4cFJTNUp0WUZrb2cy?=
 =?utf-8?B?WG5Zck9vVXNkUWpMa0VEKzRRV2xvdjUwQzVhTnFITHZVUFBWYWNMbGVLUy9B?=
 =?utf-8?B?MlZFVDJEc01ZQXBmVFFwdnF4MUloVnJLOXJJL2xSem5LemhmOEFCVmlQaHdT?=
 =?utf-8?Q?dal8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24554b36-fd9a-48ee-16e5-08dd8c7c41f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 08:59:06.6767 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NcFcsnquAW+OYfDJEukex4VtHgE2ECZbP6SmqG87MblIZbS075j+CYRTjjkik7Yh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6936
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
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBN
YXkgNiwgMjAyNSA0OjIzIFBNDQo+IFRvOiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5j
b20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFu
ZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYz
IDIvNV0gZHJtL2FtZGdwdTogZG9uJ3Qgc3luYyB0aGUgdXNlciBxdWV1ZSBldmljdGlvbg0KPiBm
ZW5jZQ0KPg0KPiBPbiA1LzYvMjUgMDQ6MDksIExpYW5nLCBQcmlrZSB3cm90ZToNCj4gPiBbUHVi
bGljXQ0KPiA+DQo+ID4+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmln
QGFtZC5jb20+DQo+ID4+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMzAsIDIwMjUgNzo1NyBQTQ0K
PiA+PiBUbzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVy
LkRldWNoZXJAYW1kLmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAyLzVdIGRybS9h
bWRncHU6IGRvbid0IHN5bmMgdGhlIHVzZXIgcXVldWUNCj4gPj4gZXZpY3Rpb24gZmVuY2UNCj4g
Pj4NCj4gPj4gT24gNC8zMC8yNSAwNDo0MCwgUHJpa2UgTGlhbmcgd3JvdGU6DQo+ID4+PiBEb24n
dCByZXR1cm4gYW5kIHN5bmMgdGhlIHVzZXIgcXVldWUgZXZpY3Rpb24gZmVuY2U7IG90aGVyd2lz
ZSwgdGhlDQo+ID4+PiBldmljdGlvbiBmZW5jZSB3aWxsIGJlIHJldHVybmVkIGFzIGEgZGVwZW5k
ZW50IGZlbmNlIGR1cmluZyBWTQ0KPiA+Pj4gdXBkYXRlIGFuZCByZWZlciB0byB0aGUgZmVuY2Ug
cmVzdWx0IGluIGxlYWthZ2UuDQo+ID4+DQo+ID4+IFBsZWFzZSBkcm9wIHRoYXQgcGF0Y2gsIGl0
IHNob3VsZG4ndCBiZSBuZWVkZWQgYW55IG1vcmUgYWZ0ZXIgdGhlDQo+ID4+IGNoYW5nZXMgaW4g
cGF0Y2ggIzEuDQo+ID4NCj4gPiBZZXMsIG1heSBJIGdldCBwYXRjaCMxKCBkcm0vYW1kZ3B1OiBw
cm9tb3RlIHRoZSBpbXBsaWNpdCBzeW5jIHRvIHRoZQ0KPiBkZXBlbmRlbnQgcmVhZCBmZW5jZXMp
IHJldmlld2VkPw0KPg0KPiBTb3JyeSwgSSB0aG91Z2h0IEkndmUgYWxyZWFkeSBkb25lIHRoYXQu
DQo+DQo+IEZlZWwgZnJlZSB0byBhZGQgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gdG8NCj4gdGhhdCBwYXRjaC4NCj4NCj4gUmVnYXJkcywN
Cj4gQ2hyaXN0aWFuLg0KDQpUaGFua3MsIEkgaGF2ZSBwdXNoZWQgdGhlIGV2aWN0aW9uIGZlbmNl
IHJlbGVhc2UgZml4ZXMuDQoNCj4gPg0KPiA+DQo+ID4+IFJlZ2FyZHMsDQo+ID4+IENocmlzdGlh
bi4NCj4gPj4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2Uu
TGlhbmdAYW1kLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5jIHwgMTEgKysrKysrKysrKysNCj4gPj4+IGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5oIHwgIDEgKw0KPiA+
Pj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMgICAgICAgICAgIHwg
IDQgKysrKw0KPiA+Pj4gIDMgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4N
Cj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZXZp
Y3Rpb25fZmVuY2UuYw0KPiA+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZXZpY3Rpb25fZmVuY2UuYw0KPiA+Pj4gaW5kZXggZDg2ZTYxMWE5ZmY0Li42YzliMmI0M2E5Mjkg
MTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZXZp
Y3Rpb25fZmVuY2UuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2V2aWN0aW9uX2ZlbmNlLmMNCj4gPj4+IEBAIC0yMjQsNiArMjI0LDE3IEBAIHZvaWQgYW1k
Z3B1X2V2aWN0aW9uX2ZlbmNlX2RldGFjaChzdHJ1Y3QNCj4gPj4gYW1kZ3B1X2V2aWN0aW9uX2Zl
bmNlX21nciAqZXZmX21nciwNCj4gPj4+ICAgICBkbWFfZmVuY2VfcHV0KHN0dWIpOw0KPiA+Pj4g
IH0NCj4gPj4+DQo+ID4+PiArYm9vbCBhbWRncHVfZXZpY3Rpb25fZmVuY2VfdmFsaWQoc3RydWN0
IGRtYV9mZW5jZSAqZikgew0KPiA+Pj4gKw0KPiA+Pj4gKyAgIGlmKCFmKQ0KPiA+Pj4gKyAgICAg
ICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+Pj4gKyAgIGlmIChmLT5vcHMgPT0gJmFtZGdwdV9ldmlj
dGlvbl9mZW5jZV9vcHMpDQo+ID4+PiArICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPj4+ICsN
Cj4gPj4+ICsgICByZXR1cm4gZmFsc2U7DQo+ID4+PiArfQ0KPiA+Pj4gKw0KPiA+Pj4gIGludCBh
bWRncHVfZXZpY3Rpb25fZmVuY2VfaW5pdChzdHJ1Y3QgYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX21n
cg0KPiA+Pj4gKmV2Zl9tZ3IpICB7DQo+ID4+PiAgICAgLyogVGhpcyBuZWVkcyB0byBiZSBkb25l
IG9uZSB0aW1lIHBlciBvcGVuICovIGRpZmYgLS1naXQNCj4gPj4+IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlLmgNCj4gPj4+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlLmgNCj4gPj4+IGluZGV4IGZjZDg2
N2I3MTQ3ZC4uZDRlMTk3NWNhYzcxIDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlLmgNCj4gPj4+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5oDQo+ID4+PiBAQCAtNDIs
NiArNDIsNyBAQCBzdHJ1Y3QgYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX21nciB7ICB9Ow0KPiA+Pj4N
Cj4gPj4+ICAvKiBFdmljdGlvbiBmZW5jZSBoZWxwZXIgZnVuY3Rpb25zICovDQo+ID4+PiArYm9v
bCBhbWRncHVfZXZpY3Rpb25fZmVuY2VfdmFsaWQoc3RydWN0IGRtYV9mZW5jZSAqZik7DQo+ID4+
PiAgc3RydWN0IGFtZGdwdV9ldmljdGlvbl9mZW5jZSAqDQo+ID4+PiAgYW1kZ3B1X2V2aWN0aW9u
X2ZlbmNlX2NyZWF0ZShzdHJ1Y3QgYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX21ncg0KPiA+Pj4gKmV2
Zl9tZ3IpOw0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfc3luYy5jDQo+ID4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9zeW5jLmMNCj4gPj4+IGluZGV4IGQ2YWU5OTc0Yzk1Mi4uOGFjNjg1ZWIxYmUxIDEwMDY0
NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuYw0K
PiA+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuYw0KPiA+
Pj4gQEAgLTE4NSw2ICsxODUsMTAgQEAgc3RhdGljIGJvb2wgYW1kZ3B1X3N5bmNfdGVzdF9mZW5j
ZShzdHJ1Y3QNCj4gPj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsICB7DQo+ID4+PiAgICAgdm9pZCAq
ZmVuY2Vfb3duZXIgPSBhbWRncHVfc3luY19nZXRfb3duZXIoZik7DQo+ID4+Pg0KPiA+Pj4gKyAg
IC8qIGRvbid0IHN5bmMgdGhlIGtnZCB1c2VycSBldmljdGlvbiBmZW5jZSovDQo+ID4+PiArICAg
aWYoYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX3ZhbGlkKGYpKQ0KPiA+Pj4gKyAgICAgICAgICAgcmV0
dXJuIGZhbHNlOw0KPiA+Pj4gKw0KPiA+Pj4gICAgIC8qIEFsd2F5cyBzeW5jIHRvIG1vdmVzLCBu
byBtYXR0ZXIgd2hhdCAqLw0KPiA+Pj4gICAgIGlmIChmZW5jZV9vd25lciA9PSBBTURHUFVfRkVO
Q0VfT1dORVJfVU5ERUZJTkVEKQ0KPiA+Pj4gICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+ID4N
Cg0K
