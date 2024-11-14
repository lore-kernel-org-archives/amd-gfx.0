Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A3BD65C42
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2024 06:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9743610E12E;
	Thu, 14 Nov 2024 06:33:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WyHj2cxA";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E27B110E12E
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2024 06:33:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4jTfC+zWUdi1i2CR130E2GUfrafFP1PnltXGTrVdrr1lfo4AnTCUQ2QCIq0WpHm9sFsuVRDeMO5Vl/J4TgPagAwY3rqMlc2+u08nhVXiPC1Fx7OIqhUZSmafEDplrm3iT9DjES9Je+2ySPlqLhq/5IusbreGTy1xstPZEEpY/Xay9DTBLOJxDdd51nXTJelTlITzsq5nNg9l9tABzIRiC1HoNuhyovVUpWU2cQwWaSKIuz2SJDh1kvERHubsGh12L1QPhmqPpvwccKhJkc3077cGmDHk1hNK0/ua4SM04TTc9DaZFMO7d/TV3bdJW9tR5oXJe5r6G7Pw4t4pgCAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZnZ3Z2YOjg7LhL7aX7YA7pCjeL9i3aD/1vm/hA1cVg=;
 b=QnQbCmeHbtQ2sBd7tvszx+5NBORzeByy+vs7kMj+Kc5MPlt0Ik+3U7lBGcRjCjyVsPwZ61bxKmecXUC8rwd+oFzHr1jU6/rPMWCY80hl4bbZRk0NRVj1sCfwB2T9ShBOj56UbMzXTG5B2JdVMA8znmEEA3mRwQm/tXbHhUaxKVe5t2SE8MXAetn9zUBaGXARIHxZOEURGSfbv2j/q0UhEosxWVESqoA5O/sfzUWhGHvAayrf+NkVV1wPbesgZDJjl85ZVbcjgLDZLmkKIoVRMO7re2eoFsD21wKfgQMVAQ/wZnE/A/Vvzh+dP/u3hg/r4O+SKbYovuR6YYrYq3bDnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZnZ3Z2YOjg7LhL7aX7YA7pCjeL9i3aD/1vm/hA1cVg=;
 b=WyHj2cxAxXTbkZrCtI5wxlVXeWRLJjQjUETL7yK0cfDkFNQk+Z8EXpUwE5DUtD1UCGS2Z9IiVTyhic96I/JxRu6urGe7onmpIuZ8iaRKH8Tc1dyj7LzLG1axaihVovZCjO2CbfEyUXqD9EP7xxlPLTS8X8OVeSXLeqoJwyxsbjQ=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by CH3PR12MB8188.namprd12.prod.outlook.com (2603:10b6:610:120::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Thu, 14 Nov
 2024 06:33:05 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%5]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 06:33:05 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Add missing kdoc 'gpu_addr' parameter in
 amdgpu_seq64_alloc()
Thread-Topic: [PATCH] drm/amd/amdgpu: Add missing kdoc 'gpu_addr' parameter in
 amdgpu_seq64_alloc()
Thread-Index: AQHbM+OWS5GjKnNWqkGPVrWvecgO2rK2Vk8A
Date: Thu, 14 Nov 2024 06:33:05 +0000
Message-ID: <IA0PR12MB820816E11FCD0F92AFD8E8BE905B2@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20241111024350.1881077-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241111024350.1881077-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5c166ec2-605d-4168-aa81-0e73534ee870;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-14T06:32:57Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|CH3PR12MB8188:EE_
x-ms-office365-filtering-correlation-id: 49bb84d3-1d5d-4eed-4af8-08dd04763240
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d3I0VmYyQmdIL043cHhOSWsrdXNoSml5K1ZVMm8yK2pCQ0dQVWkrbGRXQ0ZF?=
 =?utf-8?B?bmIwL0pqKyt1MmZNVFFuLzJtTGN1UGM3VUprS1huSW9XSHJKOFVGNGd2Qm9L?=
 =?utf-8?B?ZlBBN2JlWG5FYXBIcWh1K2Nzd2Y2eXkyeCtkWXlpbG1heWZMREFuSkNnUFp6?=
 =?utf-8?B?ZFlmaWdlYXRJdjk2V0RDdENaZU1zbWh2UHRscWJwYk5lc0VXSjRkakZhQjFM?=
 =?utf-8?B?WWVzaHJCdWZjRm90RDBEcFhwck9vd3VxMENVcDZ2RGxVNWQwZ3I0cmRZRm40?=
 =?utf-8?B?SThBWXBaVHRXd21rQTI3YjNKR0FkU2Z3OVpFSlFKS1hheFN5RFFTMHZ3MlUw?=
 =?utf-8?B?a0dRcC9SMnYrYW1vMWlxT1o1YlFRUFN5Vk1scWJUdmpCVlVNTHFZeHZaOTQv?=
 =?utf-8?B?ejhnbkthT2M5eWhvSWYrMWI3TkRTeXlmV0lmOGFaTjJReHZacHZuNExUcGhZ?=
 =?utf-8?B?UElrR2dpMS92WnMxZFdvNGs2dXgrTEZYYlF4bzVTTC8vd2xySU5uWmVheklE?=
 =?utf-8?B?UzUzcVBQNERROE0vSllES2VYQlNtSDVPSDFjdSt5TENwZVN4T0Q0UGtBNnFZ?=
 =?utf-8?B?VWFLRVowV3R4cXYzMmFmMnQ4NFhtbHVQLzVTdjJYS0kvNmk4ak9wTll6VWlj?=
 =?utf-8?B?UDVUQVFwcForQlprWVc5anBjQjEwTCtjSXZXMGNCME93M2dzMEVYRXNkcTN4?=
 =?utf-8?B?WGV6bFZBQ0VVaTlvU2dFbEdmM1M3TmJSM2V4aTNVUFRHSVBPRzhPd2I1blIw?=
 =?utf-8?B?VmRzQlVxZ0wzRll2NG4xczhBZ0JTaWhpRUxwOHU2RHpVZ3RyZm1kTFBGQ3Yz?=
 =?utf-8?B?L1Bva24xbEQwai9qMXBNVGRsMWhGTHBubjlvY2RSTWZRY254Z09may80YUl6?=
 =?utf-8?B?aElCTE1MMFpMQU5VTTlvcHZFQVdSVWpER3g5QXdxY2JsaUNwbXJNK2ExQ1R3?=
 =?utf-8?B?WGRLZDJSWFR6U2d6TXpoVnFNYUk5Q2pqSE4ySTRQSlhjUURQeFNDUDg3SjZB?=
 =?utf-8?B?dWpua0piNnhPN1c2b1dwWnhNWTM3aVFWdktiQjlEWGNobnBzeTA4YzN0eXM4?=
 =?utf-8?B?N09kZTM1V1RvaHNYTXo4WHpxWWR1SkUxQ2JLUzNYUmRCdVE4aEZSclh4N0R2?=
 =?utf-8?B?akxoQXdKUDM0NE5ZNFNQV2RWWU9XNHBlYnZSSFYwYXpxOVV1TUNGallYd3RG?=
 =?utf-8?B?d0ZkdFVNbk43NEg1cS9IZmxadFMzbzVrekdBcWlBN0xVc05oZDB3Vzg5ZXJs?=
 =?utf-8?B?TVRYaG1aeEdmRGtPK1NlRncveTlMdFdOUFF3dGpsc2lNN0pxQVJLMERyVVFz?=
 =?utf-8?B?T0hTRUhscnVJd0lxZ1c1Szg3UFYvK3B5VVlUN28vaFh6RWU1aUpoeFdDdm9Y?=
 =?utf-8?B?S0xXT3lpVnkrc0VOSlVKSllTZjE5RW5JOXl2TGRuMzQ4UjNhZUg4QmUzZTdO?=
 =?utf-8?B?NVorNlFwNmVNeko0d1ovTmVKTmk2dXU5QndFWlRnR0NtZ3lrQTlna1krbURO?=
 =?utf-8?B?QlZiUGNaMFJrd3AwSVpDajhMRXNNVUlEZmlwY3IrS2FQckhhbmRvZGxsL3Rz?=
 =?utf-8?B?b09sWFdBYzlkeW0xbUd6K3hLZGdFUjUxR2JnRklRTnlSL0FYOWtESUY2VlVr?=
 =?utf-8?B?dWcxcGFrUFJmSEFsTEdFKzJCTjlMR0lMNVcxQmg0cXlncTZtSmxoR3h0MGt1?=
 =?utf-8?B?MVFxVEc3RVZ5MW9kUjVxUkhjMmZQWm9naEo3d0llVkx3RGdsNThvaUFYRHRr?=
 =?utf-8?B?c1NkQUhsenk3SFR6OHRoZ3JYRU1aTzhqK2s5UTZWd3ZwQWJCUWMwbDAxU21j?=
 =?utf-8?Q?euWZ7Vq0U8lezqsj4yRbGufHYbrJNNmFsZBnw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlVTOEN2VVEyQjVQWmQ3eEo2eEJiYU4yN082ZzlUVnZwbEJ2ZnFXZ3JhRVVx?=
 =?utf-8?B?bFcrRTFoeXN5Z1FlL3QrY2RBL3RNeXEvVUQ5NHNKbDMyOFgwY0pvTUIvUU1Y?=
 =?utf-8?B?QjdMYmQ1em5mbjcxSXRDSWUzeWI0S1I1YzRtRXZFa3d5YXdvVE1zaXVacGQx?=
 =?utf-8?B?WEhHOVpYbEtVMjErcVlSUStldzhwZmIyR2JJL2VBZXBRa05BWDVGTUQ0YjUw?=
 =?utf-8?B?M1JxaERuS1gyOXRBeFhoU290aUIySi8wWjBqaEY1Qm12UlpKaHFhRkoxSEpi?=
 =?utf-8?B?amtrUFZNbXhJeUh0NitkdGlEZEcyOW94cmJmVFliTllpTjB2Y0QwZTY0ZXFX?=
 =?utf-8?B?L2d0cndGdG9kWkpVYlhmVmY0VmUzRTRLdC9vK0gvekNxT21ORXNxcGs4ZFMx?=
 =?utf-8?B?ZzhRQnVzZDJoaXgrbWNPN2pYaXMya0J1cmYrOFhjaDdEZEVFMytJQW1ZUEFq?=
 =?utf-8?B?NEVOdTJHck1aQWdkR3crSXNQci9VdWluTG1zVDRQeHoxSWh0eTlIQjlkOEl1?=
 =?utf-8?B?SGppMVVUcmd4MGNQek50VWZRVjRxc2FvY2xPSmtYeUp2MERzNXFibkgzdGlo?=
 =?utf-8?B?aVJzdUczVmFEcVlLRXh0bVkzTnoxekMyTG12SXZvbVU4RytkZGJuSWtNRDFC?=
 =?utf-8?B?cS8zbStrR203YmNFR281NCtnbXJqRjEvUU1xeER5eHpaMi81YlNxakJleHp0?=
 =?utf-8?B?Ty9BQjF2ejNKSFhVbWtFQ0wzeE81VGRIcHorN3c2enpRMXFwU0hCQm8xR2xU?=
 =?utf-8?B?c0Y0RHNHcVZNYkVJZWx2bDM4ZzlVWnQyZGl4MGM1d29BSldoQ1VYdTkwOU8r?=
 =?utf-8?B?NzRydmFKR1M3NmNWSSsreE50TmdTMktrYlRuRlp4M1dId1lvVTViN1RKTVB2?=
 =?utf-8?B?OW5qZ0c1QmZPL1V1Rk9PVXZIeTROdE1Vcmx1TFQwQnQzV3JBMHVRVnRIVWxY?=
 =?utf-8?B?RytYN2pjQnBQMWVVM1hUTkxzUkZiR3h0bEZkUktvVmkwTmNZb3FMRkNvUGpv?=
 =?utf-8?B?cy8wOTdVSkVWOTkyQ1M2OEFRUEROSlQzeHBkWS9LWWZXT3hhczZkMFM1KzFG?=
 =?utf-8?B?NnhVQWloNCt2RmxDRGdQOURPUUV5bytvdndxY2JKTUpjUE5PeWlXTWhOYjVx?=
 =?utf-8?B?aU9VR2ZtLzh2TVRLSkp6bDJlU1hqSFVZdXYzVnF5V0VpRFJKM3N3dlV4L1VQ?=
 =?utf-8?B?Qzl6VTZWcXFVdXlvUzVxdEk0WjE5R0c2YkgyUlFDOWMyWXVkeGJUVkliQXht?=
 =?utf-8?B?Vlkxbjk2aFFwMVhVSStkWDRqYWh4M1dRb3p5NTducHhjQ0dNdytjYkZVeDd6?=
 =?utf-8?B?UlFjYVdEb0l3ZngzUFJTaGNCZVBCQkNHVnovVGtWUEZWS1dLc011L04wUmoy?=
 =?utf-8?B?aVV1VUU5K0xIeFpINjlkOE1KNUlhS1hlN2RLUUFzUUkwSVprRlVOdFdJRE8w?=
 =?utf-8?B?cHNRTkFFRk10dnQxWjlUNWt5eE50MDFCV3V2YVVUMVpORVZReWdiVXNtS3U1?=
 =?utf-8?B?MG1sUmpIbU8rcmZpU3pzQjg2cDBHL1c5U2VERCsxZFR5cUljY0ZJVFpWVGpO?=
 =?utf-8?B?YndCM3FLK3Z2QlJiZE5kNk9KRGlrUzYreUI5RXRaK2ttVm1Dbi9WMW5jdXBj?=
 =?utf-8?B?RnRCY0hLNUFqZ0o4Z283clp4b1cyRTZLRzhoTDlna1lzYkM2WWxMQnBPNXB1?=
 =?utf-8?B?S2dOVkZyQmhpZkV1Qm9GYnpDdGtkaXNLNEZvNDFhK0dQckZuclp0aVh1elNK?=
 =?utf-8?B?M2Y2b3BzODF3eHNTLzFTb20zSWNFRG95QWwxbUR0VWQ1NEhwZFhockoxaXVx?=
 =?utf-8?B?a1VobXZpZ1preGtKS2ppNU02MmVDemJVYkVZd1I5SFpxT3c5clg5bFgvTXVu?=
 =?utf-8?B?QkdCTTlpbGYvalhJMldBN1EvWmZNekF1ODQ1UUxmb2wwRFVqQS8wbXlOZWR4?=
 =?utf-8?B?ditwNFJubXNyOHNyVHhvbENMTWh4QXdoSFd5aVVhUklURmpTVW1OamFsQUJ0?=
 =?utf-8?B?MFNMKzVqVFlTZzB0RWdMaFltS1VVdDNrZWRjWmkwOUQ1OHNaK2RIV2toWlc5?=
 =?utf-8?B?UnBPYnNlQVBHRWtGRjk1emNxdnZPOERsS2VXZ2xPclpIUkU1ZklaQ1Y0VXIz?=
 =?utf-8?Q?FCI0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bb84d3-1d5d-4eed-4af8-08dd04763240
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 06:33:05.1934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: imiN/AnfcU6Le9QUKVBlk2quKo5jPfdE2reKj6yACwgt17CeGwk3h3CLIGEaodBAkf0fWPE7RHu+80BVq1UypQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8188
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
Cg0KUGluZyE/DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTSEFOTVVHQU0s
IFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQpTZW50OiBNb25kYXks
IE5vdmVtYmVyIDExLCAyMDI0IDg6MTQgQU0NClRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0
aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBTSEFOTVVHQU0s
IFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFU
Q0hdIGRybS9hbWQvYW1kZ3B1OiBBZGQgbWlzc2luZyBrZG9jICdncHVfYWRkcicgcGFyYW1ldGVy
IGluIGFtZGdwdV9zZXE2NF9hbGxvYygpDQoNCkZpeGVzIHRoZSBiZWxvdyB3aXRoIGdjYyBXPTE6
DQpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc2VxNjQuYzoxNjg6IHdhcm5pbmc6
IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBzdHJ1Y3QgbWVtYmVyICdncHVfYWRkcicgbm90IGRlc2Ny
aWJlZCBpbiAnYW1kZ3B1X3NlcTY0X2FsbG9jJw0KDQpDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4NClNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzYW4gU2hhbm11Z2FtIDxzcmluaXZh
c2FuLnNoYW5tdWdhbUBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3NlcTY0LmMgfCAzICsrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9zZXE2NC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3NlcTY0
LmMNCmluZGV4IDBkZWZhZDcxMDQ0Yy4uNDFhYjJlMmNjZWY0IDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3NlcTY0LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9zZXE2NC5jDQpAQCAtMTU2LDcgKzE1Niw4IEBAIHZvaWQgYW1k
Z3B1X3NlcTY0X3VubWFwKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1
X2Zwcml2ICpmcHJpdikNCiAgKg0KICAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXINCiAg
KiBAdmE6IFZBIHRvIGFjY2VzcyB0aGUgc2VxIGluIHByb2Nlc3MgYWRkcmVzcyBzcGFjZQ0KLSAq
IEBjcHVfYWRkcjogQ1BVIGFkZHJlc3MgdG8gYWNjZXNzIHRoZSBzZXENCisgKiBAY3B1X2FkZHI6
IENQVSBhZGRyZXNzIHRvIGFjY2VzcyB0aGUgc2VxIG5vLg0KKyAqIEBncHVfYWRkcjogR1BVIGFk
ZHJlc3MgdG8gYWNjZXNzIHRoZSBzZXEgbm8uDQogICoNCiAgKiBBbGxvYyBhIDY0IGJpdCBtZW1v
cnkgZnJvbSBzZXE2NCBwb29sLg0KICAqDQotLQ0KMi4zNC4xDQoNCg==
