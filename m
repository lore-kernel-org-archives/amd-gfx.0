Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C5DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 03:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72DCC10FC49;
	Tue, 12 Apr 2022 03:06:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1322110FC49
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 03:06:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3iJHyztwVQcODhnuZxGNHJFLjmk9cahfY9zJf91Y2ThjsBWqgzfvwwTPFPQonj12MQqCsrrd7Gjx8/jY/mFrrvxYwJiS6VlnErwXGsN75QXWrag5zWye7ArsZDLmYOx3gMyeR+mgu4gftm5wmQU7BZkjNYgVP9Fm2wir7mZVrE4N08zVHEqSCRjBGIMqsBgOjaSnCuYBoszyA+HsziujsUI8VbXcKNWFXjA0X4gCbTAcp2akGEwxNmHrjR1Ix1s0zoIGMyr8QeboPetw3JfXhjjnlwbHwSlmXPzByDzMSzjlDpykBg0K6wOHSPIlqgbvSAF9wwbdjZXDii0BIKCuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqykEHZE25ivGnWaX1MQUIMy2fcZWeBd0k3bWL5gRDk=;
 b=iCpEdaExZt2p8JDnU0McVwZXlK5rB8MTdvJ04c7D82//9o3SmVKtKKyAvmW2N5TKSCYOkuhAjBPfZaVPlRW34gQW1qbF/h4un9M0h/Htej2i4qpf+oQ9ZpNJtEC/EdYNgscIwHa4KeL/BfR8zUYwFFESWESBhaElfKjK/ffFKNVh1Y/eYsGGZWISLw2nNgLQtXwWv3/VjmlQq7O+6Ug+csqoSZXRey+C/A25894TnrP+NXKTfN67S5kiqC8BlencmwsLhbWXtfHoPxflbXBbTqYklrAxBBoQW/cCq1/LtskP7V71Oy8mBGipEe8pZvsWfMS8U/VdQGeOadrUOzeJsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqykEHZE25ivGnWaX1MQUIMy2fcZWeBd0k3bWL5gRDk=;
 b=1dFKUt9txig2huBrdzrGzsalwSMyl1piHpaPttXXJ2YoDrsGe9EP6TcUZA8Z+39OmXwBCSnJQ1ERqTPecMFlzWtyHrHXlPUGeCf/agxcX6+oIE62WORUOtJYctWdQBu643t262bJkY2ly2v//As+ntVyRUnanB7oi7+CL2e3UdU=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by MWHPR12MB1840.namprd12.prod.outlook.com (2603:10b6:300:114::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 03:05:58 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::c859:48c0:88a5:bc8c]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::c859:48c0:88a5:bc8c%6]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 03:05:58 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Ziya,
 Mohammad zafar" <Mohammadzafar.Ziya@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: add poison consumption flag for RAS IH
Thread-Topic: [PATCH 1/3] drm/amdgpu: add poison consumption flag for RAS IH
Thread-Index: AQHYTZSHQVYcy8mtUEqum5d54hIkaazqwRgAgADXLFA=
Date: Tue, 12 Apr 2022 03:05:58 +0000
Message-ID: <DM5PR12MB17706C490CEA00BBD3DDB973B0ED9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220411110825.18808-1-tao.zhou1@amd.com>
 <BL1PR12MB5334047390308672B445C7559AEA9@BL1PR12MB5334.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5334047390308672B445C7559AEA9@BL1PR12MB5334.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-12T03:05:55Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=08114bf4-abc2-4172-b902-c897ce91c910;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-04-12T03:05:55Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 4845844a-d52c-4a3e-864b-df80470c8a5e
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 329ad1a0-0ec7-4156-928d-08da1c315e28
x-ms-traffictypediagnostic: MWHPR12MB1840:EE_
x-microsoft-antispam-prvs: <MWHPR12MB184072D450F66D6B0AACBDA0B0ED9@MWHPR12MB1840.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZfUbZsOaV9VGzbVEliioMq4sWa7OYxlTD4EG0DVbtH05tKyhoMdkY2nuwINsmxNldWQwh5NyKwNEj4u5Q6rVsWrOx4VB93yvq2PwKAiEvxrZM+bPpd4Neb3XNaOapJX21chH7OO5BYzJ+yhYu3MLbdDFN7T7FJ1VMeljGbau+/bYX5i5vlr2+rWP61iBHvdi1+qoK8GJsPY8UOyZRQc+ka5oVRZVoK+1RmtcKBkz9aRWRSWcJ/pKo2bIiwS3bETI7UryQek5Bej7nXfdyL0U0onuuWZ60gCzGItuntbBnPt8tOiYiXn37TUloBY4Yb0JnKxXGOpHFjyQem5Vqwv5uHqcaefkF5QjuBYJ7cme1WFErHeOGYvaaUwbjU8glriQ6eYWk8P6rBa+wsNUJcg3TuEnIwo8LMZGhmixdgSMxjXKc6stroM7T4swEInHoZww2UoiBTSmU90zZ82CAUI/6ZJoEU7PuvIyHigpUH68wreTl5ZB4hiWFbcK2lXa+9Yp6LYm0j2An42A8+iaMPeeGzGEke0IlPlkGaKUixBG0nwW3MxVVMrsYGhS7mQ1oHUmZiPTfXhQzhZdAbKSCrePfuy8kS3au0Y3dPwm3fTCtgJYDOnjUFNUrooLsk+oKI8rGGdy2VG7lKlynD3LJR2YJfh73JhSwqozE198n9q4/i3du9DQwp2/gGapog7DtNldYqAvEo4+LTGTA4Cp9LgD3WPz2dN9ZlbmCM+hRDPtGVY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(55016003)(921005)(66556008)(122000001)(66476007)(26005)(508600001)(33656002)(8936002)(5660300002)(186003)(83380400001)(52536014)(66446008)(53546011)(64756008)(86362001)(110136005)(71200400001)(6506007)(38100700002)(2906002)(38070700005)(316002)(6636002)(76116006)(8676002)(7696005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bng0aForSVBoL0xwZjFyNklmWCtDYVVqeTdaS1pBOThEVlBGYWFtV3l5NUhW?=
 =?utf-8?B?OVc2K0NxNHZacXRYWTRROUoyYUYrYnJSelpGSFViKy91ODhTOGo2RHhIcTZ1?=
 =?utf-8?B?R25vSEw0WHRHb3R0aitHeXMxVFF4SS9rSGJpQzRKVTZrYnhlbjJZYWVKL3pj?=
 =?utf-8?B?UFRkRllpT0g2ZE8xZU50bVpPc2JKZ0JiNU1URHVxYTJPb2VEOFRTa0pnd21i?=
 =?utf-8?B?cHh1VnVOVmxXQmlnZUlhb2lpQk9EWlJFanBOOTA5dXVhSGk2bnppNlE1UHdV?=
 =?utf-8?B?dHI2aWo3ZVF1OUlNbnJHYnRlSnRQWlAwOFRvaG1kdG9VVmlLVG1lZTR1ZXpj?=
 =?utf-8?B?Q1hUcHBIemRCU3FLYjdacTNwNlpzSXBRbHJpdkY3SVIva2k2YUhYYzh4UUxR?=
 =?utf-8?B?a0MzTzhMcVJkbFFteVYxOXpxYmdkUk1tV3Q0emkvS0NwNStaczF4NG1Vc05Y?=
 =?utf-8?B?SWFEVVpQbFBRVG1iMnIyeGp4ZkQzaVJjRW1HL2NucUlPb29uUEp4RTZhR0Qy?=
 =?utf-8?B?SjJ2TVF6dmkreDR1WXBMOVozYVl1OVpqTU03WDhJNzREcXUzSFo0QzNVeG5N?=
 =?utf-8?B?TDZQQm5qUkRpaVM2L3lNa0tOZ0RFR2tDcmRFY2hFWVZFVkNQRDBWZ29qelVh?=
 =?utf-8?B?dFpoTVF0eVFOZWQ5eHAraDM0WG53d1EwdTc4cUwyeVFUTXhXZytmNEdYUWRv?=
 =?utf-8?B?TnVjSVVKYjgzaGMvK2hGQjBnOHZrVFdVM080WFBwVDZ0N1RtS0hyRi9oUy9P?=
 =?utf-8?B?VXUxQVJvWjlETytEVlB5OFZuMit2TEpTanBxZ1dBS3lNTTdmSE5GRm8vSmJO?=
 =?utf-8?B?cTRTTzI5NWMvVEhJbzFIdUM1a2xqY0pNTlFjYmw4eVVDNlJVOU03VmxSNEFC?=
 =?utf-8?B?TTY2SVFSdCtXclhuQkdxUDArODJrVXdra2pDN3FlaThaRFJ5dkRqOHg2TlBl?=
 =?utf-8?B?SldZNWFGc0l2ZFpHQlhrMnZzd2dtaWMwSStRRVh2TW41RTQ1MnQ2UUYvMTZU?=
 =?utf-8?B?N2hUUW5RbEl0blZkVC9sZmZnMUtoSXVrcnhRZTI4TjZMaGltbS8wUnlTVUZS?=
 =?utf-8?B?OE90NzVLV3U1Z1ZOREJicnpDekovYXlpTzlYcWpVZGNISlZRSGhtZTZkMCts?=
 =?utf-8?B?V2FIZWZVNDhnODJpZDhwU29YMTRLTmt4SStwbGVxV3JRL3RkVGF5eExLd1lD?=
 =?utf-8?B?SnZTcXp0aXY3Y3ltTTlINkRPbWNwb3VuQkZYWXFoWEt6MmU5UG56U0dmSjRO?=
 =?utf-8?B?NzVFZGlWckZtbUdUTUMrVGJiRFJrZGJpaVRLbDNndmJkWTlFTDNhOCtFUk16?=
 =?utf-8?B?aVpwZ2VYcXQwbXpndEp2OXpMYW5BTE81a3ZwamEraWNIYUJ1eGhaTkR3QlE0?=
 =?utf-8?B?ZXpuSjc0WlRoSlorTlpXc3RFSG1FMzJWRVhSUFVsb0VqeU4wbE1ObnMrUEpC?=
 =?utf-8?B?NlJVYjc0ZkJsZVNEZ3VGTFJaeThFY3gvamhTZWNYU1ViYktEL005NVNLL0kz?=
 =?utf-8?B?QVRKZm1IOFk3U0FWNFpMV1R5M0k3WFJsdUZ6NnlXdlFzTGZRaVkwQnZIbSs3?=
 =?utf-8?B?VFpSOURDMzFUQ1BmVU0rcktMcUlpQXNUWUlMSTEvVVYyV29VbURlanB6aFhV?=
 =?utf-8?B?SEhTM1BsdDdMQTFuOWRubDc5cGRWOFprV0k4Sml0dUptOW8xcWtMRDBqQi9P?=
 =?utf-8?B?Um1kQ2V6dkNTYUlDbHJhaDY3ZTFzRWpUQi9xQkhZODlMSFdKNzQ1TXJpYW9L?=
 =?utf-8?B?WGRUZFhGelpHYkpGenJxa1ozUkFIQ0g0U3Vwak1JTG1jQktVQzlKU3FMZUt5?=
 =?utf-8?B?V2dZeWtMaDlLbmIweFViMUJOK3BmRFcwUitFQzN2OW9remw3MFBIQ3BmbStT?=
 =?utf-8?B?cXFIUDBQWkJmc1g0Sm1zT1dSdlVaQmlJL3dobUd4K0tDZVg5ZTVCdGM5Slh3?=
 =?utf-8?B?T0h6WGYxcnkvbG5yOEg3UkhxRTVCVlVjUjc0cy9ha1UzR3hDV0U2KzlRSzhj?=
 =?utf-8?B?T2s3a253SmZFVUU4eVJSbkYxamRkS2hIMkRCVHIxSGdLcGV0clhybjE1WDhG?=
 =?utf-8?B?TFJBaWZCbWdxVk5Ydm9hZmJlR3NNQkNYaGVKVDAxU1VaT2dUR0pPWWpCL1l2?=
 =?utf-8?B?alc4SnoxN3Q0bi9CcXpaV1pHeWxUaEhMck02TElkdEhuNVNYcDk3Rmo0VTRW?=
 =?utf-8?B?UlRROWVJdkNmNDBTeHhEU1ZyOW01blpGc3dBOXdRSVdPMW1CVEcyTWZpNzJV?=
 =?utf-8?B?cUdFSVBVeHo3U2YzUktOem9pRFVnaWhLc0U0TGVqY0ZzdTFCOEtKWk5vTHhR?=
 =?utf-8?B?WHZ3Zzd4aVIyb0RNbXdlTDBXNXpvQnlhWnVXVUd2Nkd4U1c3dTJTdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329ad1a0-0ec7-4156-928d-08da1c315e28
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 03:05:58.3476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mNWIxkEVeIIHsjsJsvSQ6C2LZDA+mfdFnoOPjVXA7pOgMn/qplgn+IC8eRtRyJwx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1840
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgU3RhbmxleSwNCg0KVGhlIGZsYWcgaXMgc2V0
IGJ5IFJBUyBibG9jayBwb2lzb24gaXJxIGhhbmRsZXIsIHN1Y2ggYXMgdmNuL2pwZWcgcG9pc29u
IGlycSBoYW5kbGVyLiBJdCdzIG5vdCBjb25maWd1cmVkIGluIFJBUyBpbml0Lg0KDQpSZWdhcmRz
LA0KVGFvDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWWFuZywgU3Rh
bmxleSA8U3RhbmxleS5ZYW5nQGFtZC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgQXByaWwgMTEsIDIw
MjIgMTA6MTIgUE0NCj4gVG86IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPjsgYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IExhemFyLA0KPiBMaWpvIDxMaWpvLkxhemFyQGFtZC5j
b20+OyBaaXlhLCBNb2hhbW1hZCB6YWZhcg0KPiA8TW9oYW1tYWR6YWZhci5aaXlhQGFtZC5jb20+
OyBaaGFuZywgSGF3a2luZw0KPiA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgQ2hhaSwgVGhvbWFz
IDxZaVBlbmcuQ2hhaUBhbWQuY29tPg0KPiBTdWJqZWN0OiDlm57lpI06IFtQQVRDSCAxLzNdIGRy
bS9hbWRncHU6IGFkZCBwb2lzb24gY29uc3VtcHRpb24gZmxhZyBmb3IgUkFTDQo+IElIDQo+IA0K
PiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5XQ0KPiANCj4gSGkgVGFvLA0KPiANCj4gQWNjb3JkaW5n
IHRvIHRoZSBzZXJpZXMgcGF0Y2hlcywgSSBoYXZlIG9uZSBxdWVzdGlvbiwgaXMgdGhlIHJhc19p
aF9mbGFnIHNldA0KPiBhY2NvcmRpbmcgdG8gcG9pc29uIG1vZGUgY29uZmlndXJhdGlvbiwgaWYg
eWVzLCBkcml2ZXIgd2lsbCBoYW5kbGUgcG9pc29uIG9uY2UNCj4gZ2V0IGVjY19pcnEgaW50ZXJy
dXB0LCBidXQgYXQgdGhpcyBtb21lbnQgdGhlcmUgbWF5IG5vIGFwcCB0byBjb25zdW1lcyBpdCwg
dGhpcw0KPiBzZWVtcyBjb25mbGljdCB0aGUgcG9pc29uIGNvbnN1bXB0aW9uIGRlZmluaXRpb24u
DQo+IA0KPiBSZWdhcmRzLA0KPiBTdGFubGV5DQo+ID4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K
PiA+IOWPkeS7tuS6ujogWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+DQo+ID4g5Y+R6YCB
5pe26Ze0OiBNb25kYXksIEFwcmlsIDExLCAyMDIyIDc6MDggUE0NCj4gPiDmlLbku7bkuro6IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQu
Y29tPjsNCj4gPiBaaXlhLCBNb2hhbW1hZCB6YWZhciA8TW9oYW1tYWR6YWZhci5aaXlhQGFtZC5j
b20+OyBaaGFuZywgSGF3a2luZw0KPiA+IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBZYW5nLCBT
dGFubGV5IDxTdGFubGV5LllhbmdAYW1kLmNvbT47IENoYWksDQo+ID4gVGhvbWFzIDxZaVBlbmcu
Q2hhaUBhbWQuY29tPg0KPiA+IOaKhOmAgTogWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+
DQo+ID4g5Li76aKYOiBbUEFUQ0ggMS8zXSBkcm0vYW1kZ3B1OiBhZGQgcG9pc29uIGNvbnN1bXB0
aW9uIGZsYWcgZm9yIFJBUyBJSA0KPiA+DQo+ID4gU28gd2UgY2FuIGRpc3Rpbmd1aXNoIFJBUyBw
b2lzb24gY29uc3VtcHRpb24gaW50ZXJydXB0IGZyb20gVUUgaW50ZXJydXB0Lg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmggfCA3ICsrKysrKysNCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuaA0KPiA+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oDQo+ID4gaW5kZXggNjA2ZGY4ODY5Yjg5Li4z
ODBmNGMzMDIwYzcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Jhcy5oDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Jhcy5oDQo+ID4gQEAgLTMxNCw2ICszMTQsMTEgQEAgZW51bSBhbWRncHVfcmFzX3JldCB7DQo+
ID4gICAgICAgQU1ER1BVX1JBU19QVCwNCj4gPiAgfTsNCj4gPg0KPiA+ICtlbnVtIGFtZGdwdV9y
YXNfaWhfZmxhZyB7DQo+ID4gKyAgICAgQU1ER1BVX1JBU19JSF9QT0lTT05fQ09OU1VNUFRJT04g
PSAwLA0KPiA+ICsgICAgIEFNREdQVV9SQVNfSUhfTEFTVCwNCj4gPiArfTsNCj4gPiArDQo+ID4g
IHN0cnVjdCByYXNfY29tbW9uX2lmIHsNCj4gPiAgICAgICBlbnVtIGFtZGdwdV9yYXNfYmxvY2sg
YmxvY2s7DQo+ID4gICAgICAgZW51bSBhbWRncHVfcmFzX2Vycm9yX3R5cGUgdHlwZTsgQEAgLTQx
OSw2ICs0MjQsOCBAQCBzdHJ1Y3QNCj4gPiByYXNfaWhfZGF0YSB7DQo+ID4gICAgICAgdW5zaWdu
ZWQgaW50IGFsaWduZWRfZWxlbWVudF9zaXplOw0KPiA+ICAgICAgIHVuc2lnbmVkIGludCBycHRy
Ow0KPiA+ICAgICAgIHVuc2lnbmVkIGludCB3cHRyOw0KPiA+ICsgICAgIC8qIGludGVycnVwdCB0
eXBlIGZsYWcgKi8NCj4gPiArICAgICB1bnNpZ25lZCBpbnQgZmxhZzsNCj4gPiAgfTsNCj4gPg0K
PiA+ICBzdHJ1Y3QgcmFzX21hbmFnZXIgew0KPiA+IC0tDQo+ID4gMi4zNS4xDQo+IA0K
