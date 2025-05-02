Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048F6C3ABAA
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 12:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A25110E8DE;
	Fri,  2 May 2025 12:26:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qw/DFLAJ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3250F10E8CA
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 12:26:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkq24oQZZ6dgkcSKY8gCXSIo+hWlrUcGbz57Bltdop5itwdSQjBq+zL2b1lVFf+huqCOhCBetn37QiBJi0NvwfbgngGrNpK80NNlodDYICHVzk7JeGmVFxvia9en06WQPVB1gmdmCYmhO3WzFuB79HrxxpOYduBYLibWfiZuanN8xFsyMly61OidFwoofDtrjznGmqs1x3b0uRaSWvKln51acB1lYEyNLk3xhjoUakLuMrENRG1UnEJqbaQaG4WW895crUXVdi1NOTXUcmD8h5VVCY0lm8cHjeqFI+q78REex1z9q/mGjsQcK8xOOeT0zzXDAHnNomLaQwXU306XyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4RgcJyC4Of21vo3tN3oyTKQB7FWXW+D0ZUGDFkBbgE=;
 b=NBPSErLEnlZ0udjklDZ7BRosk3mdmgYMv8HiRr5tp8EaH7Qx97OoT/qOecsmy6747TroneDRWauv7jL+1pN5LiZWB1SdwjofVjz7K/Fm6wCavkDG2Ao1WuHof6TxbKY5mTLdvDZb0XlwGkgyV6J7kqRl+VTvZUNcj9nzdYI0qHT0fEVJnL2/RHs/QnLlFBPo15TxrV/NToNF/DdgZ5/vUPvTaZPF18MNqfrTQ8xLzzsrHK0nOAGTr+rhpFzy9W2MJR0XXtYuLMm6w0ypR91QsWIdInf2lv9Pw0bEDnimXDrLDM+eRa8X9hkltx970OpB+TcCmQ45rJKBsEmfXzA9lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4RgcJyC4Of21vo3tN3oyTKQB7FWXW+D0ZUGDFkBbgE=;
 b=Qw/DFLAJ2Tq3qFGl+4bFD12gDxk++i1zxP72QgePTyBBpsiZLPlRHOApUey5+ZrWROn3PWLiZjOWYzMPfiaXpNGoTkJIW9SbH9Y1UThMzDzorLzOYNIXGMl5z5v2LprIWcW/WR+zfEj3hf9UimupGWeJ8zdc/GfrP2VmzioD5kY=
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CY8PR12MB7268.namprd12.prod.outlook.com (2603:10b6:930:54::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 12:26:44 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 12:26:44 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Yadav, Arvind"
 <Arvind.Yadav@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v4 2/2] drm/amdgpu: only keep most recent fence for each
 context
Thread-Topic: [PATCH v4 2/2] drm/amdgpu: only keep most recent fence for each
 context
Thread-Index: AQHbuem9qnPl6/2KwkqvINUaLeG2zrO+/hsAgABI03A=
Date: Fri, 2 May 2025 12:26:44 +0000
Message-ID: <BL1PR12MB57538B05B8B8095B241E1AD8938D2@BL1PR12MB5753.namprd12.prod.outlook.com>
References: <20250430160521.35670-1-Arvind.Yadav@amd.com>
 <20250430160521.35670-2-Arvind.Yadav@amd.com>
 <d3d4aa68-109a-476e-b0aa-c7fc28b25bd3@amd.com>
In-Reply-To: <d3d4aa68-109a-476e-b0aa-c7fc28b25bd3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=356dcbc5-006c-487a-931b-796a90611393;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-02T12:26:07Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5753:EE_|CY8PR12MB7268:EE_
x-ms-office365-filtering-correlation-id: 3fc54aaf-2770-4d30-be77-08dd8974999a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?QStXWWRtRjFZNWRuSGRHbCs5QTV6cXp2bGY1MWFkZEYrdEk1a2p4OEo4ZnhI?=
 =?utf-8?B?S1praWs3R2N6TkNGZHFxTy8yejNDM01HWDZyTHduc2V6azFTV3lZcVc3WDFD?=
 =?utf-8?B?ZTdpMWdrbFgwK0VZbCtheXgwMzJzNWJDNUk1RGlYM3ZKdk1QZUVpaUtyQkZZ?=
 =?utf-8?B?bTZRUHprS0xQc3IvOXN6QnVkWStiQTA0cEVDRDF1WlY1OGMweXdDVS83MEJ2?=
 =?utf-8?B?WS8vUUpVd2Y0enlTZktHU2xLOVZBclhCWVc3eHdOYXp6a0Vyc1BsL1p5UXlR?=
 =?utf-8?B?T1Jwa3RjOTE0YXJBOWtOd3lmM0M1NU5WY1VuRzNFYU1ZSURySXNvTnFFY3kz?=
 =?utf-8?B?YmhISVoxTk1ZQ00wejdQaGhNcTM4cDNUZ1ptVWUxM2xnYUhHWGV4Tkh6UWN6?=
 =?utf-8?B?bit6bllmVkdHZlorZFVRdEQwcVZQUGdwR21ySndmem1WcGVSV1cyTHgrT0d2?=
 =?utf-8?B?YUJNM2thcUFzOW5QQi9VV25DRXN2WmEzZkhzTnRsMFkvakQ0L2EyTlVTanV6?=
 =?utf-8?B?TWJNZXhUZFlZU3puUCtrdGF1UWNXdTNPNDRYL3J0azE3QVBzUldKdCt6YUhj?=
 =?utf-8?B?RHA4cld5eDlDWXQrQ2RtRU5sWDBOeVgrak44cVhsNGlDU2tZaUo0MmNSanI2?=
 =?utf-8?B?LzVJWE5ESTNiYm03TkI3eU5QalFXYWhxNTJFNlRaWmFGSXQ1alZIRUlHVm5G?=
 =?utf-8?B?eUp4QXVrTDdYK2dhbDhSbm0wOUFZbUpBMXc0bC9vMzNCRk1WWkF6dXRXMnpP?=
 =?utf-8?B?ZXIzNHgyWHk1blhNL2Y1bFVFNGdILzJyZzJWTXV3VG5mQXF3ZldRb0hySExW?=
 =?utf-8?B?YSttTlp4Y2lYLytFaDBSOUx0VGM0dzBtSkVjU3BwYWRaaDRORzdUVnVLZ294?=
 =?utf-8?B?dXFza0paalhVeURJQm10OExLOUVTa1VWQ1RJTllYd1AxMXNUUjB5alQxT2ZL?=
 =?utf-8?B?b2lvR1BOalIwVUhrSVJtamJ2MWgwcnJMT2U0M2hIWTdDKzEzV1U4ek1GZmNU?=
 =?utf-8?B?cnJmVkJJOHFuQnQ3Z0pjVmRMdEhqZnVZWGtIS3g1dVlCN3JlQTJ1TFBrODJZ?=
 =?utf-8?B?NktGUE0ydVpHUDNycUxLY05XVUFaVWJ5UzRzQVh1bWtyNU9rVmw0L3E1aHNE?=
 =?utf-8?B?YXJkMXE4bThObkw0anM0OHFJT1NZYzNPNDVjL09DcHRISXJZcXRrczN2cWdu?=
 =?utf-8?B?MkMvNUVOY3Vyd2pScG1kWGJBbURyMVp2amk2NGh5bnVaY2U0MmRyb0VkL0tw?=
 =?utf-8?B?SWY4RjhONVRqT0NyVTdFK2dqdFhaaUl2QXBvQ0FCQjRHVXBjRUlrSHF2Wi82?=
 =?utf-8?B?L3VQTGFjT0JHNlg0VitZdkk3UWJwNmh5cUFEUUFWdWp4NGFVeUVUMExBdzFn?=
 =?utf-8?B?SkR6UW5pVmR6VHJ4K2hnNkl5L0lmNmtmYU5Ob0N6VFNHYmxNenR2TCtyTU1O?=
 =?utf-8?B?L2dLY2prWnFGMDNLd05Yay9ibFRveFgxTFNVUXZIRDdvSXkvM1pwL3lZbDJ4?=
 =?utf-8?B?VTgzYm5wS0FBN2ltbmhIUG1pTWt2Z2hFTUZUZThKWWdKQnhqS2tzYlhoZ2wx?=
 =?utf-8?B?Q0hDNVljWlgvaS9uU0ZIVk5pczNST2tDd0xPbGx1V1RBM3pTYzI3Ny9kMEcz?=
 =?utf-8?B?ckFHZTBxVHZUWVhabXdxN0dXUHB1SStqSjU3T21VRU8xeSt4akwxUWZ1eEY1?=
 =?utf-8?B?OXdxR3BvMmY1b1hTOFlWaGNieGMrazBmN2ZROVZOWmVKZWh3aWRXY2NUSUNY?=
 =?utf-8?B?R2ZLRW1TZ01jdklrRVpPT0NyTUpCZ0J6ejNUV2hrSnh3d1AvRnBEcmdiWTlj?=
 =?utf-8?B?TGRiVjllanZqSHFZZDAzbUdYVjdjYlZ3UENnWXI4NE5KempLa29zd25tNGUz?=
 =?utf-8?B?OVFrbU1EakVXTjJ1K3ZoNmJLandkaVUyV0lxQWozSFJtWGh4dit5ZXh1a1BM?=
 =?utf-8?B?em52emFIcUxHb0k2bEVJWTVBaEVzTG03R3Q2VnV2VHJUS0ovMURNVFp6K2E5?=
 =?utf-8?Q?OZ58v++oLGngYNm6CBCyWBPp2IYayg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1dZcmM2QUVNbG5qVnhkU3lQV1VkZGhaMmNXRHZLOVhnSG9neTQrU2NTNTF6?=
 =?utf-8?B?SUY0aEx5a0xpTEUyMVV1Ty9BMlVWUzNjQUE5aWRUaTdBMlkwSEh0MlQ1NTdC?=
 =?utf-8?B?SzJHT1RBRzRPZU4ydjMvVEF1RWlkcHl2SWhZNkpTVjQyL0o3ZFdBbUl4WlZO?=
 =?utf-8?B?ZDRkYjc2aVQvL2RDaDFKeENZTmUyNlNIWmZKVlJpd3g3cExBM1BUZXBjTWxH?=
 =?utf-8?B?ak9VSmRFYTRvcThuQnRQTHNDY0tYbkRaTkNQUWdFdFZWYnlRbG9rTFd1bk9y?=
 =?utf-8?B?UUE0enVyaE15ZEhiRUE2eXRSMFRIQ1cwQmVnemxYUEsxd2hBa1FOTHljSGYx?=
 =?utf-8?B?NTV3K210Smh4Qi8yT3BGSDBpZzZtenc2NVA3MDQ0TWdlOHpVb0VESWJubUFQ?=
 =?utf-8?B?YnFVWlN2UE9OTjRyRnlxOFFqby9wUXk1OXRDOHJmR1FpWXk0Z1l1dzhGdjVq?=
 =?utf-8?B?aDgvT0ZMbGdvNVRicFc4UzBEZnFnM0JJd3kzZ2p2V0ppNHJ0UW82dUVsT0NY?=
 =?utf-8?B?RzFMcU85S2tXc1BaazNHcTR1V1kxc3QrRDlPUWFwZmVhMkx4RTZzQUYzTHZI?=
 =?utf-8?B?WVllRjRmNVNrK0tINHYwdTFqQm5OZlFWeEcxSG9EVGEwZ1dPNWxwZGNGdmoy?=
 =?utf-8?B?bDhKMDRhbDlpcnNybHNQVXRtZ242em5BajRLVjBXL2U5eHZBU2lUdXRVOW1j?=
 =?utf-8?B?TkUzWFRCYUJxS3pVUnRtbjJxeU9wSW83bmZMeDQxMmZkVFd4YVZFVnE3ekZk?=
 =?utf-8?B?bGtudExaWHRnQitQVWFHc3ZlTDhxNE5JUktHWEtwUXFCR3RJZ09WMUphVlQ2?=
 =?utf-8?B?eXdZbUhMR1ZhenRKT2VTTGg3Mkg1WkxCNkpUU1BjTG9MMWJCSWQxQVUxYUFP?=
 =?utf-8?B?ajZUeDd3Qms0RDZjcWhzN3VDNzVLb000WjVmaUpLcllUbko3NTlTSWJCWjZ3?=
 =?utf-8?B?RmVDaCt3UHl5R1lXU2duQnowKzJxdGRlWjIyaTVkcEZNZWw1T2p4azFtY29o?=
 =?utf-8?B?VXZPcUc3TU9GTWNsYjU2aGlzTFVnNU1QY3dkdHlDR094RTQ4NndTVFFrV2tn?=
 =?utf-8?B?UjduNU9sU2ZyekpaQTNUK3pxaWZQeXloNWJzcElnU0ppQ0JKYUdvdk5hVEJU?=
 =?utf-8?B?ZGtUeEJpUENQQnRaTi9aOUpXU0FCZlJGaTl5Mmc1b2xBbkxJaml1cXY4OU1Z?=
 =?utf-8?B?UHRUWE5XaTJVRyt2ZS9yYVpBNTJaMEI1MmMwYzdwVVVaYUlCRHhtU0RKL2Q2?=
 =?utf-8?B?NXZoWU9GM3JTUlh1ejU5UGlGazZWYUZNU1o0Z0NBS1hhRERPQXpma04zYWc5?=
 =?utf-8?B?aHQxUEZyWFRkYzU2c004dU1QRHM1bHVvai9ENWFTbVVJaDBkV3BkeFNWTDRw?=
 =?utf-8?B?ZzlqVU1Va09EYXBTY0Q2bXlSNnhRWXA0Z3ZKRW5KQVE1eGFGMUQ1YjNWbHdY?=
 =?utf-8?B?WWZLandIazEzV3NuS3VvTFJYQU9kNk92MWpsamtwS2tMeFY3WUZ6UlVHOXIr?=
 =?utf-8?B?UHM3NjZYWHFjRUtpdzArbjZsK2pxczlnaXQvbXJIekxISEY3RlE5YmYvMnZa?=
 =?utf-8?B?amtTc3QxYk05N3ZnVUp5Qy9HaGxRM1ZkMk1CMW1pOGZpVEsyR1Z3RmFZd0pr?=
 =?utf-8?B?TXhlWlJNTU4xNWZWV1A4MTZBQlRENnZ5Q1JLdWZaQ21wSnlTM1NxZEJGM2RC?=
 =?utf-8?B?ck52UUtTWGtBU3FvYk1sTStzUlQ3VmtCVytKODltWGlIaFM1M2lSNkJndi9y?=
 =?utf-8?B?TTZtemlPVzFJc1ZaenhoUGhsaVRlWkgwVXdyY3JPeEtadWp5eEQzdVhDWG1J?=
 =?utf-8?B?ZTV5bUVpc3o1M1lLK3g3YTBlZGQ3QklzUm5JdURmMXc2YUxkWnZndHoyNC9S?=
 =?utf-8?B?TGFFK291dXN6MGRGS2pRUzZHcm5vKzJweDFmV0VCeE1QSGU1NlVQYjV0VmlD?=
 =?utf-8?B?ZUxQVWtLWTJzYWl4bUFIZVB6OWJNVDlHeHF4MFJoV2wzaXpqVnAyUExOUmFS?=
 =?utf-8?B?b2VlcXpBL2xrMGxZSjJOWktFNVN6U25BY3dxV0QrTk9MWWIxNzYrWk9VV0VP?=
 =?utf-8?B?c0p6VjgrYUJ6RzFHSEIzcm9uMjBRK3R5UVRZeExBb2YxRW11d3BzSVFIWG1X?=
 =?utf-8?Q?bhxg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc54aaf-2770-4d30-be77-08dd8974999a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 12:26:44.2497 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1MCKzYZY3feoT0P27bDZLccA2xU5Vvm4D4OzdCHR84HGHgwHq2H5+4mhLoZtcGlJ28F73GkINep5VOG65Tgqqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7268
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
Cg0KV2l0aCB0aGUgdXBkYXRlIHRvIGNvbW1pdCBtZXNzYWdlLCBzb21lIHRoaW5nIHNtYWxsIGFu
ZCBwcmVjaXNlIGxpa2UgQ2hyaXN0aWFuIHJlY29tbWVuZGVkIHNvdW5kcyBnb29kLg0KV2l0aCB0
aGF0IFJldmlld2VkLWJ5OiBTdW5pbCBLaGF0cmkgPHN1bmlsLmtoYXRyaUBhbWQuY29tPg0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlz
dGlhbi5Lb2VuaWdAYW1kLmNvbT4NClNlbnQ6IEZyaWRheSwgTWF5IDIsIDIwMjUgMTozNSBQTQ0K
VG86IFlhZGF2LCBBcnZpbmQgPEFydmluZC5ZYWRhdkBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFu
ZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS2hhdHJpLCBTdW5pbCA8U3VuaWwuS2hh
dHJpQGFtZC5jb20+OyBQYW5lZXIgU2VsdmFtLCBBcnVucHJhdmluIDxBcnVucHJhdmluLlBhbmVl
clNlbHZhbUBhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJq
ZWN0OiBSZTogW1BBVENIIHY0IDIvMl0gZHJtL2FtZGdwdTogb25seSBrZWVwIG1vc3QgcmVjZW50
IGZlbmNlIGZvciBlYWNoIGNvbnRleHQNCg0KT24gNC8zMC8yNSAxODowNSwgQXJ2aW5kIFlhZGF2
IHdyb3RlOg0KPiBNZXNhIHBhc3NlcyBzaGFyZWQgYm8sIGZlbmNlIHN5bmNvYmogdG8gdXNlcnFf
aW9jdGwuDQo+IFRoZXJlIGNhbiBiZSBkdXBsaWNhdGVzIGhlcmUgb3Igc29tZSBmZW5jZXMgdGhh
dCBhcmUgb2xkLg0KPiBUaGlzIHBhdGNoIGlzIHJlbW92ZSBkdXBsaWNhdGVzIGZlbmNlIGFuZCBv
bmx5IGtlZXAgdGhlIG1vc3QgcmVjZW50DQo+IGZlbmNlIGZvciBlYWNoIGNvbnRleHQuDQo+DQo+
IHYyOiAtIEV4cG9ydCB0aGlzIGNvZGUgZnJvbSBkbWEtZmVuY2UtdW53cmFwLmMoYnkgQ2hyaXN0
aWFuKS4NCj4gdjM6IC0gVG8gc3BsaXQgdGhpcyBpbiBhIGRtYV9idWYgcGF0Y2ggYW5kIGFtZCB1
c2VycSBwYXRjaChieSBTdW5pbCkuDQo+ICAgICAtIE5vIG5lZWQgdG8gYWRkIGEgbmV3IGZ1bmN0
aW9uIGp1c3QgcmUtdXNlIGV4aXN0aW5nKGJ5IENocmlzdGlhbikuDQo+IHY0OiBFeHBvcnQgZG1h
X2ZlbmNlX2RlZHViX2FycmF5IGZ1bmN0aW9uIGFuZCB1c2VkIGl0KGJ5IENocmlzdGlhbikuDQo+
DQo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IENjOiBD
aHJpc3RpYW4gS29lbmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IENjOiBTdW5pbCBL
aGF0cmkgPHN1bmlsLmtoYXRyaUBhbWQuY29tPg0KPiBDYzogQXJ1bnByYXZpbiBQYW5lZXIgU2Vs
dmFtIDxBcnVucHJhdmluLlBhbmVlclNlbHZhbUBhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBB
cnZpbmQgWWFkYXYgPEFydmluZC5ZYWRhdkBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5jIHwgNiArKysrKysNCj4gIDEgZmls
ZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5jDQo+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmMNCj4gaW5kZXggMzI4OGMyZmY2OTJlLi5l
M2U0YWVlZTEzNTYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV91c2VycV9mZW5jZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV91c2VycV9mZW5jZS5jDQo+IEBAIC04NTEsNiArODUxLDEyIEBAIGludCBhbWRncHVfdXNl
cnFfd2FpdF9pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lkICpkYXRhLA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgZmVuY2VzW251bV9mZW5jZXMrK10gPSBmZW5jZTsNCj4gICAgICAg
ICAgICAgICB9DQo+DQo+ICsgICAgICAgICAgICAgLyoNCj4gKyAgICAgICAgICAgICAgKiBSZW1v
dmUgZHVwbGljYXRlcyBmZW5jZSBhbmQgb25seSBrZWVwIHRoZSBtb3N0IHJlY2VudCBmZW5jZSBm
b3INCj4gKyAgICAgICAgICAgICAgKiBlYWNoIGNvbnRleHQuDQo+ICsgICAgICAgICAgICAgICov
DQoNCg0KRHJvcCBvciBhdCBsZWFzdCBjaGFuZ2UgdGhlIGNvbW1lbnQuIFlvdSBzaG91bGQgbmV2
ZXIgZG9jdW1lbnQgd2hhdCB0aGUgY29kZSBkb2VzLCB0aGF0IHNob3VsZCBiZSBvYnZpb3VzIGJ5
IHJlYWRpbmcgdGhlIGNvZGUuDQoNCk9ubHkgZG9jdW1lbnQgd2h5IHRoZSBjb2RlIGRvZXMgc29t
ZXRoaW5nLCBlLmcuIGluIHRoaXMgY2FzZSBoZXJlIHNvbWV0aGluZyBsaWtlICJLZWVwIG9ubHkg
dGhlIGxhdGVzdCBmZW5jZXMgdG8gcmVkdWNlIHRoZSBudW1iZXIgb2YgdmFsdWVzIGdpdmVuIGJh
Y2sgdG8gdXNlcnNwYWNlIiB3b3VsZCBiZSBhcHByb3ByaWF0ZS4NCg0KV2l0aCB0aGF0IGRvbmUg
dGhlIHBhdGNoIGlzIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Lg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQoNCg0KPiArICAgICAgICAg
ICAgIG51bV9mZW5jZXMgPSBkbWFfZmVuY2VfZGVkdXBfYXJyYXkoZmVuY2VzLCBudW1fZmVuY2Vz
KTsNCj4gKw0KPiAgICAgICAgICAgICAgIHdhaXRxID0gaWRyX2ZpbmQoJnVzZXJxX21nci0+dXNl
cnFfaWRyLCB3YWl0X2luZm8tPndhaXRxX2lkKTsNCj4gICAgICAgICAgICAgICBpZiAoIXdhaXRx
KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgZ290byBmcmVlX2ZlbmNlczsNCg0K
