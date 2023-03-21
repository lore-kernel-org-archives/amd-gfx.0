Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5ADC74A5B
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Mar 2023 14:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B168A10E13E;
	Tue, 21 Mar 2023 14:48:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22ABE10E13E
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 14:48:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C69Zu2IzVxj08zFYO7x2q3y2RujGPvZ30Xlo9vQCO9W+95AHpkBq4Iv3z7PWSvu1Ro6wmiCK3KVYjqR7qH9iax5yiCamLbWqZIAXhrudE4UNnl21mgIqFdI8zkl1Vh9ZAt82iwmoMtnEAHv4PU8mCjOf+chtUAyzSX0XCIvw1uy8gwhJwPKgkyoowwVonAKH8HaMn+dE7TC2iF9Nx7dhT2ucWJid8SWh4LuEIFgwfflYjN9BGjJsWKuJD0PBBZofHvsjdScHvdPDqJiUmJTCqexUhchmKx7P32857k+X7jMwf7KHpu/VuODqlyL6rFsJUPzOVmW7dT+cFmlIWQu8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjISTUu+KfCdL7rG66pWRXtqHdQuLZu1vomkGvS96FY=;
 b=EHo9w6aybNEAkdmy6tMYzM9yFdQeciYroBLMsAPHDL2PbtGprZ/5O/BQmPl4bVABKnbyci1GikLJz+IvVkMX7mJ2R3b6NiF+d5afWpOLt+RJvPPQcoSL0kHdroUuy3O6SQkvUPPzEhxymJ2cVndmBJ6bcy83EjNVh/jr7q6N8ypg25w/gVsamcBdnhlgR2mZVDnEfuhQyKvuArnzRMGhB4f3FpRFz1EuUbI9XR84rCmPSLiddYM93jfhdk/yYP1xDM31b+KcGYtfZ5LYtawrKwEdcKlURjQIo3WE22Cvy9Wf13in4whNOirOcX11DthWSXV6DcstT9B3ahrEUBHF0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjISTUu+KfCdL7rG66pWRXtqHdQuLZu1vomkGvS96FY=;
 b=on9TEDYHsnIpvqo2kw6ItQrUBa+TY+oCQ0oOIqz5jHIBc27yktdORTOsJX+uir8J87wdzE1AdEbj2ssLo1zZx1WF2pUwL2yENi1SHtCc27cKNtvvF/g4vYKNlqdMeZfq+SmT8khPfPJAf8vSV+NLn79WMQLv20jZEonHROA2LCk=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SA3PR12MB7951.namprd12.prod.outlook.com (2603:10b6:806:318::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Tue, 21 Mar 2023 14:48:44 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::87f1:8402:36ef:18d2]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::87f1:8402:36ef:18d2%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 14:48:44 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Zhuo, Qingqing (Lillian)" <Qingqing.Zhuo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/19] DC Patches Mar 20th, 2023
Thread-Topic: [PATCH 00/19] DC Patches Mar 20th, 2023
Thread-Index: AQHZWW8rXKd2jybIKEONCcn2+LFr7a8D4xnA
Date: Tue, 21 Mar 2023 14:48:44 +0000
Message-ID: <DS0PR12MB65344A26E012FBCB239A7F859C819@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20230318075615.2630-1-qingqing.zhuo@amd.com>
In-Reply-To: <20230318075615.2630-1-qingqing.zhuo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-21T14:48:41Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=90404db0-c835-4e15-9680-6eab91990d44;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-21T14:48:41Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: d9698182-a0a4-4b44-a053-7c881d224ce2
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SA3PR12MB7951:EE_
x-ms-office365-filtering-correlation-id: 1a61f866-f707-4f38-6d54-08db2a1b5ec9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hgUNh5syiVAhgJMhDmtoxesIRrrsLxHHdJB+qLzzh2DqDmvWmzVhvFebvxOAGpvm822xcuAohWsQNbx9cTrROzXAj7OEJRSJE62XMFNkdrYIacsgXoGOzE9BSi1X/1bl3gi50iW9JmQ94L7e18osgfpnPsb1ycYtshNU/IDAWTfnO15CEPP4h2GkirFDuvE42Nduy2Y8h1XYmZuZa82Tpe7dXiqb68VGkjjhHvJ5vfxszAco7XAXnG/+L611HNve7AingZVgItJw1XkCZlWLyASELa8H9Pi/CswFpfOeAhSCg7JrH3ShYxi2/9Pvfxm6L5eWd0lhrmstY1p6D2Ox44t13XlK9tL4tbs3bos4bU046Edn017bDrVjQT2R0tg1xBrbwz2ZNwnaawehahsilYgCpKAbTKsQ5l4yy1eajrH32uo6OL4jsm1sHKWT7Y7QyfJ559K6f+GPNhXuxsBaiEPbxrsqlf3+JyqBeVbuQSGviYj/BNBfPml4YEUpNhxainNWm82KZGbVeXIZv5Lqr0ROIhhnPQTDG+0OcHlECz58SDrecGjBXqJPifZ8yfDHgxmzfWKvXm8isjuHUzr54fG9UUBuBvsjJbyBZVSHMWClAQIBYNbk+SyayAkzu9rVnDu6EhVlvGE6J7mcG1mkkw8iKXKHNGFhIpm3rKGS41rmwmnNLYZcqLDhDwEqYPPciag0OpnfEt9vHa2y0ezZ8GFjD+DXUZkUlJoRQE2aoVU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199018)(54906003)(83380400001)(478600001)(6506007)(8936002)(186003)(316002)(71200400001)(110136005)(9686003)(33656002)(26005)(7696005)(53546011)(66476007)(122000001)(66556008)(86362001)(38070700005)(38100700002)(55016003)(5660300002)(66946007)(2906002)(4326008)(41300700001)(66446008)(76116006)(64756008)(52536014)(8676002)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2ZKZDFFaDdLTlA4M3U5MjVKQkNMdUFuNWlnenh4WnhGODhNTmlRNTZON3o3?=
 =?utf-8?B?dnFIVXBNYUpRQjMyVlM2ZkFFRHhSSXFEUUR3bitxZEZ4WE83TXVWbXNsU1JK?=
 =?utf-8?B?bTh0dVlhT0xocWJJSTFzUzF6OGQrQnVpVUtVVHkvU25VTmVTUkZaMHZqM21Q?=
 =?utf-8?B?L0ZSU2hJL3JGN09tZEtKUmJ2WnZuZ0hpMkd5cVBJaldONm5XVUQ3d2VOSjBY?=
 =?utf-8?B?Nm9qZEtCQzFWTUh2b0JsbjhXeE0zZHBPbEZBd1NRNm1qNFZXTGhwc0Z3QlRO?=
 =?utf-8?B?WU9lMHd1YnpvSWFWTlNEZDNtZkNqZlBFdEdGWWtpSkN1amdSMFJYY1Z2dE5p?=
 =?utf-8?B?VzdoVGR0MmpaV2hjdFdJL3JHVENYQTNUbU1iUDhWSkVReW1mVlhUSjNSeFV4?=
 =?utf-8?B?bW52TmRET3J5UUFpb1hNeVRUd094NXAzNXRIMFNHOHY4SHFCZnFBWm1CNTFW?=
 =?utf-8?B?c0ZQUC9iZkEydjJrQlpERmVhSTRjdzNHUEY0NEdWTTduMDVzZzJtS3QxaGZh?=
 =?utf-8?B?M3doM2NpR1ZoUGRIVHBMa2lXYUZPMkhzSHFnaGFSai9acFFLNVFUVUtQNkp1?=
 =?utf-8?B?b2w0THE5NnJaOXFqeklHTHhvNWJub1dSWkZJYzh4eWtCbzFqK3dtRmliSXB2?=
 =?utf-8?B?S0RkSzAwQ1BCbm1BZFg4b010Q1pOYVNvU2xCRGplaCtwM2gzRnhZVHRUa05h?=
 =?utf-8?B?SHYxL2JmRHk3Z2N0MUdkNGdMVW9wVGxJUnlESnV1TzdPeVdteW5tb2Q3dWRF?=
 =?utf-8?B?RnFqQk40RHJzcXg3RkZndFBCY2dPNTJBQS9kWEdWdkhKcnpXTGJQa2tMUzRT?=
 =?utf-8?B?RER6SktqVXA4M0FLU0tORForaVFjWE5KU28wYWdpUms0c2N0eFhlemtYK2dF?=
 =?utf-8?B?c3J4UEFIak9adk51OUlrYU1wNzNyYkJpMWNXKzQzZExNM0hlZUQ4RFVnTFNW?=
 =?utf-8?B?QWltdWJTK3hnNHJaazRyNHRtVUZsQ3dxZ3l6clRveWNHSVhKcENETHFOcHBx?=
 =?utf-8?B?YzlBNHlRSVVIUWFXQnNvTFE0Zk1KN2JsZXQ3ZkxzZitGTGQ4SUZKbkdweGdY?=
 =?utf-8?B?dk5xRVJDK3h6aGdFaU5CQjNYWGxNVHNzRWloMEJya3g2VCswcTVmeUt3QkM4?=
 =?utf-8?B?MEtsbVYvcEs5T0NSclBRODlUcU0zKzB6bEZaY3NTMU5wVnZ0UjR1MGsrdjRy?=
 =?utf-8?B?SzRjZG9aa1oxYTE5NnVLbGpHNHJXWFJySXozOFNsUnBjcXdtRE5lblRBSGlm?=
 =?utf-8?B?OW1lYU13NkJLVkdWSVZiZWVMdmdtQTB0VWxUTXAvd0lwTjBGRXkwS256ZmZL?=
 =?utf-8?B?ZWJCUHhhdjBKV3pYNmQwSDBBM0crcjU0UlY1Q0dlWENDUDd1OS8xQmxLMEF0?=
 =?utf-8?B?dTFzSmZkd1NKZW5sTFVMa2NkdG05TVpubkVqQkJ1RU40SE1rYWFleUFpbHRJ?=
 =?utf-8?B?R3A4c1Y2VnY1SU1FbG9mdHh1Sno3a1lGdEhielVyOHM5UFA2R2o2Z1lnTVZm?=
 =?utf-8?B?OGx2WG9IWWZFSkdjYUpUQzV3SHMveTI0aHVrUGJNZFJNeE82eDkreDZSOVRw?=
 =?utf-8?B?TmFmZFZURGw4RnpiWHNMdENDRksvc1h1Y2tOdVNUWjVBc2VrZ1NBeEtyTTAw?=
 =?utf-8?B?NnNnWStTcU5nMXFmTUtvK0VkTWgzR3lNcHNsYlQrU05sNU41R3ZlNmVjNUxT?=
 =?utf-8?B?YkZPMXk4SHpNcDU1SDV5Ynh4b1ZvRDIxdkMveFovc0NkYWhQTXhlUGJJaFRx?=
 =?utf-8?B?RGc5N0Iza3lNbU4wenJTaVhRd1RCVUdXVFNoLzhMYUZObDI5a2VQck1CQ1lh?=
 =?utf-8?B?VnEvY0JhcEhLb3U0TjNkRGFYeWVYdno1YWFiQlQzZVNFeDdpNXNhWUZYNmVi?=
 =?utf-8?B?OG9PMitZS0FHMHFDRFBUUU1zT2YvcVVWR0h6OEVtYWp4R1luUUQrV3pJN1FI?=
 =?utf-8?B?Wkh1cFZFdU04NnpqTGROdU5ObXRyN2dVNlVYeHNiOFhJcnFSN2pHcEI5bkdF?=
 =?utf-8?B?WURmS0JjQWw1UGdlWmhMWVpPRUJpVXR0MlY0dTRTM1M5bWVRTXJtcWlWb1Ur?=
 =?utf-8?B?YXgvaW13eDQ1eGZOYml4UlBBbEFYTHRYeHhjNmVMdjlMbW1DQXhOTy9ia2RH?=
 =?utf-8?Q?ocMVhAbeVrAIqZgQjCSDvfghN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a61f866-f707-4f38-6d54-08db2a1b5ec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 14:48:44.5487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZzOQbsvlgHguLeGwvYCXlBNf6jOA/IQdGd5WvnQhGJpzofrtd6QqU7ggkH+A/4p0J4DgHKXC94zGslUHoH8tBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7951
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu, 
 Solomon" <Solomon.Chiu@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIGFsbCwNCiANClRoaXMgd2Vl
ayB0aGlzIHBhdGNoc2V0IHdhcyB0ZXN0ZWQgb24gdGhlIGZvbGxvd2luZyBzeXN0ZW1zOg0KIA0K
TGVub3ZvIFRoaW5rcGFkIFQxNHMgR2VuMiwgd2l0aCBBTUQgUnl6ZW4gNSA1NjUwVSANCkxlbm92
byBUaGlua3BhZCBUMTNzIEdlbjQgd2l0aCBBTUQgUnl6ZW4gNSA2NjAwVQ0KUmVmZXJlbmNlIEFN
RCBSWDY4MDANCiANClRoZXNlIHN5c3RlbXMgd2VyZSB0ZXN0ZWQgb24gdGhlIGZvbGxvd2luZyBk
aXNwbGF5IHR5cGVzOiANCmVEUCwgKDEwODBwIDYwaHogWzU2NTBVXSkgKDE5MjB4MTIwMCA2MGh6
IFs2NjAwVV0pICgyNTYweDE2MDAgMTIwaHpbNjYwMFVdKQ0KVkdBIGFuZCBEVkkgKDE2ODB4MTA1
MCA2MEhaIFtEUCB0byBWR0EvRFZJLCBVU0ItQyB0byBEVkkvVkdBXSkNCkRQL0hETUkvVVNCLUMg
KDE0NDBwIDE3MGh6LCA0ayA2MGh6LCA0ayAxNDRoeiBbSW5jbHVkZXMgVVNCLUMgdG8gRFAvSERN
SSBhZGFwdGVyc10pDQogDQpNU1QgdGVzdGVkIHdpdGggU3RhcnRlY2ggTVNUMTREUDEyM0RQIGFu
ZCAyeCA0ayA2MEh6IGRpc3BsYXlzDQpEU0MgdGVzdGVkIHdpdGggQ2FibGUgTWF0dGVycyAxMDEw
NzUgKERQIHRvIDN4IERQKSwgYW5kIDIwMTM3NSAoVVNCLUMgdG8gM3ggRFApIHdpdGggM3ggNGs2
MCBkaXNwbGF5cw0KSFAgSG9vayBHMiB3aXRoIDEgYW5kIDIgNGs2MCBEaXNwbGF5cw0KIA0KVGhl
IHRlc3RpbmcgaXMgYSBtaXggb2YgYXV0b21hdGVkIGFuZCBtYW51YWwgdGVzdHMuIE1hbnVhbCB0
ZXN0aW5nIGluY2x1ZGVzIChidXQgaXMgbm90IGxpbWl0ZWQgdG8pOg0KQ2hhbmdpbmcgZGlzcGxh
eSBjb25maWd1cmF0aW9ucyBhbmQgc2V0dGluZ3MNCkJlbmNobWFyayB0ZXN0aW5nDQpGZWF0dXJl
IHRlc3RpbmcgKEZyZWVzeW5jLCBldGMuKQ0KIA0KQXV0b21hdGVkIHRlc3RpbmcgaW5jbHVkZXMg
KGJ1dCBpcyBub3QgbGltaXRlZCB0byk6DQpTY3JpcHQgdGVzdGluZyAoc2NyaXB0cyB0byBhdXRv
bWF0ZSBzb21lIG9mIHRoZSBtYW51YWwgY2hlY2tzKQ0KSUdUIHRlc3RpbmcNCiANClRoZSBwYXRj
aHNldCBjb25zaXN0cyBvZiB0aGUgYW1kLXN0YWdpbmctZHJtLW5leHQgYnJhbmNoIHdpdGggbmV3
IHBhdGNoZXMgYWRkZWQgb24gdG9wIG9mIGl0LiBUaGlzIGJyYW5jaCBpcyB1c2VkIGZvciBib3Ro
IFVidW50dSBhbmQgQ2hyb21lIE9TIHRlc3RpbmcgKENocm9tZU9TIG9uIGEgYmktd2Vla2x5IGJh
c2lzKS4NCiANCiANClRlc3RlZCBvbiBVYnVudHUgMjIuMDQuMSBhbmQgQ2hyb21lIE9TDQogDQpU
ZXN0ZWQtYnk6IERhbmllbCBXaGVlbGVyIDxkYW5pZWwud2hlZWxlckBhbWQuY29tPg0KIA0KIA0K
VGhhbmsgeW91LA0KIA0KRGFuIFdoZWVsZXINClNyLiBUZWNobm9sb2dpc3QgfCBBTUQNClNXIERp
c3BsYXkNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KMSBDb21tZXJjZSBWYWxsZXkgRHIgRSwgVGhvcm5oaWxsLCBPTiBMM1QgN1g2DQph
bWQuY29tDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBaaHVvLCBRaW5ncWlu
ZyAoTGlsbGlhbikgPFFpbmdxaW5nLlpodW9AYW1kLmNvbT4gDQpTZW50OiBNYXJjaCAxOCwgMjAy
MyAzOjU2IEFNDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBXZW50bGFu
ZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+OyBMaSwgU3VuIHBlbmcgKExlbykgPFN1
bnBlbmcuTGlAYW1kLmNvbT47IExha2hhLCBCaGF3YW5wcmVldCA8Qmhhd2FucHJlZXQuTGFraGFA
YW1kLmNvbT47IFNpcXVlaXJhLCBSb2RyaWdvIDxSb2RyaWdvLlNpcXVlaXJhQGFtZC5jb20+OyBQ
aWxsYWksIEF1cmFiaW5kbyA8QXVyYWJpbmRvLlBpbGxhaUBhbWQuY29tPjsgWmh1bywgUWluZ3Fp
bmcgKExpbGxpYW4pIDxRaW5ncWluZy5aaHVvQGFtZC5jb20+OyBMaSwgUm9tYW4gPFJvbWFuLkxp
QGFtZC5jb20+OyBMaW4sIFdheW5lIDxXYXluZS5MaW5AYW1kLmNvbT47IFdhbmcsIENoYW8ta2Fp
IChTdHlsb24pIDxTdHlsb24uV2FuZ0BhbWQuY29tPjsgQ2hpdSwgU29sb21vbiA8U29sb21vbi5D
aGl1QGFtZC5jb20+OyBLb3RhcmFjLCBQYXZsZSA8UGF2bGUuS290YXJhY0BhbWQuY29tPjsgR3V0
aWVycmV6LCBBZ3VzdGluIDxBZ3VzdGluLkd1dGllcnJlekBhbWQuY29tPjsgV2hlZWxlciwgRGFu
aWVsIDxEYW5pZWwuV2hlZWxlckBhbWQuY29tPg0KU3ViamVjdDogW1BBVENIIDAwLzE5XSBEQyBQ
YXRjaGVzIE1hciAyMHRoLCAyMDIzDQoNClRoaXMgREMgcGF0Y2hzZXQgYnJpbmdzIGltcHJvdmVt
ZW50cyBpbiBtdWx0aXBsZSBhcmVhcy4gSW4gc3VtbWFyeSwgd2UgaGlnaGxpZ2h0Og0KLSBQb3dl
ciBkb3duIGVEUCBpZiBlRFAgbm90IHByZXNlbnQNCi0gU2V0IE1QQ19TUExJVF9EWU5BTUlDIGZv
ciBEQ04xMCBhbmQgRENOMzAxDQotIEluaXRpYWxpemUgbGlua19zcnYgaW4gdmlydHVhbCBlbnYN
Ci0gQ29kZSBjbGVhbnVwIGFuZCBhbGlnbm1lbnQNCg0KQ2M6IERhbmllbCBXaGVlbGVyIDxkYW5p
ZWwud2hlZWxlckBhbWQuY29tPg0KLS0tDQoNCkFsZXggRGV1Y2hlciAoMik6DQogIFJldmVydCAi
ZHJtL2FtZGdwdS9kaXNwbGF5OiBjaGFuZ2UgcGlwZSBwb2xpY3kgZm9yIERDTiAyLjAiDQogIGRy
bS9hbWRncHUvc211MTE6IGVuYWJsZSBURU1QX0RFUEVOREVOVF9WTUlOIGZvciBuYXZpMXgNCg0K
QWxleCBIdW5nICgxKToNCiAgZHJtL2FtZC9kaXNwbGF5OiByZW1vdmUgb3V0ZGF0ZWQgOGJwYyBj
b21tZW50cw0KDQpBcmljIEN5ciAoMSk6DQogIGRybS9hbWQvZGlzcGxheTogMy4yLjIyOA0KDQpD
aGFybGVuZSBMaXUgKDMpOg0KICBkcm0vYW1kL2Rpc3BsYXk6IHVwZGF0ZSBkaW8gZm9yIHR3byBw
aXhlbCBwZXIgY29udGFpbmVyIGNhc2UNCiAgZHJtL2FtZC9kaXNwbGF5OiBBZGQgQ1JDIGFuZCBE
TVVCIHRlc3Qgc3VwcG9ydA0KICBkcm0vYW1kL2Rpc3BsYXk6IGFkZCBtaXNzaW5nIGNvZGUgY2hh
bmdlIGluaXQgcGl4X3Blcl9jeWNsZQ0KDQpIZXJzZW4gV3UgKDMpOg0KICBkcm0vYW1kL2Rpc3Bs
YXk6IGFsaWduIGNvbW1pdF9wbGFuZXNfZm9yX3N0cmVhbSB0byBsYXRlc3QgZGMgY29kZQ0KICBk
cm0vYW1kL2Rpc3BsYXk6IGZpeCB3cm9uZyBpbmRleCB1c2VkIGluIGRjY2czMl9zZXRfZHBzdHJl
YW1jbGsNCiAgZHJtL2FtZC9kaXNwbGF5OiBTZXQgZGNuMzIgY2Fwcy5zZWFtbGVzc19vZG0NCg0K
TWFydGluIExldW5nICgxKToNCiAgZHJtL2FtZC9kaXNwbGF5OiBpbml0aWFsaXplIGxpbmtfc3J2
IGluIHZpcnR1YWwgZW52DQoNCk11c3RhcGhhIEdoYWRkYXIgKDEpOg0KICBkcm0vYW1kL2Rpc3Bs
YXk6IEFkZCBmdW5jdGlvbiBwb2ludGVyIGZvciB2YWxpZGF0ZSBidyB1c2I0DQoNClBhdWwgSHNp
ZWggKDEpOg0KICBkcm0vYW1kL2Rpc3BsYXk6IHBvd2VyIGRvd24gZURQIGlmIGVEUCBub3QgcHJl
c2VudA0KDQpSb2RyaWdvIFNpcXVlaXJhICgzKToNCiAgZHJtL2FtZC9kaXNwbGF5OiBBZGQgY29u
c3QgdG8gYSBmdW5jdGlvbg0KICBkcm0vYW1kL2Rpc3BsYXk6IFNldCBNUENfU1BMSVRfRFlOQU1J
QyBmb3IgRENOMTANCiAgZHJtL2FtZC9kaXNwbGF5OiBTZXQgTVBDX1NQTElUX0RZTkFNSUMgZm9y
IERDTjMwMQ0KDQpTYWFlbSBSaXp2aSAoMSk6DQogIGRybS9hbWQvZGlzcGxheTogSW1wbGVtZW50
IHdvcmthcm91bmQgZm9yIHdyaXRpbmcgdG8NCiAgICBPVEdfUElYRUxfUkFURV9ESVYgcmVnaXN0
ZXINCg0KV2VzbGV5IENoYWxtZXJzICgxKToNCiAgZHJtL2FtZC9kaXNwbGF5OiBNYWtlIERDTjMy
IDNkbHV0IGZ1bmN0aW9uIGF2YWlsYWJsZSB0byBmdXR1cmUgRENOcw0KDQpaaGlrYWkgWmhhaSAo
MSk6DQogIGRybS9hbWQvZGlzcGxheTogc2tpcCB3YWl0IHZibGFuaw0KDQogLi4uL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgIDEgLQ0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMgICAgICB8IDI3ICsrKy0tLS0tLS0tLS0tLS0tDQog
Li4uL2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZXhwb3J0cy5jIHwgIDggKysrLS0N
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaCAgICAgICAgICAgfCAxOCArKysr
KysrKysrLS0NCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9vcHRjLmgg
fCAyOSArKysrKysrKysrKysrKysrKysrICAuLi4vZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2Rj
bjEwX3Jlc291cmNlLmMgfCAgNCArLS0gIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIw
L2RjbjIwX2RjY2cuaCB8ICAzICstDQogLi4uL2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24y
MF9od3NlcS5jICAgIHwgIDQgKy0tDQogLi4uL2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24y
MF9yZXNvdXJjZS5jIHwgIDIgKy0NCiAuLi4vYW1kL2Rpc3BsYXkvZGMvZGNuMzAxL2RjbjMwMV9y
ZXNvdXJjZS5jICAgfCAgMiArLQ0KIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjMyL2Rj
bjMyX2RjY2cuYyB8IDI1ICsrKysrKysrKysrKysrLS0gIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2RjbjMyL2RjbjMyX2RjY2cuaCB8ICAzICstDQogLi4uL2RjL2RjbjMyL2RjbjMyX2Rpb19z
dHJlYW1fZW5jb2Rlci5jICAgICAgIHwgIDYgKysrKw0KIC4uLi9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZGNuMzIvZGNuMzJfaHdzZXEuYyAgICB8ICA0ICstLQ0KIC4uLi9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZGNuMzIvZGNuMzJfaHdzZXEuaCAgICB8ICAzICsrDQogLi4uL2RybS9hbWQvZGlzcGxheS9kYy9k
Y24zMi9kY24zMl9yZXNvdXJjZS5jIHwgIDEgKyAgLi4uL2RybS9hbWQvZGlzcGxheS9kYy9kY24z
Mi9kY24zMl9yZXNvdXJjZS5oIHwgIDMgKy0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvaW5jL2xpbmsuaCAgICAgfCAgMyArKw0KIC4uLi9kcm0vYW1kL2Rpc3BsYXkvZGMvbGluay9s
aW5rX2RldGVjdGlvbi5jICB8ICA1ICsrKysNCiAuLi4vZHJtL2FtZC9kaXNwbGF5L2RjL2xpbmsv
bGlua19mYWN0b3J5LmMgICAgfCAgMSArDQogLi4uL2RybS9hbWQvZGlzcGxheS9kYy9saW5rL2xp
bmtfdmFsaWRhdGlvbi5jIHwgMTggKysrKysrKysrKysrICAuLi4vZHJtL2FtZC9kaXNwbGF5L2Rj
L2xpbmsvbGlua192YWxpZGF0aW9uLmggfCAgNCArKysNCiAuLi4vZGMvbGluay9wcm90b2NvbHMv
bGlua19kcF9kcGlhX2J3LmMgICAgICAgfCAgOSArKy0tLS0NCiAuLi4vZGMvbGluay9wcm90b2Nv
bHMvbGlua19kcF9kcGlhX2J3LmggICAgICAgfCAgNyArKysrLQ0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kbXViL2RtdWJfc3J2LmggICB8ICAyICsrDQogLi4uL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvaW5jbHVkZS9kYWxfYXNpY19pZC5oIHwgIDEgKw0KIC4uLi9ncHUvZHJtL2FtZC9wbS9z
d3NtdS9zbXUxMS9uYXZpMTBfcHB0LmMgICB8ICAzICstDQogMjcgZmlsZXMgY2hhbmdlZCwgMTQ0
IGluc2VydGlvbnMoKyksIDUyIGRlbGV0aW9ucygtKQ0KDQotLQ0KMi4zNC4xDQo=
