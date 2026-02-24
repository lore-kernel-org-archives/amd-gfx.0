Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8767FEFB816
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 08:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28E7610E50D;
	Tue, 24 Feb 2026 08:50:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UXvtZ684";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013036.outbound.protection.outlook.com
 [40.93.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0F2C10E51B
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 08:50:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tE2COI+tsJG1PSgxZydg4Uo8Z/RFFgB/miQQXvx+bSg/BpkuYeK7b3lbnJwiT6Tkm/bDTNTkyITb1gSfhnKX3skDMVVTKtPwmBUj60p1ktK/Gn2gV8TYZp0Id+maTZ3ovtVYFe1JfcZ0Ehc9ff0M0Akl7E2f1Ap+L6SxP/NimwHNOgYCHfd9UMKrI16lllqhxUliAIV8kxJT+L95TZ3tl2DVL99kGwdololYv/odDskUkhtnh9oTBqmcYl4Var6CqiJY6sjqz3Mc5PdP3oPySgSFWbiOL9yiasw5CZN0wQDQjPXKpdh8fMoKkeF9HN3AKwIngXtYeyMVIISaC55PvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pb4fqr4nXldL7SmlFbsLUG/sYs/LTRLgOLXWG3wNaj8=;
 b=X3uSYWPGho/JxxuUPeSWysJniYSU9UAX8WZw5EgCGr/aLra+u/sssY8GgbA2m6J0PidozeYj/taF0QPGpf3ksyd0SN4naM/cMRGppK3OIkXIZWiDT69GM5veamJvvHlxZxXXqlAigl1TknX9uMWrJ0u++8Nn+EJvcfWdX7BNIy7rEwqXkXfxsfiWrx+W2ff5cgY1ZiHwpLRvCOVM5fvtlb2tGuwZvrJXwASfNwjKaTAWAGOJ73FJgvCjOr6HykJ0ufUtD9tiUjRR1oG44GWwsCfdkDyowpJ5CUE4OUzf+Wfu+gpavESMJRjNWtErpPctt2A/01B7RkpmBaNK6+KZUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pb4fqr4nXldL7SmlFbsLUG/sYs/LTRLgOLXWG3wNaj8=;
 b=UXvtZ684A02RTtxYG261jKvj3g127eCed6wyuEF6eVbSFTRCDtM5sIRrb1DTvfGAVckjAH/L1Q0nHJ58O2iCYFKoybesWqmYuC6bhzYibG/Xa5bqHOEGkuQe4hOcdWNNHf/JzWxn14h8zwCHcSE6iU/f7ad5+Zus0MvrUqKy9KM=
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6)
 by PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 08:50:25 +0000
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::9e49:aeba:9265:f46e]) by SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::9e49:aeba:9265:f46e%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 08:50:25 +0000
From: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix error handling in slot reset
Thread-Topic: [PATCH] drm/amdgpu: Fix error handling in slot reset
Thread-Index: AQHcpUt2sPHmRqkIL0GDaaRG+ns6sLWRikJz
Date: Tue, 24 Feb 2026 08:50:25 +0000
Message-ID: <SJ0PR12MB6967634211A3CCF1579F30B69D74A@SJ0PR12MB6967.namprd12.prod.outlook.com>
References: <20260224050657.1775564-1-lijo.lazar@amd.com>
In-Reply-To: <20260224050657.1775564-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-24T08:50:24.706Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6967:EE_|PH7PR12MB6538:EE_
x-ms-office365-filtering-correlation-id: f9149578-ce58-4fae-9ef1-08de7381c097
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?1HkAv6ksGal28wP9BQXh326X3InuBdzKaFxZ7ex5ruaj/KAg1je/vpj0LAes?=
 =?us-ascii?Q?cI97O6dDFb+SmqnHwUF1EH+Xd1s2TwRUJmgXxGInZ6ctkZOAyJXSw9R1XbCZ?=
 =?us-ascii?Q?0mrepLQfkSUD4yB7XxkQjt2PUjCw0BCmkcM9H1cn8bVP2KiSnI4nHp0x+Gd+?=
 =?us-ascii?Q?5kqDtTqrKCIFPQbUw9o54pMCnO1N5pQzBnItrumbQ9Xct0b28qrBJ+KL2Hnx?=
 =?us-ascii?Q?CCgzXJSWp72odMxFlmQ+x49UV1pSY9DHiH3oPMktB6J7ufg2O5vBWkG5+rGk?=
 =?us-ascii?Q?RgURepQGFd3U5zQMD2F3jKxKNK6yUohyyl7Izxd0I6JYo9j/AI+bJJrn7Ni5?=
 =?us-ascii?Q?xHxrHFJTji/mHQxdZwnaeNIoB/R86aPD/Wj8tzeJ9UvSbFf7lJCLbtFEQ90P?=
 =?us-ascii?Q?e0Am1g4YR97vFKK8CVpHmHY1rKn25Uae+ReAzaC2o9TnV0eEf/iFNOz6gUt1?=
 =?us-ascii?Q?0k9ROK58HFm/PjZ5RPCNIr5GVlYXdmgXclK6dqaRJi1gC9nVKTsrg50zbvk5?=
 =?us-ascii?Q?9XiIK7telRoPW91Gh/Tu+tVsWeOOeTqXNFQ4+xFu2QplNUKwN7S3Dk44wo6d?=
 =?us-ascii?Q?32snACawOhtJo9LRIPVMkmK550vtsoldFjhiqu/r/UK+l4xJZ/GmUO6X5FmQ?=
 =?us-ascii?Q?zPzpbKW0c7kG4yJxQs8YyJw4YxmhU7TfV7PFkNicf7G5lrxWIgRfsxQaPaM2?=
 =?us-ascii?Q?oJh+eoAc4X1OcGvHlm9S3+0KswI4vl+bljlAGs5iVq8cz8q2gmnkiYFiVftw?=
 =?us-ascii?Q?HJz5yEFi+vOEP6+XkpPMjyo9DarEeaUTZk80YzGtH8djJqbxbo87R3iMS68w?=
 =?us-ascii?Q?wZe9YCKwH3PIIiYer1VEqM8iMj/K1v2N8yRLAqOyekHlNscJdZHEaPedisA6?=
 =?us-ascii?Q?k7Ksg9sv9Zuq2mYonbpWag+pz28m0EJdFyXSYhXYNPlDXjAwJT0/owAm1o//?=
 =?us-ascii?Q?21a5cZCiDLsOKfMsLwxESF0Ix5OZsC/NUCA8jS2EA/UXEjutjDkoPfJHPiK7?=
 =?us-ascii?Q?XAtUuNXYKvsBaHJUcEbmAdXeC8qAS1NaueAt6PmSnHVyeAVY3YxtS0LM2otM?=
 =?us-ascii?Q?ZYK0pN7r5OaxP6DhFbApwwTqY0pbsEcH+nQT0b1kUjeL7x92atK8lR8a7KRL?=
 =?us-ascii?Q?S54XrBCyse6OTnjTEDvgG1eMe68AOcB5ULlnTLyxxWF+te+tPywn46IbXeFx?=
 =?us-ascii?Q?PVxtl2gfnmkuldq06x75qqXE0d2qtGZP9SKaCtp6d7yd5g2Md31SroNfwTnz?=
 =?us-ascii?Q?nQhdpN6uDfvXgQnEDdChKpQchVIODQxPc3UlkWbIMt5thw+Zz7MC0wefxGVG?=
 =?us-ascii?Q?w/p+9zd+gIlrgl+8ve6ox5ODEuXmAuxUDCzH7RCHP5yBgsrmZO8mfAegWjUB?=
 =?us-ascii?Q?oFHliMA1YBbEgHQgLw1dnaWbLqfi8+lFgewABRASlLrGRUR6svrh/WTFtvpT?=
 =?us-ascii?Q?nOQ32W16BSylEmnIWJv0wJDQOgY0bJoPC2qMhD0sKE5EoJ9DBC5IKKi0+lzv?=
 =?us-ascii?Q?4jCYV2JANC3D9n342yJGvrHcoetjgmTFwaWk4Kfx42SkSZF0xvow83h7rVe1?=
 =?us-ascii?Q?2ej67yPHK7hlPs9OxMpWFq4vkdXADZLYOO8rZX5XcEZR3KgyFmenJcRgCdgD?=
 =?us-ascii?Q?bPMWYuNWB11QwGR5GQ4IJ0s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6967.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wf5bqcHryrG+4Se35yz5+kkINsTWADJwgCSKsICATZdgME5ly7aT3ClwiggV?=
 =?us-ascii?Q?mqkvsSxi8o0MCr6+/Gu0Lu9fhSbOOa8sHqG5cWuNKkN34QSyRToRZ3liSK0+?=
 =?us-ascii?Q?sT28VJKbUpqpxgjwpiJr5qO6dMhpPHuwpeqPIONHXWzR6x9am31/yiFgQ35a?=
 =?us-ascii?Q?TjwI5rjTizVlgZMj0x6ZQFTe2BYI0sTXIz6f5JTpOJTzAnFXoQCX246LIJC9?=
 =?us-ascii?Q?TxKHaV6B/cI7+F532slz7/GL5UWe7qKXVUC5elXsA50mlZPcd1uHlYC8RUIv?=
 =?us-ascii?Q?Ih1mVzpnrBnKRGvZ6h/R9QKjXDMnpsic+3Qz8Is7OzGf+XQaIP2pruN4xH2R?=
 =?us-ascii?Q?rQO9KasGYrfPGZSCgczETvTT+/xMvUyGqUCOWBL8xOryjHHGYo3WTxgOCrnm?=
 =?us-ascii?Q?K8XInfd9G5XlqVviGM8K9uK0SQJcpv+VLlLLn7P1+yQHwxtv+bTzHRiQvwQ0?=
 =?us-ascii?Q?gLUtF2+BF4KDkz8PZnEm9SoaJaDyST5A87sLXGuHHM4h4XmwnyPqOcAEF2uz?=
 =?us-ascii?Q?yc0u1Yh4T0E0fePrm8DWuWonvaRLtuCAgf0rjmn+6R8jNEeH27HnqguIHbRX?=
 =?us-ascii?Q?+bYNFOo4Bq5HYdlJCVZPqoOa6IrYxbyY5OIMUu9uGlTrzOWYCrA6oB3VIMmU?=
 =?us-ascii?Q?mO15udWb3Hh3oZnL9GT5hLd5Rez5tE41nY2ZtzjMebuI4SLramJgvsr6GMgq?=
 =?us-ascii?Q?33zMoRlAOkeOSlrLLZeeRkXSo9FuAeRAo6Dt3ITAJsE+/XJOMrmuoKZ1HXjb?=
 =?us-ascii?Q?8J7YnaMlA2CS3bT6ev1lBrOBZg4OrWEfYddDYj6XlAVS8Re1Iz0/Gqz/6xGD?=
 =?us-ascii?Q?Rc/l88dR4cifSurFdz7jFXGqnqdfkBio7non+UoyYHte69PRDxV9qsDEyL7D?=
 =?us-ascii?Q?15ZInFd1YQrRpC6oIQt+3ak7bJYDMTPySZF3itmm35sjoPhyeIm47MK7wkOq?=
 =?us-ascii?Q?pz/MEpPoO4OqaAuMhYXEDCo4Lzo4BzXFObkKgrYGrVOX3Y6Kp+eLzxOK50PM?=
 =?us-ascii?Q?VwxHdQvNDlLoimOc1kv/6hCIznjX5IgRy1cQEq/MDNor4PMxF6Y5mGSgIRw7?=
 =?us-ascii?Q?m1BZ8oa2QKnIqe24fXlM7JCYq6OONmMjNOD0mDzAU05ueutWGdmLqKwBQA6E?=
 =?us-ascii?Q?jH7oM2OdPYco8MoCPw/+HhNX61DUQ1YVzfa4Br/t0pd8VItT6+9pL3KHTOSI?=
 =?us-ascii?Q?NK1EkghYcYLs9Dflj3zVmCIZSpUHPPBVSPYG9czx2vsT0zy0gEymGklg6Imp?=
 =?us-ascii?Q?hsDTTbJhMI7Wnk6S3zT9oVOiDgQy5kK7vLX5EysGmuESZ1dBW0lt9lt9hooZ?=
 =?us-ascii?Q?6SEB6MS2Elec2TX3vPqL8UGZbZBzorFFjYcbqTFjnQNLRiFpJv4X3tg8pcvz?=
 =?us-ascii?Q?/0FF4DA4sGalRkZkbXRpyTBOOSPXU29daa/MtxtGGtSoDmdISJlxYkZFWFWR?=
 =?us-ascii?Q?Y8cs2SzDBEGbescpFXUXGZBf7kN6etdamV9wL6Ht0Bq4guePbGbCyQcNMnZY?=
 =?us-ascii?Q?omiZ+iK1axDcUNHUOf8P/uaj5f9F0SKy6GyVqdDlmSCH286Tk+i3YZ/4+KAT?=
 =?us-ascii?Q?thcnJ83Duk2F9Xw8afA4cps7OXDNpdAYGWqWQjNMCqDUv+43gS3zm3AOUkcz?=
 =?us-ascii?Q?wpb7XAGkXe8ZqbfCWnisTNwg9yvuka8Wh/MwjRRgnaYbkWJpRjbjMGuj9Czy?=
 =?us-ascii?Q?wvAKX5E4dD6AbElDe7xraXo96CpmY2B0nici1PWph2znxkNT?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB6967634211A3CCF1579F30B69D74ASJ0PR12MB6967namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6967.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9149578-ce58-4fae-9ef1-08de7381c097
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 08:50:25.2095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t45h9mIIOihUUV5GHsDFaNo6LvVvGG4td+IupCX8SZhIBIo6lcAmlYksU/uVmr3jemdxe206ddi0l3ZVMjW4+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6538
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

--_000_SJ0PR12MB6967634211A3CCF1579F30B69D74ASJ0PR12MB6967namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi,
The change looks good to me.
Reviewed-by: Ce Sun <cesun102@amd.com>
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, February 24, 2026 1:06 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH] drm/amdgpu: Fix error handling in slot reset

If the device has not recovered after slot reset is called, it goes to
out label for error handling. There it could make decision based on
uninitialized hive pointer and could result in accessing an uninitialized
list.

Initialize the list and hive properly so that it handles the error
situation and also releases the reset domain lock which is acquired
during error_detected callback.

Fixes: 732c6cefc1ec ("drm/amdgpu: Replace tmp_adev with hive in amdgpu_pci_=
slot_reset")

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 3020cd2493f7..05362f262726 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -7045,6 +7045,15 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_de=
v *pdev)
         dev_info(adev->dev, "PCI error: slot reset callback!!\n");

         memset(&reset_context, 0, sizeof(reset_context));
+       INIT_LIST_HEAD(&device_list);
+       hive =3D amdgpu_get_xgmi_hive(adev);
+       if (hive) {
+               mutex_lock(&hive->hive_lock);
+               list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.=
head)
+                       list_add_tail(&tmp_adev->reset_list, &device_list);
+       } else {
+               list_add_tail(&adev->reset_list, &device_list);
+       }

         if (adev->pcie_reset_ctx.swus)
                 link_dev =3D adev->pcie_reset_ctx.swus;
@@ -7085,19 +7094,13 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_d=
ev *pdev)
         reset_context.reset_req_dev =3D adev;
         set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
         set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
-       INIT_LIST_HEAD(&device_list);

-       hive =3D amdgpu_get_xgmi_hive(adev);
         if (hive) {
-               mutex_lock(&hive->hive_lock);
                 reset_context.hive =3D hive;
-               list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.=
head) {
+               list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.=
head)
                         tmp_adev->pcie_reset_ctx.in_link_reset =3D true;
-                       list_add_tail(&tmp_adev->reset_list, &device_list);
-               }
         } else {
                 set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
-               list_add_tail(&adev->reset_list, &device_list);
         }

         r =3D amdgpu_device_asic_reset(adev, &device_list, &reset_context)=
;
--
2.49.0


--_000_SJ0PR12MB6967634211A3CCF1579F30B69D74ASJ0PR12MB6967namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span class=3D"elementToProof">The change&nbsp;looks&nbsp;good&nbsp;to me.<=
/span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span class=3D"elementToProof">Reviewed-by: Ce Sun &lt;cesun102@amd.com&gt;=
</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Tuesday, February 24, 2026 1:06 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt=
;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix error handling in slot reset</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">If the device has not recovered after slot reset i=
s called, it goes to<br>
out label for error handling. There it could make decision based on<br>
uninitialized hive pointer and could result in accessing an uninitialized<b=
r>
list.<br>
<br>
Initialize the list and hive properly so that it handles the error<br>
situation and also releases the reset domain lock which is acquired<br>
during error_detected callback.<br>
<br>
Fixes: 732c6cefc1ec (&quot;drm/amdgpu: Replace tmp_adev with hive in amdgpu=
_pci_slot_reset&quot;)<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 ++++++++++-------<br>
&nbsp;1 file changed, 10 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 3020cd2493f7..05362f262726 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -7045,6 +7045,15 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_de=
v *pdev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &qu=
ot;PCI error: slot reset callback!!\n&quot;);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;reset_context,=
 0, sizeof(reset_context));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;device_list);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hive =3D amdgpu_get_xgmi_hive(adev);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hive) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mutex_lock(&amp;hive-&gt;hive_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_for_each_entry(tmp_adev, &amp;hive-&gt;device_list, gmc.xgm=
i.head)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add_tail(&a=
mp;tmp_adev-&gt;reset_list, &amp;device_list);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_add_tail(&amp;adev-&gt;reset_list, &amp;device_list);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pcie_reset_ct=
x.swus)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; link_dev =3D adev-&gt;pcie_reset_ctx.swus;<br>
@@ -7085,19 +7094,13 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_d=
ev *pdev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_context.reset_req_de=
v =3D adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_bit(AMDGPU_NEED_FULL_R=
ESET, &amp;reset_context.flags);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_bit(AMDGPU_SKIP_COREDU=
MP, &amp;reset_context.flags);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;device_list);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hive =3D amdgpu_get_xgmi_hive(adev);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hive) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mutex_lock(&amp;hive-&gt;hive_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; reset_context.hive =3D hive;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_for_each_entry(tmp_adev, &amp;hive-&gt;device_list, gmc.xgm=
i.head) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_for_each_entry(tmp_adev, &amp;hive-&gt;device_list, gmc.xgm=
i.head)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_a=
dev-&gt;pcie_reset_ctx.in_link_reset =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add_tail(&a=
mp;tmp_adev-&gt;reset_list, &amp;device_list);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; set_bit(AMDGPU_SKIP_HW_RESET, &amp;reset_context.flag=
s);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_add_tail(&amp;adev-&gt;reset_list, &amp;device_list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_asic_r=
eset(adev, &amp;device_list, &amp;reset_context);<br>
-- <br>
2.49.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ0PR12MB6967634211A3CCF1579F30B69D74ASJ0PR12MB6967namp_--
