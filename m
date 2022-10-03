Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101B0C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Oct 2022 09:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1809210E2A2;
	Mon,  3 Oct 2022 09:33:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2428810E2A2
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Oct 2022 09:33:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M67myjZMjHVVpMjti/fuxpdMpJa1Fovmd32RHbGjdBQTNbK+HL2/ck24gi9eiKBYSQNfvn+YKCN/db9JX0QcY0IjqmwuyA8OT+l93lZAlahCvqKU5vZUqAhJrA+M7fKGNea81CSrOHOD2PY4g2TPjlNTwzJpyP7oYByVqRQV8VGiFEItZXDiGIMeNGmCIu3SO4+FqAsBP2h4GnBsf6Q9CyFkkDCF65yKkmIIIGraBpbvAS+tQhZ7X85NRUdFzQoe7L8mTeVgNg1i/xfSqtTgw7FqJOLRp9d70qBKUnFgM9rJ7VjgRAOXBUbNDkgSNzoL3NVB4EXfyuUscX6/fc3kSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4qVkWrVotateK/T8LMQFHsBSq7qZcKMGHB5ArMl23w=;
 b=Sou3ESH3KBQDN/tiHAi+U1zCX9McCxOkBO3gwD8jZwaVVx2uA8C+mFzT6/wFwIJu74EmQYXkBNi0lpkvhqnB1MfOCkGVCmQXqLfr7tt0h3vzy16Gg4gq70AQtksqoB5xKzhyUhVODtu5zPy8irgRuCvNJH7iedk5+EKyE50m7Pu0XrV65l9/uzeMZqEwwzanl6e1bKamg2sp81DcXkmqTVZUsj/IDMyOX71HWkLpnh2c/eX/e2EvGy1mlAC58enL/wyT7pyUeBKdi3//ubFSxoBnLvI2H9rVAtcwmzum7wdnWHv88+NYbXkZcWjOMFkv3zcB4JxUy/H+KHJxyRCmKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4qVkWrVotateK/T8LMQFHsBSq7qZcKMGHB5ArMl23w=;
 b=Dr8wEBMnhNd893S3ulboG/J8z6zBPXWOAomz7i/Oq9eoL7GsjrvjlE56SaBDRRBfL9NU7NxP0AVJhIY38Ggp17Bq9D3QxU4B21LQRjPVbxe6W4lT7AnXiXFnovIo4w+RpRC5r8d7GF1JrP3A6Hk74YopoFxa7NKXrG5LNn8Y1v8=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by MW4PR12MB6707.namprd12.prod.outlook.com (2603:10b6:303:1ee::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 09:33:30 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::83b:c645:e27b:b656]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::83b:c645:e27b:b656%3]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 09:33:30 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdkfd: correct RB_SIZE in SDMA0_QUEUE0_RB_CNTL
Thread-Topic: [PATCH 1/2] drm/amdkfd: correct RB_SIZE in SDMA0_QUEUE0_RB_CNTL
Thread-Index: AQHY1JQ9J2qQS8NJ8E+xmv1MYox3E634D/AAgARckwA=
Date: Mon, 3 Oct 2022 09:33:30 +0000
Message-ID: <CY5PR12MB6369008FE8266B4AE6C07B09C15B9@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20220930061634.1531705-1-yifan1.zhang@amd.com>
 <94456547-cc0d-31f8-602f-3ddeb2627149@amd.com>
In-Reply-To: <94456547-cc0d-31f8-602f-3ddeb2627149@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-03T09:33:27Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=be7789cb-2de8-4e86-b282-00075e5bad4b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-03T09:33:27Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 78c825eb-053b-4771-b22f-fba8e86ff71b
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|MW4PR12MB6707:EE_
x-ms-office365-filtering-correlation-id: cd331823-8f9a-46ec-971f-08daa5225569
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ptbE9JSBltOz2PlyOEbpwit9hoGyw3in76YkpagvBzp8qv9widuALXlWNevc7sgu96ggUdBX/uyEVFrW6ifhIflSUGsxOv5EtLJa2mW2XgBsvk2+N7/BZ7+E5e7c/quTMBxvv33neNrRAMsXjYooNMko2qXH1Ja5FoNf6vk1N5T2o/2jO/z8WCFR6tx7UoltYN2d4AoglHX72ZwUrmB1GHE56AWJVnDkCAZXb6Z/8I7+qtRQz3LRwYDiin2NFN3fpaH5C4/bw+b821AuXIP+w8dNnOq86OzlZSqlqA9TyKFj940hTxp9RAPpEm12EawwuiV/ssck9fJ8gYqEHgvQZwy/gno7K/oFdoBvWOXGbMdf5edPP8gfXaS4PTYSG6ZphsWPwnL3lnG3JzfQVZtEpYazUXS0LeeDDkgvJPvt+H8GX730IqZz267OlDUJ6GJAkcH6oCgOykpu79+WpHXm5jPRjHdsIGVkLWnv/DkLfdD+5ZF3cr4dp/JsTQZufCGjzAApUHH5d7Z0XNLq1VJWqBOzt/3+uXb2XQ86/f3svbut8H5TV23s4ppWnBz6+Vtn/bVrK05sCLh1tZK4HCbPZK1EmpDNeGvhsTUp4sMZK4RxXZZyocytVzmE4DZBJCZkiSTKeQt0GGG6EILhDbgePY2jTWfAmp4/9iJH1WZTEo9huHmfGIFs+0Ry7zGHqfXE8HTGVvfiAfNES5p54Wp6A33bCmegF5ofNURuhUv1BHNGUqwtiAjVne8aHEUxX8YTxz0Gu11p6XpbGp8HCm2Sbw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199015)(54906003)(110136005)(86362001)(478600001)(83380400001)(71200400001)(52536014)(5660300002)(41300700001)(8936002)(316002)(55016003)(33656002)(76116006)(64756008)(4326008)(66946007)(66556008)(66476007)(66446008)(8676002)(122000001)(186003)(38100700002)(9686003)(53546011)(7696005)(6506007)(38070700005)(26005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzQwcEh0OXRNSW9XcERwN0xGSG1Kd0ExSC9Vb0IyQjVoZysyNEEzUnVEOVNp?=
 =?utf-8?B?ajl4NTJ6NmN3VTVRcVFOTXFSYVp2UDV0UkFXZzlsU1dqSStYd0ZGK2wxME43?=
 =?utf-8?B?M2Rvb2hOc0d1dURQK0c0d3I1dWRVRW1DdUVyeHlaTFVzKys4d1BKbVYwbjgz?=
 =?utf-8?B?NCtRYUJ4M3k2OFY2a1N1NDBpbnY5NHZCQk1mOE9WSm1zZnJUOHVkMXlCUVQ2?=
 =?utf-8?B?VjBjNFdId0hmY2ZKWlB3UlBLTnl1R0ppNFRnUDdUUEMrc3AzSS9nekdmMUUx?=
 =?utf-8?B?dHo3aGVWazFvL2I3TE1RbnZkWmJlWlB3c1piKyt3blBuaDBsYlFoMHUyczc1?=
 =?utf-8?B?Nk1SYzdGMUVWVVlQQWRiK2lXanJXYXFmdW1YQm9UeXZiNm1UU0ViSUxSNDVQ?=
 =?utf-8?B?bEJXQU9xY3Ntd0NFOHZIaFMyc2ttd2lzQi9ldnJPNVdFSTVqZndpZ2hvT25F?=
 =?utf-8?B?ZHZWMEVyWDB0Y044R24xNHlnZmxHL2RhbnYwcFA1UEpDa2NQUm9hbEJlWFVB?=
 =?utf-8?B?TkQ0YWtBdCtnMlc1YkEwT3hPYnFad0ZZSTYxZXFTa1BxRm85VGp3Q21pVWVN?=
 =?utf-8?B?TlYzWUJQWk5wazlUNThyd0p6SEVOZE43bmNERWMydTJnT2VtVW44YUV6K3E0?=
 =?utf-8?B?dkMrb09xVGZrVDQrcHJsYmJ3U2ZLNVNFYStOTy9QZGJKVk1RMFJRaGFiOXA5?=
 =?utf-8?B?bEZZZitiM2RTZW93YTBONWkxcWdBVUx5M1EwQzVoNURmMWZtNnBFNWlvclVn?=
 =?utf-8?B?eldMQzh0U2VrK1NId0NlclkvZldhbGlrZ1NabWJndlkzNExaTEc4SGNINlY3?=
 =?utf-8?B?NGg5TTFmYVVpYUhob094Y2NQc3V2aklyMVJYaVAxYk05ZXdsTWI2bjZNMVpY?=
 =?utf-8?B?MjhhQnBjMVZZaTROWXZpYTZQUWZoajZsaUJRYm1aVUJDVGxXV2ZQcWlJUGl4?=
 =?utf-8?B?Qy9aYW5mTFgwQmdvVzQrZlo2TjNGYytKem93akVGZTdFQ2Q2aEZ6SW1XbVcz?=
 =?utf-8?B?dXY1cnVUK1Z4QXVzZ1Fnb3hNYUlabmNaVHNmSGJHdjk2MGhOdTQ5a3Uwbm1R?=
 =?utf-8?B?a09aSWtWclFJTnBzQ0o5SnkwSER6aytHa3RFZFVHSnJnUWM0QVVhZkpjc0h3?=
 =?utf-8?B?UGlzZW5HU2lRanhUdUFWM0lnOGdZOXdkRUttZ0JSVzE1eC9iR0dmK0djSGY0?=
 =?utf-8?B?QkhRa0p2bFFkaExJbFVyU1A1eE5pSHU0VXJyYXArcGpGT3VFOWl0bXRlbmRT?=
 =?utf-8?B?RHVjaVFCLzJobU9xL0FLcWw4Qm1RcVY1d0pHaVBNbW9ZbXQra2NVYTlJNTNr?=
 =?utf-8?B?NkI0MDNtMmU5NUM3dk5oWnd4UHRkZmJMMmo1dmprUjM5YlQ1TUJldVVkcllk?=
 =?utf-8?B?SmlibGo5Vkp5MmxOR1gyRkU5Z2FGcVRUaXRDWGRhc0NNT3pzc0pYcFZ0NDRx?=
 =?utf-8?B?WDU2dEc3OVZWOFBYS0o0Z2sxTHdJdHhiTEdxRjZCNjRGbDhHY3QyV1BxUm1F?=
 =?utf-8?B?SmViK1NSUXFQV1loUmx5STB1WXFSYnhmckpaMEpKaVI5dGYyUjFrSFl4WHAr?=
 =?utf-8?B?djBPTjBUUm1COS9YeTZ3THBMZEJoNklyMXhQR3UxbzNyaStiK0ZpcmtPTUVK?=
 =?utf-8?B?WGZBN0F2Y1UxTkF5NVB6ZTZQQ09GUGdYaDJKbDU3alloclMydUduOTZzSzc4?=
 =?utf-8?B?RC95bitwWkw2K1IyNWRWZGJYOUwyNTdCdWI2a3Zhb1V3SzUrNjNFMFF0QW9Q?=
 =?utf-8?B?RFJCRDVuNzhHRUIvYlJPdW0vMExiNEFKdlIwU0c3aG9iUTVBTnJsY1h6QXly?=
 =?utf-8?B?MFRkVzcrLy8zY3VIczA2VnEydlNXdFdvV1BTN1F6SHNlNTY0ZnhUbmJYdUhC?=
 =?utf-8?B?OFVxemFlQWwyT3hvSmNnejFMYnZTWURkdktTb0c3NlgybzdQbkdQRHQ4Wllo?=
 =?utf-8?B?TEtFeGphTWpjZ2ZidDRSSkNQNjVpVjdXamNRUzYyMldLMDJGYU9mN0xZT2ZH?=
 =?utf-8?B?M28xSXpDUC82NTg3ajQrRDcwUEV4U3YrbDV3d2JzWWxadXRDWVpDL1g4QUlv?=
 =?utf-8?B?NXZHUGc4ZnBuckwvTTF4NllOQkpSOW9qM3EzYUNIN0ZnRDhUU1RZdG9samhN?=
 =?utf-8?Q?V07E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd331823-8f9a-46ec-971f-08daa5225569
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 09:33:30.6331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ycxNknKVLe8ecA+74B/IFGLNLB7a6zzpljy+Pm2gzXBTJjYFfIntqts/T2CfiQH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6707
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ji,
 Ruili" <Ruili.Ji@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEZlbGl4LA0KDQpZZXMsIEkg
anVzdCByZWFsaXplZCBmZnMgc3RhcnQgY291bnRpbmcgZnJvbSAxLiBTb3JyeSBmb3IgdGhlIG5v
aXNlLg0KDQpCZXN0IFJlZ2FyZHMsDQpZaWZhbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPiANClNlbnQ6
IEZyaWRheSwgU2VwdGVtYmVyIDMwLCAyMDIyIDEwOjU1IFBNDQpUbzogWmhhbmcsIFlpZmFuIDxZ
aWZhbjEuWmhhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzog
RGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSmksIFJ1aWxp
IDxSdWlsaS5KaUBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGRybS9hbWRrZmQ6
IGNvcnJlY3QgUkJfU0laRSBpbiBTRE1BMF9RVUVVRTBfUkJfQ05UTA0KDQoNCkFtIDIwMjItMDkt
MzAgdW0gMDI6MTYgc2NocmllYiBZaWZhbiBaaGFuZzoNCj4gSW4gU0RNQTBfUVVFVUUwX1JCX0NO
VEwsIHF1ZXVlIHNpemUgaXMgMl5SQl9TSVpFLCBub3QgMl4oUkJfU0laRSArMSkuDQo+DQo+IFNp
Z25lZC1vZmYtYnk6IFlpZmFuIFpoYW5nIDx5aWZhbjEuemhhbmdAYW1kLmNvbT4NCj4gLS0tDQo+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jIHwgMiAr
LQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTEuYyB8
IDIgKy0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRf
bWFuYWdlcl92MTAuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21h
bmFnZXJfdjEwLmMNCj4gaW5kZXggZDNlMmI2YTU5OWE0Li4wMzY5OWE5YWQzZDkgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTAuYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEwLmMN
Cj4gQEAgLTMyOSw3ICszMjksNyBAQCBzdGF0aWMgdm9pZCB1cGRhdGVfbXFkX3NkbWEoc3RydWN0
IG1xZF9tYW5hZ2VyICptbSwgdm9pZCAqbXFkLA0KPiAgIAlzdHJ1Y3QgdjEwX3NkbWFfbXFkICpt
Ow0KPiAgIA0KPiAgIAltID0gZ2V0X3NkbWFfbXFkKG1xZCk7DQo+IC0JbS0+c2RtYXhfcmxjeF9y
Yl9jbnRsID0gKGZmcyhxLT5xdWV1ZV9zaXplIC8gc2l6ZW9mKHVuc2lnbmVkIGludCkpIC0gMSkN
Cj4gKwltLT5zZG1heF9ybGN4X3JiX2NudGwgPSBvcmRlcl9iYXNlXzIocS0+cXVldWVfc2l6ZSAv
IDQpDQoNCkkgdGhpbmsgdGhlc2UgdHdvIGFyZSBlcXVpdmFsZW50LiBmZnMoMSkgPT0gMS4gb3Jk
ZXJfYmFzZV8yKDEpID09IDAuIA0KWW91J3JlIG5vdCBjb3JyZWN0aW5nIGFueXRoaW5nLiBZb3Un
cmUganVzdCB3cml0aW5nIGl0IGRpZmZlcmVudGx5Lg0KDQpSZWdhcmRzLA0KIMKgIEZlbGl4DQoN
Cg0KPiAgIAkJPDwgU0RNQTBfUkxDMF9SQl9DTlRMX19SQl9TSVpFX19TSElGVCB8DQo+ICAgCQlx
LT52bWlkIDw8IFNETUEwX1JMQzBfUkJfQ05UTF9fUkJfVk1JRF9fU0hJRlQgfA0KPiAgIAkJMSA8
PCBTRE1BMF9STEMwX1JCX0NOVExfX1JQVFJfV1JJVEVCQUNLX0VOQUJMRV9fU0hJRlQgfCBkaWZm
IC0tZ2l0IA0KPiBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92
MTEuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEx
LmMNCj4gaW5kZXggMjZiNTNiNmQ2NzNlLi40NTFmY2I5YmIwNTEgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTEuYw0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjExLmMNCj4gQEAgLTMy
OSw3ICszMjksNyBAQCBzdGF0aWMgdm9pZCB1cGRhdGVfbXFkX3NkbWEoc3RydWN0IG1xZF9tYW5h
Z2VyICptbSwgdm9pZCAqbXFkLA0KPiAgIAlzdHJ1Y3QgdjExX3NkbWFfbXFkICptOw0KPiAgIA0K
PiAgIAltID0gZ2V0X3NkbWFfbXFkKG1xZCk7DQo+IC0JbS0+c2RtYXhfcmxjeF9yYl9jbnRsID0g
KGZmcyhxLT5xdWV1ZV9zaXplIC8gc2l6ZW9mKHVuc2lnbmVkIGludCkpIC0gMSkNCj4gKwltLT5z
ZG1heF9ybGN4X3JiX2NudGwgPSBvcmRlcl9iYXNlXzIocS0+cXVldWVfc2l6ZSAvIDQpDQo+ICAg
CQk8PCBTRE1BMF9RVUVVRTBfUkJfQ05UTF9fUkJfU0laRV9fU0hJRlQgfA0KPiAgIAkJcS0+dm1p
ZCA8PCBTRE1BMF9RVUVVRTBfUkJfQ05UTF9fUkJfVk1JRF9fU0hJRlQgfA0KPiAgIAkJMSA8PCBT
RE1BMF9RVUVVRTBfUkJfQ05UTF9fUlBUUl9XUklURUJBQ0tfRU5BQkxFX19TSElGVCB8DQo=
