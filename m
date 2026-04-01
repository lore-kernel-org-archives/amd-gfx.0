Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8ECD35144
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 06:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D3C710E240;
	Wed,  1 Apr 2026 06:59:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zhzYxSFt";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013024.outbound.protection.outlook.com
 [40.93.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BAFA10E240
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 06:59:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3Ke8pGwfYrbBJ4pgaAUqTuopprGYcTzPwGv2vhXQLcOn+bhZdR6O18jMXt3LOrp0llK9bnyVeZEVeZBrznfC2yAtkXtjrklQN6OY/e2LB8MqpyU8qmdYVtHnjje8ak9pwW9UQscx5/8uUf/Qi9+/IFxrmGrZrjzcfiMtbYRScEw7xi79WyygMJ68bB6jMK4sx7+6W41gBJT/LGD9M9tUu+oRq+K+W74H1gTlze9RqM2DEsM7d6wbVDb2rtF9pgmphEp/h2bx3nh2bUWrGobTsoBQQAGqIu0pMxP1QVn6E34POzJ/oGvX5fahsUJK6NpLry55oaY7xa4ik3yXEluGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bP0JmKBtcCnpjFXbJQjCrsWR0u+ScikNFXaBAhB3wo=;
 b=Ed7cIMWxBU1UmuomFcBOJFFNP7fGuB4YYEWPWwTV6dT2RREaVLXsSdNj2XkDvdABHFXwEEsOnM0Cr4/2A2rJI1AFDPRd+ECEcbUua7vMrzL9zUlX5hGjUPUV8DiTCg7ctNPP5jVSokMXkZOUGiWHLql0YUk04OW4NkINNyCdqXe6IutiScDo5DuVx+V38DWqUwdEb0n6St1tuYZVF7fVA4788wjZNMPNaLPTo5qVMt+sTKkL58aHopdM6CWb5Q/MH9ErDgupzp3NEjKE1hWP8joYOLjwElNPQ6W+gyqPbvSMx0xB3TAJtNmbXNZU4lyi8DZcRRWySTUXOj0R788eXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bP0JmKBtcCnpjFXbJQjCrsWR0u+ScikNFXaBAhB3wo=;
 b=zhzYxSFtBhDbXFItM5Y5hcDzMIgoIjPADGvgQ8SE5RM6Xhe5WSyNdSKETOmJvC/qa0xO+s7KN0gadORHNfv//yqN4w74VLnwBOubQXFFERr+QHl09181MgeknF/Mc5yxNBi+dqwHUH8eoDnYEvR34nAhGH8PqShh5sTtFEsLUEc=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS7PR12MB6120.namprd12.prod.outlook.com (2603:10b6:8:98::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Wed, 1 Apr 2026 06:59:29 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 06:59:28 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu/sdma_v6.0: enable WPTR polling for UMQ
 SDMA MQD
Thread-Topic: [PATCH 1/2] drm/amdgpu/sdma_v6.0: enable WPTR polling for UMQ
 SDMA MQD
Thread-Index: AQHcwPRM42s84xt1YEmOxurgBKDob7XIiR4AgAE+6aA=
Date: Wed, 1 Apr 2026 06:59:28 +0000
Message-ID: <DM4PR12MB5152D39FF0D9571E3D4B88F9E350A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260331095346.1331511-1-Jesse.Zhang@amd.com>
 <4bb97e2d-b654-42fe-b680-03989960c2e0@amd.com>
In-Reply-To: <4bb97e2d-b654-42fe-b680-03989960c2e0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-01T06:58:39.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DS7PR12MB6120:EE_
x-ms-office365-filtering-correlation-id: ea5f8954-40c7-4e10-7228-08de8fbc37ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: AQm258Nbf6SNw7EgzJNjxZN+cmKOjzaFc4uY4p89VNhcTEoSFROye50LRTGK5CsN8yzlRF2ZVGQ31LGT9DTpOgxRtm+lqOAwSASsECrXDrUZqwx16SbG1sCNcrCMM7QeMt/UkziXlzs3MR/lTG15eZF7Vob0I2iVy9L2Fq/JLbDKgW1H569IJ5D6a/vQNEo/75e22rKmZ+Nv4B4q879ownqaRXvg3L7dPc7ZDA+vRbeJRfzBdhafzUCISlQDSTbUVA2xoiz83JsaU5LZuxTQ/KDWvdASzRuTyj+2xQZrWLOeQJh66I4RA5qeutr8enN7K4g+BjF0o0OnoevfgsQAeq6aK6iwp9SH2Oc6KhzzAV3yXZILlvf2jW5Rch+N//nAGMsr7pu8sYHEaMLYJaOBcqZg9GZ7ut08qgkzqLxwOOCFfaEeI/BJqmdXznV9T3ShBiy5QxC9s7hOuWNeRLzzJfY5zFD0r5H6t5PnX9K47LrjVubVDy6t+/DgJFiMNNZRVgs3B+qT8WCx/Vs5SUySIEbOMmoFtKadgq/ZQ+1rqtJClAvAzt+4dvfNNjjbps3SnvXyls8OkMq3ZCqcMQ4v5UwOLJX/K2Edsd+KKQVjDS+wpfU4fJbsXGOCbRRKDF5ZlP3UvQBD0Sf3DbA8WwStDfBh6nG/LeVOROgFUSUosU2IMBrzOYgeBWgYohkojpaXnO2O6C4eTj1aeFDbA4CcYiOiQs3EyaXZb+pdLTcSfyD8LFgC3tzCENCedXaD9I3tMV6YHplzR7M3TkXQ2Qxx3lxHo2TSeZU2th08AZtDxDA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akxzZHZkTjB6Z29IcCt3OWc2YTZBM0xsbTF1MEpMeGF4WGh2R0FNSXhTUmIy?=
 =?utf-8?B?NzlHZnV2bFJueGgrSW92dGQrUFU5YWVSS1g2VzRLWTlWMUJ0NzlNT3dPcFVE?=
 =?utf-8?B?QmdCdFF3T2hQemFpWnFVTVRib1JxZi82ZlFlWG8vOEZ6dDFCcjNwRjZtRXFY?=
 =?utf-8?B?SUpsR0lWSFRvejJ5b0FiRTJLVHY4dEVRTTl1UmY3cTFwVDNnNklVSi8wdkVo?=
 =?utf-8?B?ZUZtd2RXRUNMN1pvYkZjMXhYYzZnWHVGWkNIczJSOEtZY1A0NnpoVU90QTFR?=
 =?utf-8?B?M0hVaW80SjRSVmxnWkRBUSsySjRYYk1FN29CQzgra3ZFeU9BWmR6a2EwcVN2?=
 =?utf-8?B?VlhGdHU2OHdORXJxaUZ0Nm10Q0ltQ0JsckNFNFhQb2pBbElRbDJRVjAyWndk?=
 =?utf-8?B?ZU9GRERZZTJaZ1lLc2xHQlhMbmxDeWwwY2lIT2MvVHNjdUJXV0ZNV1VkYThr?=
 =?utf-8?B?cnoyYWt0bk91cEdESmZZS0dlaWJyRGs4d3BJTU1ReXFQa3ErWUtscnExWCt6?=
 =?utf-8?B?TDEveDJPelY0WElodUZXSWUvcXUwWUtGbTdMQ3c0d3RKWW55bEJ0b1NwbUNZ?=
 =?utf-8?B?Q0ZlZTJsaFJKRnBSalVtVVJ6TkZuTGVjbWJmLzZsSndCU0lLampLb2gxd2pv?=
 =?utf-8?B?TFFrSE9rSVRHemZSWDhrVlZUbVBGcXNzdzllemcwVGxWSUZQeE5rUnN2bWdM?=
 =?utf-8?B?RE84ME1ZWVBqQnF1Ukc5enh5Z2RSTEsxcFZreE96aXVMMXNhb2pNRncxQlRZ?=
 =?utf-8?B?RDJrNnZrWjZRTTFnbDJrelloS2VGeHVoYm91QzljaWRrQUZkOWRYNGFpVmhS?=
 =?utf-8?B?VjhxVHhUV1k3VWtMQk9kdXFFN1JpVndvUG16N1RYYzRsNVBMKzJaOFIyNmRC?=
 =?utf-8?B?SE9QL2JqRnBYd0JSY3lPRTBzczRzd2FYb2gwVXJCTzZzZi9NYVVMemFlWUxO?=
 =?utf-8?B?Smt4WDg4R1doZTBRNUxCM2txVXdqeDB4K25peXV3STg4dEZBbXBVVzBsdE9k?=
 =?utf-8?B?WExPUmhsYmgrUmZSMlVUME9rZ0FnQjdIT010bUJrcWlRYTBOZ3Q0Mk43K3h4?=
 =?utf-8?B?TjRRWWV1UVNuK0o4K2RaS24wOHlGb2g5Z1lvQXRYNDVhQnBzdWdYRHhFM1pt?=
 =?utf-8?B?YVc1MnRUWWR4U3k1SUwzRFVtQlg0Zk9ETEdHOG1SdGNpSUR1NnZ4bWxkVU9s?=
 =?utf-8?B?TXlvMlN4T0NDZElYNG45ZnI5MUZmUnZXM2ovaDMyUzZ0K2dQSFRaNmF2OGhV?=
 =?utf-8?B?aUdsbVpGR3Z2ZmQ1Q1kvMnFUb1Z1QnRmbDhzR0xSLzRHSWhBSjNvMFFSWjk3?=
 =?utf-8?B?U3l3L2hodkU4NzZpa2gyL0dPVlBkUTZwZVREN3dPSnhNenpsd00xQ1Nic3B0?=
 =?utf-8?B?NGxkUnFUL2RhM0UveHEzOU10aGNJSTFLWEFBYnVTUzZ0VWFLNm94ZEJWS25r?=
 =?utf-8?B?TnQ0TTJaVlh2bTBTRVA4OEVPWHRYcjBzTDBwa3cwSG44RllZeTFJSkZMSGkr?=
 =?utf-8?B?TFRIaWl3V0tQbHdRK3pyTS81OUE0UTBKRzhvb29TeGJiN0c2R2Y5b3ExZUxU?=
 =?utf-8?B?ZGZYK2hSaEJMTUdOUlR0UVJMS1FmKyt4Mkx0cERRWlV1aVJvMFc3dG12YUov?=
 =?utf-8?B?Rk00bEJsR0N5TUt6SXJmSWVqa2dEeGhyejVoWDlxL1RmR3ZVMDcwYkZkWEJl?=
 =?utf-8?B?YnlIdTFMb29qT01NUTYxWGhIc1psZG5YQnpXK2g2S1Q5WTdma1gwUXNYREpw?=
 =?utf-8?B?ZWtnUzk4VkN3WkFtVngwN3FMa3ZQL3NQQzllUXMrdjllZHA1TnRzRzhXQnZ5?=
 =?utf-8?B?a2psbzZOMm5RaWc4K2RrcFJ6WXVxaTQ0T1RXOVFUNVJDQ2NYTGlYQmdhOFJU?=
 =?utf-8?B?V0p5UkNoSmZIaHk0ZkxSYk1iRTB0TENBb01Qbk5IcGNUWENadnhUdW4rTEtX?=
 =?utf-8?B?ckM5WEFzaGFKS2ZrbjI0YklaME5ETStEVVlOcE8wR0lwNFdiVVNhTFpsL3Jq?=
 =?utf-8?B?RWRNbWpDMks4Q1pOelJac0FPeGFsRi93d1prSHZXZHUxdmtsNTh0QjdIYXJ4?=
 =?utf-8?B?S3RMdG93TEszdEg4b29peEN0bllQVmwwK1VEdUdIMFJPM3hXNVd6RDhCTGVQ?=
 =?utf-8?B?Vi81bmNrYTkvR0tCQmZ6NWdUVXA4V05HR2h5VHdveko0NnlFS0N3elFVejZT?=
 =?utf-8?B?K0hmTXFPTGVyU1VXUmo2N2lHWGlidXByVnk2aDgvNHRBNzBvUjQ1VjZQbjRo?=
 =?utf-8?B?Y3dzQWpjL2ZRcFRZdlZsVU5JOWc0RmprcGNOUVAzTnlIUEpuamtMT3ovV0xj?=
 =?utf-8?Q?EJTw+HJL6gBw7zJu1m?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5f8954-40c7-4e10-7228-08de8fbc37ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 06:59:28.8005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5t0EMWP2xDu3UcOEz4LmYfzgcazBqZHSu76XgM2XhQcl2okUxNZMWQ2fD6+kdtcDhEdpKBK+PLH1HlncPoY3cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6120
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlh
biA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAzMSwg
MjAyNiA3OjU3IFBNDQo+IFRvOiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNv
bT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8y
XSBkcm0vYW1kZ3B1L3NkbWFfdjYuMDogZW5hYmxlIFdQVFIgcG9sbGluZyBmb3IgVU1RDQo+IFNE
TUEgTVFEDQo+DQo+DQo+DQo+IE9uIDMvMzEvMjYgMTE6NTMsIEplc3NlIFpoYW5nIHdyb3RlOg0K
PiA+IFVNUSBTRE1BIHF1ZXVlcyBjYW4gc3RhbGwgd2hlbiBvbmx5IEYzMi9NQ1UgV1BUUiBwb2xs
aW5nIGlzIGVuYWJsZWQgaW4gdGhlDQo+IE1RRCBSQiBjb250cm9sIGNvbmZpZ3VyYXRpb24uDQo+
ID4gRW5hYmxlIFdQVFJfUE9MTF9FTkFCTEUgaW4gc2RtYV92Nl8wIGluaXQgc28gaGFyZHdhcmUg
Y2FuIHJlbGlhYmx5DQo+ID4gb2JzZXJ2ZSBXQiB3cml0ZSBwb2ludGVyIHVwZGF0ZXMgd2hpbGUg
a2VlcGluZyB0aGUgZXhpc3RpbmcgZG9vcmJlbGwgcGF0aA0KPiBlbmFibGVkLg0KPiA+DQo+ID4g
VGhpcyBmaXhlcyBVTVEgU0RNQSBzdWJtaXNzaW9ucyB0aW1pbmcgb3V0IG9uIHN1YnNlcXVlbnQg
cGFja2V0cyB3aGVyZQ0KPiB3cHRyL3JwdHIgbm8gbG9uZ2VyIGFkdmFuY2UuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBKZXNzZSBaaGFuZyA8amVzc2UuemhhbmdAYW1kLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92Nl8wLmMgfCAxICsNCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92Nl8wLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NkbWFfdjZfMC5jDQo+ID4gaW5kZXggYjAwNTY3MmYyZjk2Li42MjI1MTg0
ODNjNmUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92
Nl8wLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y2XzAuYw0K
PiA+IEBAIC04NjMsNiArODYzLDcgQEAgc3RhdGljIGludCBzZG1hX3Y2XzBfbXFkX2luaXQoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UNCj4gKmFkZXYsIHZvaWQgKm1xZCwNCj4gPiAgICAgICAgICAgICBv
cmRlcl9iYXNlXzIocHJvcC0+cXVldWVfc2l6ZSAvIDQpIDw8DQo+IFNETUEwX1FVRVVFMF9SQl9D
TlRMX19SQl9TSVpFX19TSElGVCB8DQo+ID4gICAgICAgICAgICAgMSA8PA0KPiBTRE1BMF9RVUVV
RTBfUkJfQ05UTF9fUlBUUl9XUklURUJBQ0tfRU5BQkxFX19TSElGVCB8DQo+ID4gICAgICAgICAg
ICAgNCA8PA0KPiBTRE1BMF9RVUVVRTBfUkJfQ05UTF9fUlBUUl9XUklURUJBQ0tfVElNRVJfX1NI
SUZUIHwNCj4gPiArICAgICAgICAgICAxIDw8DQo+IFNETUEwX1FVRVVFMF9SQl9DTlRMX19XUFRS
X1BPTExfRU5BQkxFX19TSElGVCB8DQo+DQo+IFRoaXMgZW5hYmxlZCBXUFRSIHBvbGxpbmcgZm9y
IHRoZSBrZXJuZWwgcXVldWUgd2hpY2ggaXMgY2xlYXJseSBub3QgY29ycmVjdC4NClRoaXMgcGF0
Y2ggd2lsbCBub3QgYWZmZWN0IHRoZSBTRE1BIGtlcm5lbCBxdWV1ZS4NCnRoZSBrZXJuZWwgcmlu
ZyBwYXRoIGNvbmZpZ3VyZXMgU0RNQSBxdWV1ZXMgdmlhIHJlZ2lzdGVyIHdyaXRlczsgdGhlIFVN
USBwYXRoIHN1cHBsaWVzIGEgZmlybXdhcmUtZmFjaW5nIE1RRCBidWlsdCBieSBzZG1hXypfbXFk
X2luaXQoKS4NCg0KVGhhbmtzDQpKZXNzZQ0KPg0KPiBNeSBlZHVjYXRlZCBndWVzcyBpcyB0aGF0
IHRoaXMgb25seSB3b3JrcyBhcm91bmQgdGhlIHByb2JsZW0gYmVjYXVzZSBpdCBrZWVwcyB0aGUN
Cj4gU0RNQSBhd2FrZS4NCj4NCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFuLg0KPg0KPiA+ICAgICAg
ICAgICAgIDEgPDwNCj4gU0RNQTBfUVVFVUUwX1JCX0NOVExfX0YzMl9XUFRSX1BPTExfRU5BQkxF
X19TSElGVDsNCj4gPg0KPiA+ICAgICBtLT5zZG1heF9ybGN4X3JiX2Jhc2UgPSBsb3dlcl8zMl9i
aXRzKHByb3AtPmhxZF9iYXNlX2dwdV9hZGRyID4+IDgpOw0KDQo=
