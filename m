Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB21CCFA1A
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Nov 2025 01:49:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24B7110E09D;
	Mon, 10 Nov 2025 01:49:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="suvx128I";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A4BC10E09D
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Nov 2025 01:49:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htdN5LfZ+2zPvcebtwTSOLxge2gGElWqlZmrmIti684g31dIVnlUPO567uv/uGj3/EKCLmQkqsQz6TwsbAVkVlcVGtpulSuxGBXb8U6ae+PLXJGWHRSKIC/gZzmiXH9m/W2mrrCDJhN8W5yZVeyFE6ltXic9zXc7gPXhm8XGjZtR29RMDz2K68KMShcbivf6d0S5mb5+4FxWcZjV+h9Hb8CsvsPGNb8npZaQPGjT3gROYLZiKlRCDgoj350iisA0IF850cq6fs0ikH2I7K13JNhvT2/mXbs3TaQ7e5AFtkqD7N07zYQuKZsEgJL7wbNPTskX4JeRlLnZzEm42JfYvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+fLtA1RFALDcel7Sxuklvn+zFxu6IyT8B1QX4soP0A=;
 b=PMIvJ/gqse2wY1fysJ4sHPcNbXofXMR9TKue6LmXZAGf6ivZxJ33c1dSyrFeETpWT67aLVkqCa3QWcGLhi5Q8GVjhuVYtLEY6NSLzWe4Xgd83kRT5g0QX7oBxyLz1gEFgH+4B+Zm+IlJ+LOtfKW4TwECMKG0fbWFiXXGl8ddaD2Y8P+j8piu9mfreava6HFfQCV6lBHL/M747KeviKGVw65SDuRicEnvIn5vTS7iRw8mmjy8gMOO0UyqqedtyKN3kXvbDDHjBFHcwmZE9BhVPclioP0Xoh36zqBCTwqB/rcQuk/cb0TVR2SewsFmoY42Ni4azaQIGgNwh5SRoI+QkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+fLtA1RFALDcel7Sxuklvn+zFxu6IyT8B1QX4soP0A=;
 b=suvx128IuSadpwT9KBc4HAQbS4bTComtWj1r5h0hHxYAS8IQQ7fKiD2JvMG1tT/Ci6PMs3V1JpntkpG7jr999JOnjEazEnWtu8n2dLW/HDTfz4ikw55ri0jKwfEoDw/PQSjHaJu070DCjQaF7JG7IHvNl39YUTrOjKgIZ4BDV0M=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 01:49:04 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 01:49:04 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resume MES scheduling after user queue hang
 detection and recovery
Thread-Topic: [PATCH] drm/amdgpu: resume MES scheduling after user queue hang
 detection and recovery
Thread-Index: AQHcT9l6lhKSyqqNBESeJGRaQcPs4bTnQAGAgAPnbAA=
Date: Mon, 10 Nov 2025 01:49:04 +0000
Message-ID: <DS7PR12MB60051224A2E188939C4F100EFBCEA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20251107112704.4080134-1-Jesse.Zhang@amd.com>
 <CADnq5_MtwYtWN-63DAyeRHnLNKG=4qH5PMXdqfBAtXeoe7aFVw@mail.gmail.com>
In-Reply-To: <CADnq5_MtwYtWN-63DAyeRHnLNKG=4qH5PMXdqfBAtXeoe7aFVw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-11-10T01:44:44.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|LV2PR12MB5944:EE_
x-ms-office365-filtering-correlation-id: ac051ae1-f1ee-4b00-6ffb-08de1ffb5444
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?alhrakRlK05DZWxNS3RtRXBFR0hvd2VReGhDL0pNV2pCeGtNUVRxUVpyc0g5?=
 =?utf-8?B?YkJaNVc1MUhxQS8yRGJ5UVEwVDlSQTZISERKSU56Y1FOQ3pYS1IyMVlndkwr?=
 =?utf-8?B?VDJtWU83bEo3bVp0WnRObjZpZG8zemhmVjRTNWM4ZjVvWENBK3prV2hJdmgv?=
 =?utf-8?B?YXFMSDlUa3RRN0ZxUG5UdUJLdE0xNnhGSkdrQkx1ZzN2TUZJNWV1VjFzR2dx?=
 =?utf-8?B?VFFnNFBuTDkyVE00WmtXWUdOV3krZVFNcFkrZFNUNWpaK2F5Q1p6R0tGOGMz?=
 =?utf-8?B?OE1ucjc4UFU1bEM2d1YrNm43OXhjWkxlM3dhNEpKTlVJK0gxQ1Q3NXlvbzZE?=
 =?utf-8?B?S29nSG40eVNhWm1DTndpM292eS96b2hWNmRRM2NKTkE2K1ZqK1hVZ3lPRkMv?=
 =?utf-8?B?UDQ1WDlxOXV6L2hEdEtEZ3NFQnk4SWFsY2NtU3FrWVQ5R1pmZVl2TnAwL0V4?=
 =?utf-8?B?em1ReEFUWkIxaUNiOEVuRmw1Mnc2NUltMytLOHdCLzZhQ3JCa1p1QmxJR0Yx?=
 =?utf-8?B?ZTFtTUtNMDRIVVdiMGNHNHF1VXFLdUlYQlFpMEd2NTFJeFBIQ3FXaVZkdDFL?=
 =?utf-8?B?ak1DZ2ovODdPZGNleFp0dkNYckU0QWJ5TmlCTEtRWkNiT1dYTFUxaEJRcDVO?=
 =?utf-8?B?OVBabmxSbkNNak5LQ1pzUnkwemlUSERNLzBQdm04QW9GUW83L1cvQy9aWW1B?=
 =?utf-8?B?aVkvWXBDUVJQbmFBWWFtUjhZNDV0VEhaUEgxYUgxNmZXaXNtcGpEYlpORE03?=
 =?utf-8?B?Z0lFNlBDYzYvYW9aVm1GYmsrRkpaU21aQjZST3BXOU9IbTExR1pKeFdnVkVX?=
 =?utf-8?B?RjFzU2Q2L1FoSndCNW5Wd2JjWFlmeWR0aGpUQzh4MjkvOTRwUWQ1c0pyMzVL?=
 =?utf-8?B?M3ROeHVHc1hna012OTlyZW1GZkQ0dWRxS21DaWE4c2xDbkFrY3d2dmx4enJz?=
 =?utf-8?B?SnZHR3UxMjZVbVdSL3NjS1IyMHVKakw2cy9jM1FGWkVhckpIQ09NYUllSTli?=
 =?utf-8?B?dHNyTUg2QmoxakVkcGVjNWMzMi80dXpvc1FJZEowYWszSldvbnh3eDV2dXVZ?=
 =?utf-8?B?SVBlQ3BpeU1PWmlTcVYzS3k4ZHpmTlU1RzhHbHpnVGpwWDM1RnZaRGYrc2cr?=
 =?utf-8?B?bHVWaHBZcnh1NXIvNHpzMmxYT2NMQ0pyZGdzTXJZM0NDUkoycTNlVTU2QUlp?=
 =?utf-8?B?Nk5Kdk4wdVVvbHhGY2JDNURUT01jM2Q0c0VqTCs2bk4wZkI2TUxrSkhyQWdi?=
 =?utf-8?B?Zm5RbTIwUzRXMWZyb0JBL3U5R2hwTWYxcUJNWkttL3orS3MrVWg4a1ZFQlVl?=
 =?utf-8?B?aEVldHRpQnVscFZXdXRhdlpPRW10L0hHWGZnMGxJbFFsdFZCWFlEclVCYjVq?=
 =?utf-8?B?eUtDNFZUMUVJVTNnYlVZVVJuZzVRdEo0d2c1RDQvVDdNVHpTSWZpK1NPR1gv?=
 =?utf-8?B?N281djMxY1hrVnFHcnhOY0U5YUc1Sy9JZlVWZ2YzVWQ5ZjRCOGpkNk5rSnZR?=
 =?utf-8?B?Sk9yc2puL21tem9pNWMvNGF2cVBNaXpaMDAyUWtwWlFMNFpMQ250TVc5UzZU?=
 =?utf-8?B?OWpxRjV4Z3RnQk1VZU9SdlBDMXVhcDZJb0RlNHFIN1BWaU4xa1JmaW1pdURr?=
 =?utf-8?B?YzdQZ3M0M0czRGc3OWtpdkdwQUV2dEd1T1ZycFlVbUwwYWxkdXBlMStndWl4?=
 =?utf-8?B?eElGelVMU0Z6RGxKZmlnZUliQXFpblIvU2xxNnVsR0FNbTg3eWN1VlJSMjhm?=
 =?utf-8?B?Vnl5cUYzenVHak1ZbTBLRDJuUkhNd0dQWG9nWGxIdGtPb2prQkxUVnk0OUlh?=
 =?utf-8?B?K0FOVHhFTW1JU1RCODZGWHB1cE5yU09WRHUwZlRhR1I3OG1iaEwrV1pHeXhw?=
 =?utf-8?B?OGdsRCtvaUQxSmxRcmtVOWFaSjZXVVBkdzhHWGIxU0NUNU1idS9PZzZxazNn?=
 =?utf-8?B?VitQYVh2N1cweXBPYmZmRytVMGJCSS9sNjZaSFhGNmROUHg1dWwvdTlRRjJZ?=
 =?utf-8?B?aG9heFBUQmhROVZ1UkRrYURxZjBiSktTd2hNQTBmMkV5cExLWUl6SUZuU1h2?=
 =?utf-8?Q?I3Aca3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVZKV20rcnd3Z1h4czh3M2szTmdCNjB0cjNYTTJFcC9LT0tvM1R2MEpTSVYw?=
 =?utf-8?B?QngzU2w0Smp1TnBnU3JaWWZQc2JFdEJHSG1US3VqcjdaUDhmWlhTSExQMC85?=
 =?utf-8?B?cytUMWVqSUJlb242dCsvcmdzb2NwYmhkN1V0d3MrWGR3NlRDKzIwV01aSWht?=
 =?utf-8?B?VHUxbGRjOGxDVDZLRHJGdjNYYS9jMHEwbC9zVEQ1eS9ZZS9OVGg4cUkzODF4?=
 =?utf-8?B?QnJkK0lqYnM5WkpwemVEaEpQT0FEMzNpM3FSN20vQ2tVbmtqZ2p0SDhVRFE4?=
 =?utf-8?B?ejUwby9sbE5zU1dRaFhETlM3akZqZFg3VUxYZzU5N2NhUVhEbVFSNTd5bktC?=
 =?utf-8?B?b1U5eFRjS29mbTM3dG4vZjk1dlBRMjRGV0tncWt1TmdrL2JnbC9qcTR3ZWlr?=
 =?utf-8?B?VXNNV2t0K1h5RE4wWGttQk96R1U0MFJBVzAzSmEwVnlta0Zabm5RWDBiZk11?=
 =?utf-8?B?Z21tdzFpcnFtN1dyQ1dZYWZ4TkJnNnFwVnJXbnBCRGoxR280VTFoN09Pd3l4?=
 =?utf-8?B?aVh0aTRuNlhwdlI2T01CaE9jTkpBOWNpbVA0QkZseHJZL3ZYSm90NVdEdVlv?=
 =?utf-8?B?TU91L1BjK1NKQ1JrM0x3akFxTDdreWN4NUNtRVlEMUM2MWp2YytaNk03amFt?=
 =?utf-8?B?MkFncU9aSDlxQTA3aUZRSmpFWUtVMUZvZmpjeXpGRlpqcnZ0Y0paVEdaYWZW?=
 =?utf-8?B?UDdEMDNWWGJpbmFGS0h6akxMZ3laZm1nTXp4U2hrQ3piNCs4emlBSTB5cFNN?=
 =?utf-8?B?SEVQZkZ3bVlJY25BSzJ6ekVOWWFWaCtZSkJ0YzhJOUVhVmNWTkhoc3dSSXNw?=
 =?utf-8?B?dUVOTmdnM2luMVZrK3ZyVUQvd0g1Z0ZkamQ2S2RKLzZPZnA1MkYzdURMUkJT?=
 =?utf-8?B?UHVQRytnSmE5VkgwNUxUNDA1eVJRQzFISTZpRUlnaVczdmhLeXFJSCtGSkpP?=
 =?utf-8?B?WmVoZGNjdGZINDVGVml6STFQQkhrdHRDT2lFbkNUZHEvWFVLa0tEQ1R3Y0F6?=
 =?utf-8?B?SFdJUkdXblliVUhQck1rdTBTVmVuSVZDYld5cUMzVmNLOWxwZGRtTThxMENw?=
 =?utf-8?B?WWVNejlKRlVBZmdnSUJFQ1M3S3g1MTIzSE1BT1NBcFBqSHZDMmVDMm1kRjBB?=
 =?utf-8?B?K1RwZUZpZDdvUVFxYUp6eW11NmovcXc4cU94S2IzTk5ZZUFyVE55QTZBNVZL?=
 =?utf-8?B?UmY1R1kwT0w5blpyaEIvSHl2SGQ4TklNZTJJWFNLc3AwRjFJOGZFZkxFajA2?=
 =?utf-8?B?MWF3V0hzL0F3ZFEwbzdsSC9lTGhQSVRiblBTaERFbXdoQVN5bEtKK284VWts?=
 =?utf-8?B?QTltU0dRN1JzTWYzcXBVVDZkanpCRXFLM2lZTTRFNEd3Vkh2K3d0K2l2NS8r?=
 =?utf-8?B?aEZ2SENtcnVOc3BVd2tQWWxBZ2NOMEhwSlFyY2hjemY0NnNtSmpHVE12cWFH?=
 =?utf-8?B?dEU1RHJaejlBZzZwUGk3eVZ2MW1ZQXZLczJzZWYvWno5RSt0TjFjd2JjaTNJ?=
 =?utf-8?B?WUo3RGtEMkJ0VXdTNUZ5eDJUVlpFMm1aNTFtZ0oxSHErZFRkdEU0Z2loYjQr?=
 =?utf-8?B?YUFHOGtUN1NzRENoVmlKUCs3QkpYaTZQN1FlalpaYWRtSFZFaGZkQUN2Mi9P?=
 =?utf-8?B?S1EwcjZlWDg0eDZSV01xbEZRaWVTc1NaUHV4aWNpbU5iRVRMeTY5TUxZY1R2?=
 =?utf-8?B?UEJaM3Mrdi9ZS2t0eWtCVzJpUkxsRVQrZEUrYTNwaWRlbzFBN3F5VFJ3K3BX?=
 =?utf-8?B?R1gxTWU1Ylo3MWJvYWlFNXErK2ZRSm5XenZTeU5FTDRpNyt4ZmhqeVJoMldt?=
 =?utf-8?B?MXpoTitDangxV0ZTVWk1UTVtVDdCSHdOL0RpemgzcE1hbXpCVDdHdFdLaERZ?=
 =?utf-8?B?VGRObUtOUVJBUjV6L1NIbnR6cWEzQ2Vub1NSTTBnU0tQa3REUThxN2ZiVDc2?=
 =?utf-8?B?c0FhbDNHRFBGVFUrR3pvQmtyWS9rN0pIR0hkeW1ZenNVR2NtNFlUUVhueHpE?=
 =?utf-8?B?TnlGQUFEaVdUamRIaWpSSzluN295NkV6QzNaRTlnNEtwRGhMZ3lYbktWOGk3?=
 =?utf-8?B?bEl6UXZkVEhhS21ycE95TkxGSk0xS2JoWFpOVjFhK3VRT0hzeDRnNVVzZ0VN?=
 =?utf-8?Q?EaZ4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac051ae1-f1ee-4b00-6ffb-08de1ffb5444
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 01:49:04.4176 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z3BjF6w7YEhcDgmmt8DSU1pZpL9LbpqGImQ25EC+Q6k3d9+w/SY2+hnJcNMJoAWK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944
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

W1B1YmxpY10NCg0KT0ssIHNvIHRoYXQgbG9va3MgdGhlIHF1ZXVlIGlzIG5vdCB0aGUgZnVuY3Rp
b25hbCBzdGF0dXMgYXMgSSBwb2ludGVkIG91dCBpbiB0aGUgbGFzdCBtZWV0aW5nLg0KV2UgbWln
aHQgdG8gY2hlY2sgdGhlIHF1ZXVlIHdoZXRoZXIgaXMgcmVtYXBwZWQgb3IgYWN0aXZlIGJlZm9y
ZSBwZXJmb3JtaW5nIHRoZSBxdWV1ZSByZXN1bWUuDQoNCg0KUmVnYXJkcywNCiAgICAgIFByaWtl
DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdm
eC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEFsZXgNCj4gRGV1
Y2hlcg0KPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDcsIDIwMjUgMTA6MDcgUE0NCj4gVG86IFpo
YW5nLCBKZXNzZShKaWUpIDxKZXNzZS5aaGFuZ0BhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IHJlc3VtZSBNRVMgc2NoZWR1bGlu
ZyBhZnRlciB1c2VyIHF1ZXVlIGhhbmcNCj4gZGV0ZWN0aW9uIGFuZCByZWNvdmVyeQ0KPg0KPiBP
biBGcmksIE5vdiA3LCAyMDI1IGF0IDY6MjfigK9BTSBKZXNzZS5aaGFuZyA8SmVzc2UuWmhhbmdA
YW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGlzIHBhdGNoIGVuc3VyZXMgdGhlIE1FUyBpcyBw
cm9wZXJseSByZXN1bWVkIGFmdGVyIGRldGVjdGluZyBhbmQNCj4gPiByZWNvdmVyaW5nIGZyb20g
YSB1c2VyIHF1ZXVlIGhhbmcgY29uZGl0aW9uLg0KPiA+DQo+ID4gS2V5IGNoYW5nZXM6DQo+ID4g
MS4gVHJhY2sgd2hlbiBhIGh1bmcgdXNlciBxdWV1ZSBpcyBkZXRlY3RlZCB1c2luZyBmb3VuZF9o
dW5nX3F1ZXVlDQo+ID4gZmxhZyAyLiBDYWxsIGFtZGdwdV9tZXNfcmVzdW1lKCkgdG8gcmVzdGFy
dCBNRVMgc2NoZWR1bGluZyBhZnRlciBjb21wbGV0aW5nDQo+ID4gICAgdGhlIGhhbmcgcmVjb3Zl
cnkgcHJvY2Vzcw0KPiA+IDMuIFRoaXMgY29tcGxlbWVudHMgdGhlIGV4aXN0aW5nIHJlY292ZXJ5
IHN0ZXBzIChmZW5jZSBmb3JjZSBjb21wbGV0aW9uDQo+ID4gICAgYW5kIGRldmljZSB3ZWRnaW5n
KSBieSBlbnN1cmluZyB0aGUgc2NoZWR1bGVyIGNhbiBwcm9jZXNzIG5ldyB3b3JrDQo+ID4NCj4g
PiBXaXRob3V0IHRoaXMgcmVzdW1lIGNhbGwsIHRoZSBNRVMgc2NoZWR1bGVyIG1heSByZW1haW4g
aW4gYSBwYXVzZWQNCj4gPiBzdGF0ZSBldmVuIGFmdGVyIHRoZSBodW5nIHF1ZXVlIGhhcyBiZWVu
IGhhbmRsZWQsIHByZXZlbnRpbmcgbmV3bHkNCj4gPiBzdWJtaXR0ZWQgd29yayBmcm9tIGJlaW5n
IHByb2Nlc3NlZCBhbmQgbGVhZGluZyB0byBzeXN0ZW0gc3RhbGxzLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogSmVzc2UgWmhhbmcgPEplc3NlLlpoYW5nQGFtZC5jb20+DQo+DQo+IEFja2VkLWJ5
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+DQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYyB8IDcgKysrKysr
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3VzZXJxdWV1ZS5jDQo+ID4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMNCj4gPiBpbmRleCBiMWVl
OTQ3M2Q2MjguLjZkMWFmNzI5MTZhNSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMNCj4gPiBAQCAtMjA4LDYgKzIwOCw3IEBAIHN0YXRpYyBp
bnQgbWVzX3VzZXJxX2RldGVjdF9hbmRfcmVzZXQoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsDQo+ID4gICAgICAgICB1bnNpZ25lZCBpbnQgaHVuZ19kYl9udW0gPSAwOw0KPiA+ICAgICAg
ICAgdW5zaWduZWQgbG9uZyBxdWV1ZV9pZDsNCj4gPiAgICAgICAgIHUzMiBkYl9hcnJheVs4XTsN
Cj4gPiArICAgICAgIGJvb2wgZm91bmRfaHVuZ19xdWV1ZSA9ZmFsc2U7DQo+ID4gICAgICAgICBp
bnQgciwgaTsNCj4gPg0KPiA+ICAgICAgICAgaWYgKGRiX2FycmF5X3NpemUgPiA4KSB7DQo+ID4g
QEAgLTIzMiw2ICsyMzMsNyBAQCBzdGF0aWMgaW50IG1lc191c2VycV9kZXRlY3RfYW5kX3Jlc2V0
KHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IGh1bmdfZGJfbnVtOyBpKyspIHsNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHF1ZXVlLT5kb29yYmVsbF9p
bmRleCA9PSBkYl9hcnJheVtpXSkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHF1ZXVlLT5zdGF0ZSA9DQo+ID4gQU1ER1BVX1VTRVJRX1NUQVRF
X0hVTkc7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZm91bmRfaHVuZ19xdWV1ZSA9DQo+ID4gKyB0cnVlOw0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGF0b21pY19pbmMoJmFkZXYtPmdwdV9yZXNl
dF9jb3VudGVyKTsNCj4gPg0KPiBhbWRncHVfdXNlcnFfZmVuY2VfZHJpdmVyX2ZvcmNlX2NvbXBs
ZXRpb24ocXVldWUpOw0KPiA+DQo+ID4gZHJtX2Rldl93ZWRnZWRfZXZlbnQoYWRldl90b19kcm0o
YWRldiksDQo+IERSTV9XRURHRV9SRUNPVkVSWV9OT05FLCBOVUxMKTsgQEAgLTI0MSw2ICsyNDMs
MTEgQEAgc3RhdGljIGludA0KPiBtZXNfdXNlcnFfZGV0ZWN0X2FuZF9yZXNldChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgfQ0K
PiA+DQo+ID4gKyAgICAgICBpZiAoZm91bmRfaHVuZ19xdWV1ZSkgew0KPiA+ICsgICAgICAgICAg
ICAgICAvKiBSZXN1bWUgc2NoZWR1bGluZyBhZnRlciBoYW5nIHJlY292ZXJ5ICovDQo+ID4gKyAg
ICAgICAgICAgICAgIHIgPSBhbWRncHVfbWVzX3Jlc3VtZShhZGV2KTsNCj4gPiArICAgICAgIH0N
Cj4gPiArDQo+ID4gICAgICAgICByZXR1cm4gcjsNCj4gPiAgfQ0KPiA+DQo+ID4gLS0NCj4gPiAy
LjQ5LjANCj4gPg0K
