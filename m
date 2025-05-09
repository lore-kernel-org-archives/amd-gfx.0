Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD004C3ABC3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 May 2025 06:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D3AE10E9B4;
	Fri,  9 May 2025 06:31:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="afcoLhmb";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5F1D10E9B4
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 May 2025 06:31:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVAegqV9I5N9RLTS/qrLS4ylHcCf2biIcQ3Qa3kN//iAyVX6hf2odokwKNiFIJZ0N1lDMGCyDocMJZ4b9bypkigKudbqhWeQ1UV5rRuurHY82t0tRCpTY5K1qR67NaIM1VD9s0Hq0MdJ+m2jZ89CUN59HJ9ZOvkfzSmt2I4c1in2W0/3WD5olpL02HHBT/Ig4sxPbr5IqRfnf/ae8Th29FUw2wuh4zulW2fewIMrOlyyQnZcRvQxpLZhGsOLE8es/GDYvyUjBr17jkJoSqJr4/HeXl0dw32OjzherUpYU91CmjDCDPs8/cRaTszqx+xoXoOIvYou99LCPBqzw84u6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFB0znziTmM63JDgGg9IqFPfz1xFMs0+8b261mFk4og=;
 b=w+4JuxX9Zm8Y9LEX5qZTtyfkxssRzuZ01AFqDZswb35uNBSta8FLMwNPW+nsspC7nBh0gx0OUUDu+gxMl5Omx5DGaxQHE+0QwZ1XB+nQcC7IzdkswyaPKhBKFxIt628h3xpVXc/4btRnJbAKcT3C+XfeoCL6vouXuXn0p8XqexAohGFy2Gut7YHGCLG5r6si6hDqLUNWiYuy9L/0MDwuxjX40YhHagXkVfqoSXGnsqcWTubvJeLs6mg149b6zZ5zMjLwXFpWgkW3P5Ak1guz5k4KEk29zp+h5chlduS9t5kwdYpqtBv2XnBInzIz0DnE6/BQHlMA1k3DyicewxhZLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFB0znziTmM63JDgGg9IqFPfz1xFMs0+8b261mFk4og=;
 b=afcoLhmbhlQYF7oZbCZGMcRuWKp55/kroLM6mQUChsQUCwdb8uejRaMuQ9+ArXv3DD6QijGF1m905HGmBfmePDyyfFb7yQHtacSODSsktuFsAKRfOTw3otyon2ESG0B340Jn77M16sfpk4hW7/uIcyci1UzIZwoec81LyYsMTvY=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DS0PR12MB7631.namprd12.prod.outlook.com (2603:10b6:8:11e::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.38; Fri, 9 May 2025 06:31:09 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 06:31:08 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: lock the eviction fence before signaling it
Thread-Topic: [PATCH] drm/amdgpu: lock the eviction fence before signaling it
Thread-Index: AQHbwB9b9o2x7HCgEUOfVgnDPJZaWbPIwZ0AgAER1JA=
Date: Fri, 9 May 2025 06:31:08 +0000
Message-ID: <DS7PR12MB60050C58880E4AE3421632C2FB8AA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250508134428.383605-1-Prike.Liang@amd.com>
 <d7a75e46-96ee-481b-90c3-eaa514569245@amd.com>
In-Reply-To: <d7a75e46-96ee-481b-90c3-eaa514569245@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=9fb7f37a-2c77-4eea-8aa7-84ee4652e0a7;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-09T06:16:15Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DS0PR12MB7631:EE_
x-ms-office365-filtering-correlation-id: 04b3f679-b834-48cd-1f22-08dd8ec31597
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?NFVsRVZMUk9OZmthdkdiM0w1ZCtjejg2cElGcjdIR0JpMWNqUzcwM013QVFL?=
 =?utf-8?B?YjBnMGJqS0NKWndqSkdJREhDRWxTbXdOeERqU25ualpNZ1N0YlRRZThlVVYr?=
 =?utf-8?B?am41bCtMd1QrMDhENkJ4cG9RSmxVNW1COFJXeTFralZpa3BUQ29XTmdjNm52?=
 =?utf-8?B?alJJcXNnMjk5dFlnWjM5dVpEM2xIOEpMVU1DVzU3MHNXaGpmUEFBcXhpOHJN?=
 =?utf-8?B?UktCVVJBVzhnc0lFaENxSG1GNU1xcjZHV29rMHAwOTJUOXlkeENqWXJoY3lU?=
 =?utf-8?B?QURtSStUV3hJZkl5TW8waDM0RUNlSXNwMkRhaCt0Sk9ZaEs2VERYMERIc3FR?=
 =?utf-8?B?L1VjS05WM1AvandQaVNzc1NjNXhqN1lsa2VvcWFpYjAxWjZKV3ZkZ05Ycmdk?=
 =?utf-8?B?ODhHeXk2cEE3Y0o2bGdSMVFVSTN2MVE2Zjc5ZXVHdm9lUEZLZVByUWlkbVBy?=
 =?utf-8?B?YTFsWmtMeGtHbll6bWVFMnhEWDRvZzUyYUttdm5mcUhEdXZpNWlqZWkvWTJh?=
 =?utf-8?B?bE9rY2VHNFlpNjNycFdBbGdyd0dyZmdVbFEyWm5IWUdHZ3lxNHp6V3ZMZmxn?=
 =?utf-8?B?QzVmZ0lpK2FLMmtJOC9VNFBoY0dmWTd1Y2FCQ2Z1NEduTElBN3NTYjNjZlZa?=
 =?utf-8?B?MnUxQi94L3ZoM0ZrMmpseFBSb25nbkN3TTJFZ2JmTlFyNmV6YStJeGI3OVdt?=
 =?utf-8?B?WUJLcGlVOUkyZ1V3TmExa0NaTHliNHk2czhEek1WNjROODBTTXRGQnl1UEJH?=
 =?utf-8?B?Kzk5K1dLTkFGUHFTTmcweG1DT2F4OVdibEY5QnhBdVQ2LzF0TXozL1h5VmtB?=
 =?utf-8?B?WFlPaGJMN2xJRDdKa2k0bEdqNTczLzNZOGRZbS9ES3JaakJQUWw0VnFxUkla?=
 =?utf-8?B?bWJmMDdGWmlCT3BFQmtVKyt0YVgwVjRVQ0hhakI4STN2ZURqMWFwd0RocXpn?=
 =?utf-8?B?L3dOcEhWSVYwMEZ1MVFmVmdncEgxRVltNzVySFFzTEQ2OW1sVTRmV1M0M2lh?=
 =?utf-8?B?LzFvd1FxU0FQWmpZWmlhdWRZSURkVkd0amQrVFJmeVB1aFg0K29jb0UvM003?=
 =?utf-8?B?TkVGNzhjdmtKZnJ0VHAzVkkxOHBVY1VvTFFleEd4azhjWC9zdDk4bDBxeVJu?=
 =?utf-8?B?ay9YblpkTlBRa1A3blg1bmlRbXZCREZBREJXNDVnYkw5U0ZnU3NQVm9Cbk5Q?=
 =?utf-8?B?bGlId2t5czJDaEduY1pkUUx1MytrajNXYXF3Q3YyZG14bmdNN3IvOWlBZTky?=
 =?utf-8?B?R1RISFluV0oxbVpuUmw5cGJmR2FCcE9GcXdsVnRReWVhU3JTNzluNDBkNHRh?=
 =?utf-8?B?V2ZDbDIvYUhBT01FTlcxSDhhL2xMYzJrUmVaSjZudTI5QWtkUkxxajlkbloy?=
 =?utf-8?B?ZC9KOFMybnZFOGY2bWlVNkxHd1dSSlJDQ292SUYvd3NtMXlYNnZBRnFIdmx1?=
 =?utf-8?B?OTN1enlHTHFLWWdCNHdIaUdEbnFjb2xqanFaK1g3a1IyeFFBZDhCbE1FRGlU?=
 =?utf-8?B?N2NsWjBwUUp2Qndody90cG5rRlUyd05XOUJLOWZBR3RNSXVnYUEvUnExQ3Nx?=
 =?utf-8?B?ejJqVnlTWnpjQXladnFkOG83MU41S0tLcjZCWUJLUWJQcmFDSWdhVFM0Wldy?=
 =?utf-8?B?ZFlKcVprRG1xOGw4WjZGLzhmVWNTSFFMQVV1eEFLaVFEUm91U1Z4RUtMME8y?=
 =?utf-8?B?R0E4Q2VZSVZqa01sUVdxYmVUZXNHUXhRNWR5Tm9Hcjg2cDJpOWd0b1NTaERj?=
 =?utf-8?B?M2tnOVNQQmt4WVlzRkxPWTZiMnc5bXNreGFqNytHaGpIZnpyNUdJeTBITWtk?=
 =?utf-8?B?WmxGdkpjcHhXZ1VxWFhaUmxVNHgzR2Z0UXltZEorbjRYZFJTZlZzcFRpNFNk?=
 =?utf-8?B?aDk4ZVdITW54K0hiRmkxY3J2SkRSTldldmprSjJueC92QVRlQld0SnRUc3N2?=
 =?utf-8?B?dWlLOFRDZENNYkFiMFVKQnMwR3FSdkk1bXV1aVVXbHNGWDJCOUE0dUxwZDRj?=
 =?utf-8?Q?T2wxOU1Bngh8ttF9ViRqDl1yTA0XZ0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVBuU3NGNExiUjFobWNLZXZ1dzg2bjByNVZyVkZHNmNESXZGcUdiSlpIbVR6?=
 =?utf-8?B?QmNXalZTQ3VzSit6Sm9BSHo3VjM3eG5zdlAvRGdBeE1FeTdKWXNwNXBkcTNY?=
 =?utf-8?B?cnVmbVcxQUp6cjdIZGtoMjU0UjBhSkZNeU5RZGNuck41STdsL2JVeEpmQTFY?=
 =?utf-8?B?c0RBTE1XS0lxeTBBK09Sc0NVVUJpdUJNYXFLdkxFQjQ2Z0hudXRPZmlyTzRx?=
 =?utf-8?B?dkx2Ny83YnNhQXZoekNhc1EvN01NdHdHL0pBRHd0ZEJwNXBHL1JDUStDVEZr?=
 =?utf-8?B?ZVNUSkZuZTNKeVlBQURaL1VPOXlxTnhvcFpSZ1hSajMrRDl5Q0E4WDByeDRD?=
 =?utf-8?B?eG5GVUpjd1EzN0QyeEJNNzdXNGw2KzRBbmpocGNJbmFiVW9xOUJ1QldpbXBX?=
 =?utf-8?B?K2lUNEhyOTN5NjNrU3hHaUc2amkyTnhNc1pCTDA1QkZsZDVIK0g5dDRWQXFT?=
 =?utf-8?B?dEYzcStwc1lCRllhVXkydFpVWkFtZ0kwRnEvdFl6NGc1dzd6bmRwTzJ1VDFB?=
 =?utf-8?B?NnFkNnhrWGYrY3FpaGdlbFFEMWVsc09RY0gvM3IvNDJ3Z3YrTFZsaEl5cXBZ?=
 =?utf-8?B?STlEc0o4Wk1ZQ2w5emRsY3NTWGlKS0Z5K3M3VTlhU1cxTDdTQzN5cTA4VW9K?=
 =?utf-8?B?UUpsNkxvZ00vUHdzcnQwZXFXUU9QZVpPS1UrQUVEZXNvdTNybnYrZCtRU1hU?=
 =?utf-8?B?NG5kbFEvZi9FTlh4L1lMK0cwZGEyREpEM01HRVhadzJEa2FPVERPUXplbTVD?=
 =?utf-8?B?THhuM2IyVkJycFpVNVRnRkdOU05ndG1zdDdxOFEvVWdFQmZtK2w2SkNkSjJY?=
 =?utf-8?B?N2ptUURML2U4S2tlV2oyeXRjQmdTajFEUldHRFdwb0VISXE0MnNUcExCN0F1?=
 =?utf-8?B?bUpOenZHNk8rUi9JK2tDdWNPRitxc3lEOHB0TnFGeTl0bzZoRU9FdnBmZHF3?=
 =?utf-8?B?aFBSTzBUakpJdXNiSTVDa3NkSWNJdHlaME9BTGpocUhGQnlXc3dvMlMxT1FK?=
 =?utf-8?B?UHdhcTJXK0tabVA3YzVXUk5teG03M2k3UUxiWVRuU2lpdzdQWGc1UkNzV2l1?=
 =?utf-8?B?OUxrUFZPeFI4N0ZEVTFkcUVIQnQzV25TY2lqaklpakJ2MVJvejkrU0NwYlJh?=
 =?utf-8?B?cUVVUWREeWlld1plK2NYTzNHaFY0LzhMSTFzc2tkbTNpVlNKZGhjTnVmNkZ3?=
 =?utf-8?B?WDNreW14SGlrNytPd1JDb1RkVGxYSThrNjdFdzhnVlFFNDM5RUdDUVlTcVp4?=
 =?utf-8?B?cHljSzlkN0tGV0UwdVoyUkNSTmNEd2p1N0UwQndsV0dqd1ZraGR5Z09sb2pT?=
 =?utf-8?B?VU0zRGV0MUdmUkhuakZmTWlkRzJFTlZXT2ZJa1lBVEtFN0lUaStidWxWUG8x?=
 =?utf-8?B?Y3YzVXpxdmNLRU5ER1ZXQU5ObFBZRittVzF1RWQ2YjNxR1NIMmp6bjRoNEF6?=
 =?utf-8?B?dmZJdmlUajZLWkJKajRxaGMrTGY5aU52Unc0MjZmeUlFMi93RE5OMmtZRnBs?=
 =?utf-8?B?dHc0MklyQWxQcWE4czFRR2dzeEN0czRMRW9xLy9yMmdTNzR5UHVjU0UrWXVk?=
 =?utf-8?B?bHAySUpJUHFoczM1bnBuOVpPRThvUHltZ0ZVdWZZMkRBUEExejNwbk5iM0Y2?=
 =?utf-8?B?ZVVzT1pPZm1pbllzVDZPUHFEYjZkVlFwNnRuL2drYnFrcUM2dXVPYjZWZytC?=
 =?utf-8?B?R2tRRG12WVA1bUFTcmlvNDJDKzloN3c0VTBkNENIOHIzZG1zdXJrVWtiZTBM?=
 =?utf-8?B?aTFxODRKMDBaQUNpSUt2dWF3ODFFSVR0d2hKV25aSmhjODlxMjc0cnFUMVNs?=
 =?utf-8?B?SDRyTEU5cThmRUw4WCtSYktSRTFxQ21YUzFUZnNaalh1VzE0Q2xnR2V4Rmwv?=
 =?utf-8?B?YnlSSExkK1AzTGtMaHJhUXRlZmdLOGc3VFR3eDVBbGxSYjFVckdCeEhZZlR6?=
 =?utf-8?B?Q21hVURpWFIyUXRnMVd2V1QrYTBTeU1TZGZFMjh4a2k0cjdvMU5CS2ZvZ05M?=
 =?utf-8?B?Q21uOWphQysvcWltSEZPbXVKU05CaUxlamRRU2lnVUdaZmZYL2svSzFVclZO?=
 =?utf-8?B?Nk02WDg1VHZuV1BGQnQyZHNUUnNvNmU4WWZyWHl4Nk51ZXRRbC9SRVd0Zy9v?=
 =?utf-8?Q?8q9M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b3f679-b834-48cd-1f22-08dd8ec31597
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 06:31:08.8358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HIAau41cWn+MQU8byf1LgoM4RuLVySF6w1kImxdtHPqUelEhEUYNQYo2YZT/EpMM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7631
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
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwg
TWF5IDgsIDIwMjUgOTo1NiBQTQ0KPiBUbzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQu
Y29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
ZHJtL2FtZGdwdTogbG9jayB0aGUgZXZpY3Rpb24gZmVuY2UgYmVmb3JlIHNpZ25hbGluZyBpdA0K
Pg0KPg0KPg0KPiBPbiA1LzgvMjUgMTU6NDQsIFByaWtlIExpYW5nIHdyb3RlOg0KPiA+IExvY2sg
YW5kIHJlZmVyIHRvIHRoZSBldmljdGlvbiBmZW5jZSBiZWZvcmUgdHJ5aW5nIHRvIHNpZ25hbCBp
dC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZXZp
Y3Rpb25fZmVuY2UuYyB8IDUgKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5jDQo+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlLmMNCj4gPiBpbmRleCAxYTc0Njk1NDNk
YjUuLmRkMjcyYzFmY2JiNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZXZpY3Rpb25fZmVuY2UuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5jDQo+ID4gQEAgLTEwOCwxMyArMTA4LDE2
IEBAIGFtZGdwdV9ldmljdGlvbl9mZW5jZV9zdXNwZW5kX3dvcmtlcihzdHJ1Y3QNCj4gd29ya19z
dHJ1Y3QgKndvcmspDQo+ID4gICAgIHN0cnVjdCBhbWRncHVfZXZpY3Rpb25fZmVuY2UgKmV2X2Zl
bmNlOw0KPiA+DQo+ID4gICAgIG11dGV4X2xvY2soJnVxX21nci0+dXNlcnFfbXV0ZXgpOw0KPiA+
IC0gICBldl9mZW5jZSA9IGV2Zl9tZ3ItPmV2X2ZlbmNlOw0KPiA+ICsgICBzcGluX2xvY2soJmV2
Zl9tZ3ItPmV2X2ZlbmNlX2xvY2spOw0KPiA+ICsgICBldl9mZW5jZSA9IChzdHJ1Y3QgYW1kZ3B1
X2V2aWN0aW9uX2ZlbmNlICopZG1hX2ZlbmNlX2dldCgmZXZmX21nci0NCj4gPmV2X2ZlbmNlLT5i
YXNlKTsNCj4NCj4gVGhhdCBjYXNlIGlzIG5vdCBhIGdvb2QgYXBwcm9hY2gsIGluc3RlYWQgcHV0
IHRoZSBkbWFfZmVuY2VfZ2V0IG9uIGEgc2VwYXJhdGUNCj4gbGluZS4NClRoYW5rIGZvciB0aGUg
c3VnZ2VzdGlvbiwgYXMgc3VjaCBjaGFuZ2UgY2FuIGJlbmVmaXQgb24gdGhlIHJlYWRhYmlsaXR5
Pw0KRG8geW91IG1lYW4gc29tZXRoaW5nIGxpa2UgdGhlIGZvbGxvd2luZyBjaGFuZ2U/DQoNCiAg
ICBzdHJ1Y3QgYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlICpldl9mZW5jZTsNCisgICAgICAgc3RydWN0
IGFtZGdwdV9ldmljdGlvbl9mZW5jZSAqZXZfZmVuY2UgPSBOVUxMOw0KKyAgICAgICBzdHJ1Y3Qg
ZG1hX2ZlbmNlICpiYXNlX2ZlbmNlOw0KDQogICAgICAgIG11dGV4X2xvY2soJnVxX21nci0+dXNl
cnFfbXV0ZXgpOw0KLSAgICAgICBldl9mZW5jZSA9IGV2Zl9tZ3ItPmV2X2ZlbmNlOw0KKyAgICAg
ICBzcGluX2xvY2soJmV2Zl9tZ3ItPmV2X2ZlbmNlX2xvY2spOw0KKyAgICAgICBiYXNlX2ZlbmNl
ID0gZG1hX2ZlbmNlX2dldCgmZXZmX21nci0+ZXZfZmVuY2UtPmJhc2UpOw0KKyAgICAgICBpZiAo
YmFzZV9mZW5jZSkNCisgICAgICAgICAgICAgICBldl9mZW5jZSA9IChzdHJ1Y3QgYW1kZ3B1X2V2
aWN0aW9uX2ZlbmNlICopYmFzZV9mZW5jZTsNCisgICAgICAgc3Bpbl91bmxvY2soJmV2Zl9tZ3It
PmV2X2ZlbmNlX2xvY2spOw0KICAgICAgICBpZiAoIWV2X2ZlbmNlKQ0KICAgICAgICAgICAgICAg
IGdvdG8gdW5sb2NrOw0KDQogICAgICAgIGFtZGdwdV91c2VycV9ldmljdCh1cV9tZ3IsIGV2X2Zl
bmNlKTsNCg0KIHVubG9jazoNCisgICAgICAgZG1hX2ZlbmNlX3B1dChiYXNlX2ZlbmNlKTsNCg0K
PiBBcGFydCBmcm9tIHRoYXQgaXQgbG9va3MgZ29vZCB0byBtZS4NCj4NCj4gQ2hyaXN0aWFuLg0K
Pg0KPiA+ICsgICBzcGluX3VubG9jaygmZXZmX21nci0+ZXZfZmVuY2VfbG9jayk7DQo+ID4gICAg
IGlmICghZXZfZmVuY2UpDQo+ID4gICAgICAgICAgICAgZ290byB1bmxvY2s7DQo+ID4NCj4gPiAg
ICAgYW1kZ3B1X3VzZXJxX2V2aWN0KHVxX21nciwgZXZfZmVuY2UpOw0KPiA+DQo+ID4gIHVubG9j
azoNCj4gPiArICAgZG1hX2ZlbmNlX3B1dCgmZXZmX21nci0+ZXZfZmVuY2UtPmJhc2UpOw0KPiA+
ICAgICBtdXRleF91bmxvY2soJnVxX21nci0+dXNlcnFfbXV0ZXgpOw0KPiA+ICB9DQo+ID4NCg0K
