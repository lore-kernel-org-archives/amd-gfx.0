Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3876C02180
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 09:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE24610E90A;
	Thu, 16 Jan 2025 09:20:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MsZUxLZu";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B837610E90A
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 09:20:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTSg/3SWuFQ1ndcNfMyCLnpLS1R3QyKfrrCZq3nGuSBW/ORNeF5JoQUMyT3b8CMn3AIRHertlxCPxy5Qo4gvNRn6jfUtZOS4lavVc1vqhc+mC42vqQtCqBVTyVBAs3a+GnrCEBSuy+LK1zutfoEJ3bXLOlnaZUySlDhk+BBO3u6jk15QCWe6L4NHfzD552JyDcvvAUKJdn+gXAEmiAGA6gYtdzyFO82CJMGFod45iSujfbq+irRXg4ZONbSR6hlvF+rv8iA/nQSzZo2DUtCoNng85dg4isotSuesLTrm38el8X1hvtplHJaNkBbDa8DNAAmVJvzdAJCFviv9uQy8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1nQsKmGk9Cul2O2s1BrQO9AkY3GviUA3Kg2dOq1SPI=;
 b=ALpslAobAqUeE8QpByoD0QtQWk6sQwytI5nNsGTP5zIw9PAtgEaKqd1pT7yhm7FRjOkJHcBFe++FuaN8vodOkLHROyIn+cQNkeTSWSy7HLPJkuNDFM3U2ZOWaPwN9yKM703lpjJ4TGvrHRA+oiZuKWGjJ1iszjTtD1oGaPydcOLDhMoF9XQjGt0vfVl0ZNkPeTnYkt8qE8XcLjzPkBHTvg9tq/YJoTmpd81lDMxeINCqV/x33z9QX0BHY1b9mXxiD1BI5XMpYsr2BJEZnQ9+Y0RljjnhQ9aircJy6ECoF1pr+6NtUIVsh9ANMBeWbLtuNLiNAdZx+EMY9QvbUrcAGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1nQsKmGk9Cul2O2s1BrQO9AkY3GviUA3Kg2dOq1SPI=;
 b=MsZUxLZuoUqx+uQxwA8KwlAFh+n1To0UGnPmhXLnmAtC35LiJ23qW1fhLbHGm1CNKuxoXM6c0QsYA7iMVuNRk8JxIAvVacYuaRJlDgwucNGbBB+5o3qa6hKaQkZtVt+EJBoVPrRlUFBqFKQSOr6FL/L3o9ps+8Wto15glsjgwgA=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 09:20:16 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 09:20:15 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Tim"
 <Tim.Huang@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use -ENODATA for GPU job timeout queue
 recovery
Thread-Topic: [PATCH] drm/amdgpu: Use -ENODATA for GPU job timeout queue
 recovery
Thread-Index: AQHbZxoNAmjYhPBnrUS8UvEalsLk/bMXussAgAFlraA=
Date: Thu, 16 Jan 2025 09:20:15 +0000
Message-ID: <DM4PR12MB51527D591981841255B34271E31A2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250115065214.3698126-1-jesse.zhang@amd.com>
 <446b0bac-b860-4a04-b150-d29fe7edede1@amd.com>
In-Reply-To: <446b0bac-b860-4a04-b150-d29fe7edede1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3f1790cf-f615-4993-adc3-6132b116c51a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-16T09:16:33Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DS0PR12MB6415:EE_
x-ms-office365-filtering-correlation-id: edf1efce-1fd1-4484-75c2-08dd360efd00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?U1lZL29rbVFOMmtkb1ZyNjBoT2JuRHAvNjdCNzV6dWM2RFdBV2IvY1FEQ3FK?=
 =?utf-8?B?MWt5MHFXQno0QTNmazZRd25Jb2NoQWZXQUxjUG90VnZwUXJEbVltL1duSmdl?=
 =?utf-8?B?UU1QL1kzcGhIRXJXbUsyUGZpb0N0VGN0QUEyZUc3UG5BdUZqNlVmdEt6N1VC?=
 =?utf-8?B?Nk5ER2l4dXJGZFdReHdsMzErTlE2eU5oblN1cDZvNWZCc3BBNWNVaFdXUUNV?=
 =?utf-8?B?ZDZXWUJVZlQ1MFJxVlF2cnR5clBYRkdUbHpva2taVFVaYW9EdDIzb0Z3djNF?=
 =?utf-8?B?eDhpaStPYnpvSUdPSG1JSkhTOVlXb24zbkxTQkowQ0FWVlNqcisrZjdXak01?=
 =?utf-8?B?VXJWcm8rSGdLd2FpSVdSY0hwLzVVdjNzUkRFWUxnUlZROWFhUkRzVHI3ZGdZ?=
 =?utf-8?B?UlVtelZuYXFyekQyakpBZHVHTkdITjRMQUdoTmhTV3kxczZnZmtlcEU3WDFu?=
 =?utf-8?B?b1MrdGN3Y3FXS2QyK3lCYUNxR2F6alc4WDBqNkJ0akVOS2pXeDVsRURBL0lN?=
 =?utf-8?B?ZW56Y0FDcGQrenhkRnM5RkdPNUhoZmdoS2YvYVNOQ1ZMRXNHOWZLeTI4OTRi?=
 =?utf-8?B?V3Q0WVdSeHRxdkJUbDk1dFhwL2puQUgzMW1SZmtUTHoyTForTDhPQkowdHQw?=
 =?utf-8?B?ZGN6UUtzWm82T3EvLzFnK2hIcjB1RVJEeldHT1oybVhucTZVTzJVMVpHSW55?=
 =?utf-8?B?VElaZHQzMXQwWXU5anREbGNYUTd1aUljVUlZMERwenVFRUMwOVhSK3VVRmVD?=
 =?utf-8?B?QWpRaHo2RFdwTDhpZi9YNXpwS2NzUHd0d2hGUmdFUHFpWmpoK212eUdPc3Zo?=
 =?utf-8?B?Y1FWY2gzYS9iTlpWU0l6WHRhU0xnN0dvbHlrVUp0Q2VDTFZRbVp6OUF0ZlUv?=
 =?utf-8?B?eVd2QlJPN3RRUy9wU1dVYUVReDVmYTVMZ1RPTDE0bU1XcnhEdy93MlNRT0d1?=
 =?utf-8?B?UlhWSHdQcjQwSzBOaUw3cDJGbnB5eHpwNkZrSmE4SjU5aW5xZitsTnFvK1Ju?=
 =?utf-8?B?T3cyb2lLTElGQU1kOHRnbEM2VHMzYXdrUWxHRDdCdEdhc0MreS9kM1JoV1NE?=
 =?utf-8?B?YWhDTDNkMUMwUlJJWklKeElyck1nZmliQlN5OWdFZU5vbzF4VXZTbjZHbDlk?=
 =?utf-8?B?cWtzMlFvRUYwajY1MGcxVFlrOUx3Y09KQ00rSFFBdDZwTnFXL0dxWE1VVEQ1?=
 =?utf-8?B?cVUzNUtGTmViS0V3M2lwVitMVGN4K2dROU9JRUt3WUlMNGEwSERnaTFWQTJ1?=
 =?utf-8?B?emlLL1NsYzNQU3gyb1pSM2g4UXhnc2tDaS9SOTAxbitkMFBzaHJ2MTEyMDR3?=
 =?utf-8?B?NE8yb2p6UWtyc0l2ZWFTbURPTXF1czF1dGtTNXZqNlg4Ylo5amNUakIrZTEz?=
 =?utf-8?B?TTlkb2JieWJoajVyeko0RDlLWHZ6MGR3VlZwMi82M1BlRm1YU2cwcmJyOTlP?=
 =?utf-8?B?NGY3aUZPeXM1eXZFRjdKWEZpRWZzQVhOUEozV0swUkRTb1RqeXBkTjE4Q0w2?=
 =?utf-8?B?N0cvaTF6TWZWZVNyZFpVWlh0SCtnOW1XVE5iTk1vM2MwdDIxaXlsN2QrZTQ0?=
 =?utf-8?B?c2x3WWxqTW9HKzVaaHRjY2hqS3IwV1hhWXpxaUZodFd6VG9OTWQyZkIrKzNZ?=
 =?utf-8?B?cHZIek1ZN2ptbEdkREk2dDc5Ryt0OVkzR0Q4U2ovVTFSZ3JqaDRJdmtqenJT?=
 =?utf-8?B?Z3VNdEZxbG5JOG0vR1pqNE44OTdORWhucFFhNTdOQStlckJTMkZRQlVzVWR5?=
 =?utf-8?B?MmtBcU85QW85aGhoRnN5Y1ZGVTZURldJeUpxR1drNzNqTkNRNTloWmVPVGs4?=
 =?utf-8?B?Y2NUU1VNL2dQcTgwdU04ZnlhODFvcmxQOFA0K0RBN2dtNXBPM3RPUzZpdkRv?=
 =?utf-8?B?aUxOdWQ0K2drckRVYUdwdFpBY2plYXpTUW1pakFvbmQydGljd2o1YXdvSjFT?=
 =?utf-8?Q?0UP6USviB86xYxgSEl8sAxv2RVNuutyQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2pjTk9KSmh2RXZZbUY0OU41RGw3bWcwMGtXOVE0WWg4YXVYZ3ZVYTlIUGVx?=
 =?utf-8?B?ZE1NaU5nSXI3eE1HQWdxek5IOHBOOUJYQlJDd0g4emZUblEwL3FOWmRkaTd6?=
 =?utf-8?B?NS9Zc2s3L0NhNUVJTUxBQ0Vhd1pjOVpoeDJFdkpmbkV4TXJaTG5zblBIZHZ5?=
 =?utf-8?B?cmZpUXVGRDdBUFhiNEJoSjJacWpWRGU1THZUUzJ6aDR2NHozZlEwWjduUnhN?=
 =?utf-8?B?TmRTODZ3NGl4cVlVU0Z1UEYrdDVvYkIvNFVVMWEzRVFFUWJ5SHJkcElSdUxo?=
 =?utf-8?B?RTIzRDRPWnVGS0M0WG11NjdzZXJPcUpkTDBZZ01OclBvZXFGUFk3U25wV0Nr?=
 =?utf-8?B?WVQvTW5QZ0N0VTJESWNrYzliVEVOOEZFSzBFenVhN0FOMkd5akhjR3E2bStu?=
 =?utf-8?B?N1V1Nm12UGc3Q3RJdmh5VzJpeXFrdlE3RlIwRndDTTVtdExqVHhnSHV5Z2tP?=
 =?utf-8?B?dlJ0VEFlMC96dnd1OCsrbyt4MzZzS0ZGSWFkcU9DQk10RkprTnRZWG1kcGQ4?=
 =?utf-8?B?Mks5VGRWQjJ0UVltWFhpVmJyaUJEZWFpOC9hTzRLa3dhd0NzMHNhNlVmTDhu?=
 =?utf-8?B?cmR2RFc4cXExNFRoVXI5VVJKZ1oxNUNWT2E0ak5XcmhHMDJ4NUhhU3E5dEkv?=
 =?utf-8?B?TU1SYWsrbndVcnowcW9GcFhEc3UwV0x6Q0xsSkNIaWp5M1FpdEFselIwdDhw?=
 =?utf-8?B?blJ5M3Q0U2s4U085cWJtZ1o4U1hYWS9Rc1p2WDVqNW51Yytsc2pydlR6bzlI?=
 =?utf-8?B?TDlOaDJyZW8rRHpXa2VYYlFaYVNBS0h0ekFnRzdmdFZQMG82S2lFRURZdUpM?=
 =?utf-8?B?a054amdrVlY4aWt6VkdRVFBteFUrVjRYbDdKbGtQelg0S2tpajRCamJldjEv?=
 =?utf-8?B?YVVXUEZYYzJuWS9Xa0ZidXdGL2o5MkFhSzN1U0M5bGRnUDNnT1JuMy82WU82?=
 =?utf-8?B?eDVhcGYwblFIcFh5dTFYWHNLeDBRVTV3cWJxU2VocUpJNTJDeldVZzg3TnFO?=
 =?utf-8?B?ZCtpSkxXSGtnYkd0OUl0MWdLQzdKaXc2VG5tNy8zeDBPU1o0L1RzV0x1SWgv?=
 =?utf-8?B?aG15OCsvWHExR0wrQmZ6MGlscFVPRUxGUGJnK3N6UDMvUGY3ZXNNRzZyODlK?=
 =?utf-8?B?c2ZtNzNrRS8ycmdKemxLOTdaY2d0TDR0QU1uVVN6cDlkVVFndlpOaGFldHpi?=
 =?utf-8?B?NUg1RXFjQnRYV1Z6S1I2dVVvdU9nMFhCY1ZSd042dVpza2g2RHhuUkpxdlND?=
 =?utf-8?B?ZWxONFdPaE9HdXhFdHJxY0dENG1sTmRYb2x0Sm05UUo2K09BMGJTZHJrRTZV?=
 =?utf-8?B?c0pNQmtVRUQ3Uk5lU0lhZDViejFCMTBXZ1hlTGQ0Z2tDVWdmc3E2VWdqZkpm?=
 =?utf-8?B?ejIwYkw1cmYrYzN1U0hvTmRvRFhvdWcwdkI2OHpCVkhmcXVWRCtmd2FiNUFp?=
 =?utf-8?B?VGJYM3JzckVXTTY1V1c0b3pFWnRVdjhJODVRWEhlU2ttWWNlVHkwNTBqc2tK?=
 =?utf-8?B?eUpLYTNITjJPTWh0VzhPdUM5RTF5MmJHUWVwMTJqL2RXMUhQOGxKMEROVnJh?=
 =?utf-8?B?YUlSSG1LQVVCemY0V1E0eE50bG9pTUFxQkpVd2VRTmgyQzdRY2hkUEFnbjhx?=
 =?utf-8?B?Tjh6QVNTMTd2WTN5ZWpaSnpDdWo5RjlETVltK05MLzFzeUFOTnpvWlFBdFBa?=
 =?utf-8?B?VzdlMDFkMUdqaDdCd3V1dUFONDZZckt1ZTRGRGV6WktrU2xtTVpwVkxZcjdG?=
 =?utf-8?B?VWJseG56cEdScmd2Ym03TUVJSi95dGhFeUMwMmN4Y09oaGh6ZHFpMm5YUGZF?=
 =?utf-8?B?RUJnQkE3bTlwQ0VodzJiQlhXQy9HRm9GNHVHWEpaTU5ERVBncXJCeEtzbmk3?=
 =?utf-8?B?LzVmVE9VVTZVUHJzS0NmdzhvOG1ZRDVqV24zeklYdVlQUnZ0cXk1WjJ4UW9l?=
 =?utf-8?B?WjZSbHVmYUU3d1Z0SzRlTjF1UmFLOWZhYWlsYUI0MUE2c1hQZ0EvRElEMjJY?=
 =?utf-8?B?cXM4WHNBdnBjbFV5aUxhYzZCWVRHQXpYWlZmWWVMYXJXSy9tc0NHb1kyUit3?=
 =?utf-8?B?MlBlcjR6UmpNYldIdTQ3T1h4UUlVcUhTOXZBSFlsVDBqWFNjZXpya09nY3h3?=
 =?utf-8?Q?KcGw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf1efce-1fd1-4484-75c2-08dd360efd00
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 09:20:15.8522 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cbd0O8oe4BUQRtv51fnUoapglWBWMA1fP1/ayCDz7R3osarLQSB2uzJhlwyuwediLlH+ukzpeCA2rK8Xgb7nBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415
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
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxD
aHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMTUsIDIw
MjUgNzo1NiBQTQ0KVG86IFpoYW5nLCBKZXNzZShKaWUpIDxKZXNzZS5aaGFuZ0BhbWQuY29tPjsg
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgVGltIDxUaW0uSHVhbmdAYW1kLmNvbT47
IFByb3N5YWssIFZpdGFseSA8Vml0YWx5LlByb3N5YWtAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGRybS9hbWRncHU6IFVzZSAtRU5PREFUQSBmb3IgR1BVIGpvYiB0aW1lb3V0IHF1ZXVl
IHJlY292ZXJ5DQoNCkFtIDE1LjAxLjI1IHVtIDA3OjUyIHNjaHJpZWIgSmVzc2UuemhhbmdAYW1k
LmNvbToNCj4gV2hlbiBhIEdQVSBqb2IgdGltZXMgb3V0LCB0aGUgZHJpdmVyIGF0dGVtcHRzIHRv
IHJlY292ZXIgYnkgcmVzdGFydGluZw0KPiB0aGUgc2NoZWR1bGVyLiBQcmV2aW91c2x5LCB0aGUg
c2NoZWR1bGVyIHdhcyByZXN0YXJ0ZWQgd2l0aCBhbiBlcnJvcg0KPiBjb2RlIG9mIDAsIHdoaWNo
IGRvZXMgbm90IGRpc3Rpbmd1aXNoIGJldHdlZW4gYSBmdWxsIEdQVSByZXNldCBhbmQgYQ0KPiBx
dWV1ZSByZXNldC4gVGhpcyBwYXRjaCBjaGFuZ2VzIHRoZSBlcnJvciBjb2RlIHRvIC1FTk9EQVRB
IGZvciBxdWV1ZQ0KPiByZXNldHMsIHdoaWxlIC1FQ0FOQ0VMRUQgb3IgLUVUSU1FIGlzIHVzZWQg
Zm9yIGZ1bGwgR1BVIHJlc2V0cy4NCj4NCj4gVGhpcyBjaGFuZ2UgaW1wcm92ZXMgZXJyb3IgaGFu
ZGxpbmcgYnk6DQo+IDEuIENsZWFybHkgZGlmZmVyZW50aWF0aW5nIGJldHdlZW4gcXVldWUgcmVz
ZXRzIGFuZCBmdWxsIEdQVSByZXNldHMuDQo+IDIuIFByb3ZpZGluZyBtb3JlIHNwZWNpZmljIGVy
cm9yIGNvZGVzIGZvciBiZXR0ZXIgZGVidWdnaW5nIGFuZCByZWNvdmVyeS4NCj4gMy4gQWxpZ25p
bmcgd2l0aCBrZXJuZWwgYmVzdCBwcmFjdGljZXMgZm9yIGVycm9yIHJlcG9ydGluZy4NCj4NCj4g
VGhlIHJlbGF0ZWQgY29tbWl0ICJiMmVmODA4Nzg2ZDkzZGYzNjU4IiAoZHJtL3NjaGVkOiBhZGQg
b3B0aW9uYWwNCj4gZXJybm8gdG8gZHJtX3NjaGVkX3N0YXJ0KCkpIGludHJvZHVjZWQgc3VwcG9y
dCBmb3IgcGFzc2luZyBhbiBlcnJvcg0KPiBjb2RlIHRvIGRybV9zY2hlZF9zdGFydCgpLCBlbmFi
bGluZyB0aGlzIGltcHJvdmVtZW50Lg0KDQpJJ20gYWJvdXQgdG8gcmVtb3ZlIHRoZSBzY2hlZHVs
ZXIgc3RvcC9zdGFydCBmb3IgcXVldWUgcmVzZXRzIHdoaWNoIHdvdWxkIG1ha2UgdGhpcyBoZXJl
IHN1cGVyZmx1b3VzLg0KDQpPbiB0aGUgb3RoZXIgaGFuZCBJJ20gbm90IHN1cmUgd2hlbiBJIHdp
bGwgYmUgZG9uZSB3aXRoIHRoYXQgd29yay4gU28gY291bGQgYmUgdGhhdCB0aGlzIHdpbGwgdGFr
ZSBhIHdoaWxlIGFuZCB3ZSBzaG91bGQgY29tbWl0IHRoaXMgaW4gdGhlIG1lYW50aW1lLg0KDQpU
aGFua3MgQ2hyaXN0aWFuLCBJIGhvbGQgdGhpcyBwYXRjaCB0aWxsIHlvdSBmaW5pc2ggaXQuDQoN
ClRoYW5rcw0KSmVzc2UNCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg0KPg0KPiBTaWduZWQtb2Zm
LWJ5OiBWaXRhbHkgUHJvc3lhayA8dml0YWx5LnByb3N5YWtAYW1kLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogSmVzc2UgWmhhbmcgPGplc3NlLnpoYW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYw0KPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYw0KPiBpbmRleCAxMDBmMDQ0NzU5NDMuLmIxOGIzMTY4
NzJhMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pv
Yi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYw0KPiBA
QCAtMTQ4LDcgKzE0OCw3IEBAIHN0YXRpYyBlbnVtIGRybV9ncHVfc2NoZWRfc3RhdCBhbWRncHVf
am9iX3RpbWVkb3V0KHN0cnVjdCBkcm1fc2NoZWRfam9iICpzX2pvYikNCj4gICAgICAgICAgICAg
ICAgICAgICAgIGF0b21pY19pbmMoJnJpbmctPmFkZXYtPmdwdV9yZXNldF9jb3VudGVyKTsNCj4g
ICAgICAgICAgICAgICAgICAgICAgIGFtZGdwdV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlv
bihyaW5nKTsNCj4gICAgICAgICAgICAgICAgICAgICAgIGlmIChhbWRncHVfcmluZ19zY2hlZF9y
ZWFkeShyaW5nKSkNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZHJtX3NjaGVkX3N0
YXJ0KCZyaW5nLT5zY2hlZCwgMCk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRy
bV9zY2hlZF9zdGFydCgmcmluZy0+c2NoZWQsIC1FTk9EQVRBKTsNCj4gICAgICAgICAgICAgICAg
ICAgICAgIGdvdG8gZXhpdDsNCj4gICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICAgICAgZGV2
X2VycihhZGV2LT5kZXYsICJSaW5nICVzIHJlc2V0IGZhaWx1cmVcbiIsIHJpbmctPnNjaGVkLm5h
bWUpOw0KDQo=
