Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA550C27C55
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 02:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21D6D10E684;
	Wed,  5 Jun 2024 02:54:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3jERPDIj";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0059C10E684
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 02:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9WjpCr5GInUSzyO8zj1RBJBId8Lv4CYUiGg82Rk1l258aaAiMKGkQsL4VlFp5YxLAAluwv+J5166w1YeWM4IEOZ9Czp5jbs+xZU1fFDMh+onM0l8Ay6XTPS+PVS6GdIlZQbRDSbnTCpvGE7ECWW/LYquY7OEsluLSZeX1FwJArcAlMGUfA8j/4nFZDbfCd1fzVW9eyEC9LSsKdmtpcxUu4keZalQSr0LVZ0FUu76GMOVl6dXmoq19wHmoZmOc5LjS4oTt1sXPAIhVV/97K8UjQ6zlSFah6WJk2amFi3bKWvfjlmNfJAQiQvkozB8mPWl0lXyqf22ikjKQFcDtmsOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFV6X48qNdY0A4CLBBhcON1iUXf1ZWpyGa9/TpYDVGw=;
 b=HY6qAyZLK0lA4AwqDT0EBxWqxnlQJIcnXaDfVyf9GwurTUlX3Mclb0DUrG/WyWerPZs23wMQZgPQaNNT8+q/rld3zSu7nWCwcyvyEtINl0ArCwOyWUOn1qvkZxsC+1NY12O32KJhO490NSfFw/uXb0bTCaL0mEYL+4VF2YrMSybVLasp9yYfSjZvs9Whp5WqOfhlC+y0kboZbwstzNSVumM2ZdeN8ckpV1SqkF9rArjMFjIa2xCLx9YgIuGRJT8HqEidTdOBEQYXJidnQakHHRLsobouvL0uJBg2RDdYrw7ezt7zt1Sh+6fgU9TDkdPnG2TqUJ64PN7PrmRBLrYCuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFV6X48qNdY0A4CLBBhcON1iUXf1ZWpyGa9/TpYDVGw=;
 b=3jERPDIjTJN2g5mITQSp9kmT8Nx87YQBRWuH+HL3xhXiT0P6K9GcIfKi7NiWYO+O7PE6ZwPd6D3iK98Ki8oxcmr8Y+gg5YqMSbL4KMuznBv4N8eX6Izqj1fJqjbtrGoInA/72ixSK2DLA+zSmasBhEOiL9TNg6sDvLs0VO0ypNM=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 5 Jun
 2024 02:53:54 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%3]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 02:53:54 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH 10/12] drm/amdkfd: remove dead code in kq_initialize
Thread-Topic: [PATCH 10/12] drm/amdkfd: remove dead code in kq_initialize
Thread-Index: AQHatZL3lmbktRImQ0uoU5+88mQpfbG381WAgACBILA=
Date: Wed, 5 Jun 2024 02:53:53 +0000
Message-ID: <DM4PR12MB51524932C3FACE9F0B29F934E3F92@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240603084927.2570235-1-jesse.zhang@amd.com>
 <fb11113c-f4c1-497b-95f9-e80eb4e261eb@amd.com>
In-Reply-To: <fb11113c-f4c1-497b-95f9-e80eb4e261eb@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fef721fa-8c27-4108-be18-25039a56ca13;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-05T02:26:42Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|PH8PR12MB7445:EE_
x-ms-office365-filtering-correlation-id: fd1b0d8a-eee4-4b35-e97e-08dc850abc9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?V2ZpbWRpS1l6RlppWTFiMy9nNDVDelVGNGNZZkhxbVA3cXBPYnhYN1p5SkJm?=
 =?utf-8?B?RzFNRXdHcGwzMkpVNG5WanY2bkVpQlYrRVFkQ1E5VkJVNkFKU0k3em80NFhv?=
 =?utf-8?B?TU9FOHNWYStvaWJpbisxSEk2NjUyc2lZQk1Td3JCQ2p6SEpZVGxOck5DMzRC?=
 =?utf-8?B?cW5SV2ppUy8rOGdlVXZodkR0TXdRNXMvcFJnQTNyQVFxVnBQL1RLUU05UElW?=
 =?utf-8?B?VTNhUzlaK292dEp2SHdvRHVJUFJZK25EMWlkaFV2Ui9Ldkx2ZTFGM0FTN1RX?=
 =?utf-8?B?cjFPN0UvZlI4NjZINDdBa1JWVzRUclFlZExoR1l0c0JhRGNWbEoyYTR4aVdu?=
 =?utf-8?B?L3NxcGEzaUlRbzZZbHE5WDJBL3JFWS9jNnJnQ0pQdjFRNGxHRkNOY1ZYbVRm?=
 =?utf-8?B?cmpSWFZlRU9HT1pKTTBXdkVLVitieEViY21mR1pGcGJRc3FvaXowSjBGNzNu?=
 =?utf-8?B?b3lHTHl6UlZkc3VLU0Yrc2JZdDJEaXJ0MFdGdHlrVWRSY3VMOFhzMnRYMG9p?=
 =?utf-8?B?cE1aU3FZKytEcHVkMm00Nis4c1hNRTd0cCtuMHNiU09OemZOVkZ3NXA5dDI2?=
 =?utf-8?B?K1NBdWFsWVY2bE93dWdzK0ZlMzlEL05kVXVnZWREQkhCaklpYVhYT2M0d09p?=
 =?utf-8?B?TzJrNUduQlZYMU5sU2hmZzBBV2ZkZWwrUXVidldSYkR2WmlHTEVhaWhEMU13?=
 =?utf-8?B?Ri9UOGJsdHg5Nkg1M0VrcHpUTzE2RXRUVVJDd0RYaHZUZDdYUkNqdWNhN3Ez?=
 =?utf-8?B?MFM4Yk4wbGdHeUJjWkpmL0NWbjZoNDBUanl1SVh3YkEwbzBMbWxWU1ZJbDlz?=
 =?utf-8?B?RXF4UzR2c3FuT01DSHBIOEpCc2xpR1EvZGxDaStUb2FmTEw1ZnROZzdtM2pE?=
 =?utf-8?B?UVhyU0h4RDdNcVNoQnlpYWdMdm1iZm5ySmdDTjJZMzZnVktMMUY0SnZDSGlG?=
 =?utf-8?B?RThyM1pDdjJsVGZ0VDlkRHBtYTlDZHhpaFh5MWJVcDFMd3R5SERsNVJDb3d0?=
 =?utf-8?B?QktCVStZSWVDS0xBWjBUc0h1Y2NZZ3BOZjVscVpndjZrdmNzZWdiRnRjMHcx?=
 =?utf-8?B?T0tyRU5CT1RRN3E1Y01qNjBmd0k0OHZ0MlltNXBTL3k1dHg2dWdUa1J1V3U5?=
 =?utf-8?B?TENWYzJSdGh0Q1hxc1VUM3g5WnNub212ZHlUU3hEa0VYWkRleFNXUnZtaWlW?=
 =?utf-8?B?L3FZdzdjemtHdDA1WFJORHdPNUtydWk2M1h6YWMzVXc2blFPbzJ3cFFhcThK?=
 =?utf-8?B?VDZNNFo3K0V4ajEwTzdZcjVGSXEwczBVM0hNYTlWTmR6eEtnZFptTGsvTjFU?=
 =?utf-8?B?akh5cG9FbnM2Y3Uzb013bHBWWExCeXlyNVh6UWp2MC84WHU1S25mek1ZZk5w?=
 =?utf-8?B?SCtBQnBONENYencyWEtSVFRGNDhsbnFINWloMDVBejRQMkVZOExEUlBNVG9r?=
 =?utf-8?B?Szl2a0FXcUNQRm5uSVpMWnFIVm96dVZlYUEvZDZnc3B2OGltRDEwL013NXln?=
 =?utf-8?B?cW5sdVlCWmxISyt0NS9wN3hOQWRYRlh3b1BWQis5dmFrbU04VWV4bkJHdTdY?=
 =?utf-8?B?eE5waFZBLy9acmRJU0dKOUhUNmRLcm0zaGtyMUxzZW9BRFNUVTNUdkR4MGta?=
 =?utf-8?B?eG1ycnlGeTVabWhVRzlPb2lJeDBVT21TNmtTWk4vY0x3RE5hZHhEdGJWdVox?=
 =?utf-8?B?QVp4dW1RMjd0dktsMjN1VmMrdzdINjJjRzBBL0VaOWZndHFDV01DN2Z4WmlP?=
 =?utf-8?B?bll2UkRNZmh4WGJXQlRkZnJpTy96SWFiSzE3WmJKQmR4R0dkZmN1azZ5WVNS?=
 =?utf-8?Q?VvEaceMLHJPDtd1xBWHOlWvl2y/JFHrGYBfQU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0lYTFNsS205V2FJTzhOay9FOXZEb2t6NEVrZHVQWUMrUU5VdHdZbnc4cnkx?=
 =?utf-8?B?bHJFc24rVEhZdWVzdkFiaktUTlNHeStGYzlxa2c4c3A5SDRveXpkTGJ0K014?=
 =?utf-8?B?QlFpa3BaZHMrQlZDeHNDUmtiNFR5TFBhRjJJSklrdXl2REpyaDQ3dzJCaFBZ?=
 =?utf-8?B?WGpVSllQVi9MUnNhMEV1azB2RGtxR1diYmh4Q2RXVjMwOTRDaWdxUTBabStB?=
 =?utf-8?B?TWtZOFZMSHlrOWZMYy8wcXQ0eDFNSnloUnJFUitJUjZKNHB6QlVKeUtwWFRL?=
 =?utf-8?B?a2RUdXJqU29nRThpSnZVNjBzQU0vOWxLL21kOEFjS0JIWFR3MDlrS0w1QWRM?=
 =?utf-8?B?STVCVjZ3VTJWUEZic3lzT2syY0xneGlETmd3NVpNS3RiY0o2UU40NU9UR0VW?=
 =?utf-8?B?NHBoc25NYjIrTjBremFhSTJvbTQxdUVBSHVaaEVaVjloQVFqK1JOQnIxT3lF?=
 =?utf-8?B?UUdiR242NEd4RWV3TzhKWTZwRkx6dTQzU0lOYWloYXoxUVBhMEdVYzlINzA2?=
 =?utf-8?B?SFo1alp2M0VVaVhWeDV6cld1ZFNpdUxVVStyWnA4SkZGSjMwR1JxeitjOTlQ?=
 =?utf-8?B?dkwwazhHTHJyZmJtMlEvMC9rZ2Y4WUMxaXdnREh4bW16ZHhqektDcnhSamEw?=
 =?utf-8?B?U2p5aG01b2FPbEJQQlIydjNORGV0QXhBMzQzU21IZGdFVTVuRFhEWTJOWWc4?=
 =?utf-8?B?UlVlL0pUbllFbCtqcDFBcVdhY3RieGVvd2cyV1RQQTJXM25ONzVZVWdrU3hC?=
 =?utf-8?B?V0NSVDF3SHpJZEM4MTh4bE80STlWa2ZTTDFvMzFybmxqVTZhNXZIOHVtUFF4?=
 =?utf-8?B?N0xHQzNqSTNQQXo0d3MyR1lKOC8xZGVFcTB1bHdKUTJUU3puNXpMZEJBWTVy?=
 =?utf-8?B?TTU4WUhOejJ1aGRCY1VFRElNNDdMMzFmUWZqRm85MitZVG96U2h5TXdVYXJN?=
 =?utf-8?B?SkRxSUw5YVNha1gycTFKK2MrbkhVNXlGbDRCSFczbW5TaFVCRjkwM0lSNjJ5?=
 =?utf-8?B?cmV1RmRGNTNlZDdpTG8xWk1xc3lhanFONXkxY1JhM2ZMbjBiVkhGK2dCV3Vy?=
 =?utf-8?B?Si9tZGdLeE42YVM1UkczL0dmcnMwN1BMUzBlbXFFQytMSzlKMWtaRW5UeUlo?=
 =?utf-8?B?MXhFbWwxdkhUMmVSSU9ESGkwUjh4ckhrbi8yMll6bmc5MktQZFdaUEdncjdP?=
 =?utf-8?B?elBzS1drd3ViWW1rUVZUbzVXVjZkRUdNbDRuaFczbnlzeFZwdmxvS0paMWN0?=
 =?utf-8?B?VHFxUDFDV3VEQWllSDZKZW1nZGpmc3pwVlJBSUxUWUY3OUdDS2F0MkVSVjNm?=
 =?utf-8?B?ZVdpbThiNHpDRzd6QmFGZjhOUjh0R2NlL3JLWU9Hc0F1WEdTSlNPb2J3WFk4?=
 =?utf-8?B?eDh2WlQzcUVKR3lzTHFWczVlWTRsRkNlT0dvN1dEQ3A0WUx0dnA3Rm5Pcnh6?=
 =?utf-8?B?OEQ3NGpPcHBTVTFNK01yUW1sV1VNTlUvUmxxZFFjUVJ3aE9yN29xV0JqUkMv?=
 =?utf-8?B?bkd5bFhwTlNVSHd2YVFYQ081SlE0UjhWZFFvRW83QUJZUWpSR09oVjFhN0JD?=
 =?utf-8?B?MGRIN1kxV3RZeUZxVEVSdERjamt2TThQTkNjVDh4dnUzcWEydzkyWUVVUTNG?=
 =?utf-8?B?ZXpzeUhqSjV5eXdZeXQxejlZQ3hQcHV3T3RLQ1J2NWRJVmxTaGR6dEt5VmR1?=
 =?utf-8?B?RVRHaHVjKzNhd2VaT0NFd28yWlNsUE8rSjZncHZzbVZzVUJ5M0M3cFQxUzAy?=
 =?utf-8?B?QXRvR25iV3JTNUsvbnpiOVBVdlZuZTZDUVJ5S1hISjBGbWV1V1JmN1BURzJP?=
 =?utf-8?B?czMweURKVFpxb0JBamdrSEQ2eXQya3JDaEV5bnEzWllPeHA0QVVXd2ZIZGxU?=
 =?utf-8?B?a0NNWXlCeFF3cDgvNFdXMnpNSEZYQ29sc0xMMEswRzNDenpXR3BOMlZ0cVVK?=
 =?utf-8?B?L3kwZGs3eG9sV0g1ZjVvcjBwQkxPcDVGSk81bUFOdG1XL3pXbVRZME95Tzd3?=
 =?utf-8?B?ZzhtQjVQWThHMUpUQVJUQnBZMm5kd2lrYlpod3Blb1M3ODFHc0dXbjhrUDlS?=
 =?utf-8?B?QWFhcnpUQ2hyQnM5K0lOaWx4ZEdDeTZpcHY2TkxDMHJZZkp3UEVvR0dTNGwz?=
 =?utf-8?Q?/ypE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1b0d8a-eee4-4b35-e97e-08dc850abc9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 02:53:53.9611 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gSl8/NQUoj3Z5hX01lc/AhbN9sY8O3sK+DZWpFSzyBr/SWzkCExUsU93QQDadp2zAzOg5SvUYSLvgeGFzmuH5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445
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
Cg0KSEkgRmVsaXgNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEt1ZWhsaW5n
LCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NClNlbnQ6IFdlZG5lc2RheSwgSnVuZSA1
LCAyMDI0IDI6NDUgQU0NClRvOiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNv
bT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hlciwgQWxleGFuZGVy
IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlh
bi5Lb2VuaWdAYW1kLmNvbT47IEh1YW5nLCBUaW0gPFRpbS5IdWFuZ0BhbWQuY29tPg0KU3ViamVj
dDogUmU6IFtQQVRDSCAxMC8xMl0gZHJtL2FtZGtmZDogcmVtb3ZlIGRlYWQgY29kZSBpbiBrcV9p
bml0aWFsaXplDQoNCg0KT24gMjAyNC0wNi0wMyAwNDo0OSwgSmVzc2UgWmhhbmcgd3JvdGU6DQo+
IFRoZSBxdWV1ZSB0eXBlIGNhbiBvbmx5IGJlIEtGRF9RVUVVRV9UWVBFX0RJUSBvciBLRkRfUVVF
VUVfVFlQRV9ISVEsDQo+IGFuZCB0aGUgZGVmYXVsdCBjYW5ub3QgYmUgcmVhY2hlZC4NCg0KSSB3
b25kZXIsIGlmIHlvdSByZW1vdmUgdGhlIGRlZmF1bHQgY2FzZSwgSSBndWVzcyB5b3UgYXJlIHJl
bHlpbmcgb24gdGhlIGNvbXBpbGVyIG9yIGEgc3RhdGljIGNoZWNrZXIgdG8gZW5zdXJlIHRoYXQg
d2UgY2FuIG9ubHkgcGFzcyB2YWxpZCBlbnVtIHZhbHVlcyB0byB0aGlzIGZ1bmN0aW9uLiBJIGRv
bid0IHRoaW5rIEMgY29tcGlsZXJzIGFyZSB0aGF0IHN0cmljdC4gWW91IGNvdWxkIHBhc3MgYSBy
YW5kb20gaW50ZWdlciB0byB0aGUgZnVuY3Rpb24uIFRoYXQgc2FpZCwgdGhpcyBmdW5jdGlvbiBv
bmx5IGhhcyB0d28gY2FsbGVycywgYW5kIGJvdGggb2YgdGhlbSB1c2UgYSBwcm9wZXIgZW51bSB2
YWx1ZS4NCg0KW1poYW5nLCBKZXNzZShKaWUpXSAgQXQgdGhlIGJlZ2lubmluZyBvZiB0aGUgZnVu
Y3Rpb24ga3FfaW5pdGlhbGl6ZSwgd2UgY2hlY2sgdGhlIHF1ZXVlIHR5cGUgdGhhdCBjYW4gZW5z
dXJlIHRoZSAgd2FybmluZyBhYm91dCBDIGNvbXBpbGVycy4NCg0Kc3RhdGljIGJvb2wga3FfaW5p
dGlhbGl6ZShzdHJ1Y3Qga2VybmVsX3F1ZXVlICprcSwgc3RydWN0IGtmZF9ub2RlICpkZXYsDQog
ICAgICAgICAgICAgICAgZW51bSBrZmRfcXVldWVfdHlwZSB0eXBlLCB1bnNpZ25lZCBpbnQgcXVl
dWVfc2l6ZSkNCnsNCiAgICAgICAgc3RydWN0IHF1ZXVlX3Byb3BlcnRpZXMgcHJvcDsNCiAgICAg
ICAgaW50IHJldHZhbDsNCiAgICAgICAgdW5pb24gUE00X01FU19UWVBFXzNfSEVBREVSIG5vcDsN
Cg0KICAgICAgICBpZiAoV0FSTl9PTih0eXBlICE9IEtGRF9RVUVVRV9UWVBFX0RJUSAmJiB0eXBl
ICE9IEtGRF9RVUVVRV9UWVBFX0hJUSkpDQogICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0K
ICAgICAgICAgICAgIC4uLg0KfQ0KDQpUaGFua3MNCkplc3NlDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IEplc3NlIFpoYW5nIDxKZXNzZS5aaGFuZ0BhbWQuY29tPg0KDQpBY2tlZC1ieTogRmVsaXggS3Vl
aGxpbmcgPGZlbGl4Lmt1ZWhsaW5nQGFtZC5jb20+DQoNCg0KPiAtLS0NCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfa2VybmVsX3F1ZXVlLmMgfCAzIC0tLQ0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX2tlcm5lbF9xdWV1ZS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX2tlcm5lbF9xdWV1ZS5jDQo+IGluZGV4IDMyYzkyNjk4NmRiYi4uMzE0MmIyNTkz
ZTJiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfa2VybmVs
X3F1ZXVlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2tlcm5lbF9x
dWV1ZS5jDQo+IEBAIC02Nyw5ICs2Nyw2IEBAIHN0YXRpYyBib29sIGtxX2luaXRpYWxpemUoc3Ry
dWN0IGtlcm5lbF9xdWV1ZSAqa3EsIHN0cnVjdCBrZmRfbm9kZSAqZGV2LA0KPiAgICAgICBjYXNl
IEtGRF9RVUVVRV9UWVBFX0hJUToNCj4gICAgICAgICAgICAgICBrcS0+bXFkX21nciA9IGRldi0+
ZHFtLT5tcWRfbWdyc1tLRkRfTVFEX1RZUEVfSElRXTsNCj4gICAgICAgICAgICAgICBicmVhazsN
Cj4gLSAgICAgZGVmYXVsdDoNCj4gLSAgICAgICAgICAgICBwcl9lcnIoIkludmFsaWQgcXVldWUg
dHlwZSAlZFxuIiwgdHlwZSk7DQo+IC0gICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAgICAg
ICB9DQo+DQo+ICAgICAgIGlmICgha3EtPm1xZF9tZ3IpDQo=
