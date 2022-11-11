Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C889C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Nov 2022 06:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B4FA10E775;
	Fri, 11 Nov 2022 06:15:54 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2416710E775
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Nov 2022 06:15:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeONSt/RzLa1gprIEeHLiOuKP7t8pnZ18Pv+cT/UPdeO5jA4nyqWWipDH+/JPI17XMOA9XYmQr7zRGEOIPOC003BRYq+h7Q0XGld74lIqcCLv1+B3p1kErQHCaHbQCqGy6js668rUx3WHBlCecS56ErsUZB50iiH1wLdKu8nE4AUVp3iGKo44oHGXOtQ5QKVYxDa2N/PYDKI3H6dFXRl6RFOJsfWZhEWIuIPIiJuZf8MYRf5k6lROUgT4ubj8fXfS5Mu8txbeFCJev9UlFO+FdzGnI9guPEz3GeK3Gvibe+vXpetPIRreSiw91BJ67y2tOciB4kCtQM08xp6/lR43A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfQufaug6xA9G0Zx69M9HpiphZPlGv1F7P8ZqKzGQ78=;
 b=QGfAuQaBkXqPi20S3FNe9BCjJxAEQWy6uEKZ1u2AF+v6b2A5YiTIPnxT1JMckhzpd9G4FXxJYiZytWUfwGRLM3bALLanVJ7EZmsU99P6hd2NWtb35IIEdYIK3zsLlnAMZ0GzWSZITfGGBGCAwIqaI5YpU3Tz0yBCP5YwffTfXI3YwH+Q/mC/c7aq5jp8SVil9lrgrvJhGe6xCl3BaDRg5dRWwOoeRkQLiEox4fI0yfRjMrtO0TF9yBeX7SQc3wI6TsuiHSup3Fhbr+5bEzhkdxs1TBu4er7qmUiXld8ykLmvi0nUOlsE95ILs61Qz3M1W2NdpO+OK2u8j2jjhoKnRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfQufaug6xA9G0Zx69M9HpiphZPlGv1F7P8ZqKzGQ78=;
 b=R5W/qZHdf/MsxrF8zf7zldN5Sj9fpsbRZVoC0FDtvg5uiKhtP1brI4BLDX/MjdRRmmQU3gjp5iE2fhlgt7t4p8hLXnmsmHfpYgJwxuMMhtYSdB8MdO67+GgSUJbIh8/hFB8q7E3D9awA+3YucQ6ZfVKArMpmdq6JLSNLpF9x6UY=
Received: from DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) by
 MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 06:15:41 +0000
Received: from DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::9fe:10b1:7abb:dc01]) by DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::9fe:10b1:7abb:dc01%9]) with mapi id 15.20.5813.012; Fri, 11 Nov 2022
 06:15:41 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, =?utf-8?B?TWljaGVsIETDpG56ZXI=?=
 <michel@daenzer.net>
Subject: RE: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)
Thread-Topic: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)
Thread-Index: AQHY4tFVpYvpMYHRLUurvXDdtV25kK4oe3YAgADSeqCAAJAjgIAAC0PAgAAFIoCAAae2gIAA/0LwgABrlQCAB1XWwIAEL1YAgAAPGQCAAM2RwA==
Date: Fri, 11 Nov 2022 06:15:40 +0000
Message-ID: <DS7PR12MB6333B9CE3667AD501B98C949F4009@DS7PR12MB6333.namprd12.prod.outlook.com>
References: <20221018090815.2662321-1-jiadong.zhu@amd.com>
 <20221018090815.2662321-4-jiadong.zhu@amd.com>
 <e5544150-5eae-7dae-b5db-dd9539df8198@daenzer.net>
 <DS7PR12MB6333A815A3C3EADFFA303E4FF4369@DS7PR12MB6333.namprd12.prod.outlook.com>
 <5a11969c-0996-8755-472a-11f9cf1705d1@daenzer.net>
 <SJ1PR12MB6338730B8B54AD01E4FEF86BF4369@SJ1PR12MB6338.namprd12.prod.outlook.com>
 <92da389f-3c26-6fe1-0525-d38730b6924a@daenzer.net>
 <8b3240e6-c460-5dbd-eede-29ff4825e642@daenzer.net>
 <DS7PR12MB63332B114E5E3B45F91178AFF4389@DS7PR12MB6333.namprd12.prod.outlook.com>
 <04361686-5bdd-8ca8-2ecd-c5dfdaa1a41b@daenzer.net>
 <DS7PR12MB63331E4430DC731D92B0A7CAF43F9@DS7PR12MB6333.namprd12.prod.outlook.com>
 <fb72d05b-dc74-fa84-51cf-3c3911aa46fc@daenzer.net>
 <CADnq5_MKjxf-YngEVJe8AbZQ0Ss6ghGhVHUeSErwPsUg2paoYQ@mail.gmail.com>
In-Reply-To: <CADnq5_MKjxf-YngEVJe8AbZQ0Ss6ghGhVHUeSErwPsUg2paoYQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a69cbafe-cec4-4742-b5e6-011e1614721a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-11T06:10:07Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6333:EE_|MW4PR12MB5666:EE_
x-ms-office365-filtering-correlation-id: 7f4213fa-07f6-4bd7-e093-08dac3ac289f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GlwZu3vv0nGBgSMplIFUtQmbLto9OxaMWiSq+U2WeFoyecRok8iekTnkyHLpm7StRxIyvmlaHPBuWFSN8mX7fsa+gQb02jM36KyDAOac+BrXtSm+VqcJzJJmRxBdxfXKzLyItJKCFVOlVYMpxNuYLE3DhDZFkcB8LPC6hNz8SehcdKooNGPpgSTnj/gDbtpc56y59FVL/MZ4t6p4PpRe/CiixGh/GL7uvTCgMuKYPcrpPZeDb17G8McOGyJBeiyC0Lb6vaf2cAaLMW4VzgEqEWH5QRl66LuckKNQ+QYqT0k3etNJx8Zy4K35Ty1oneKaHtShsFWOYJrv98B7gC6WCpd1e6AEXTbSpzINdpZUIGCf3o1Ba8xw+OLtMe0tM/S2+xHHtq4y5liQIpURIZ4wvI0E1ryl6wjriSrl6+HW3uooEGM+QYD7G2wofVZPV9cF5XO8SiWO9hzoCB0n8FNbgLDm3aLOjQmY5Q7N9yC8cIWizQ9IzJGDzKaxm7bEobLhIVHa9pNY9GoJU9ViLbeAvBMr88sLtRR7aP8L4sdLC+d146ECDKI6W/qoG2HApwTXCGvyj1CqBV6sv0w5dq3V4v7s3v1PXjbLUIilXHWHtjwg6gCnw2kkn0k17Ms++iBDkNJnVBlOqBKrfMcabB6gDVGcyciogYGD81EoieGcPR3UATrBfdp1fS68/Q9rXsR/AVx6xaTCxVtwcpC8pG3BLAsSSEx7iESCFXS7ArynJdhtIWgeKNAZrRxLfmKPztM0ABNKAXiDe6v7ulWFoWdY5g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6333.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199015)(83380400001)(316002)(54906003)(110136005)(2906002)(66574015)(86362001)(186003)(53546011)(7696005)(6506007)(71200400001)(26005)(9686003)(38070700005)(38100700002)(122000001)(478600001)(33656002)(64756008)(66446008)(41300700001)(55016003)(8936002)(52536014)(5660300002)(76116006)(66556008)(66946007)(8676002)(66476007)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3ViV0RQTnJrYk5EUzljUDkrVVhsZHFOckVVbVIxWVBncHhlajV4UHovMjVT?=
 =?utf-8?B?MG9vcVdTQ2xGS3JhZzhXNE9JbzgvSFN2elJWZWNXUTBBL0k3TFk3aXRXL1hX?=
 =?utf-8?B?RU5XZWJuY1NwbTZQZlRJa2lEMFBpSUxYeHZrVk1QaU16eTI5aFRKOXljZ0Q5?=
 =?utf-8?B?VWdNSCs5Y3hCOUQzOGwrQ0RjNFBYQ3Q2RGt3a2k1UktoVDl1SGk5NTFaV0NO?=
 =?utf-8?B?SXdVU0dXZkxxZ3dWTlFQaW9lU09ZZGZPWG9XclpiQ3hPWjArc2RoSHIzUTFz?=
 =?utf-8?B?RWZUTkpBYVJTazRUTlg1d1ZxdVZZSUUzRFU0SmU1MGI1Zm45YVhpcGx4QmZT?=
 =?utf-8?B?OUJkY2JNNTJkZnFjNi9wa0loMVFkdUEwTld0L2tzSkZMUUxqYitNVDhiRUJP?=
 =?utf-8?B?V1NhVmJmZkFldTdsbGgweDZkSWdWTVhBQXFjOHlrZG02RHdyaWlsMzJiZStF?=
 =?utf-8?B?MlMxVG1wREo0clZVeWhiQTVnQ0pzbW4zZ0k0azVNd2kwUEtESGtXV1hnMG1z?=
 =?utf-8?B?T0hxWTRKQ2RHMDRiMXgydTVadm56VktLMXlSZ2RkME5OMlZkK3lqNkJjVEhw?=
 =?utf-8?B?Z3A5K3FYM0h3NHhzY0Vkcnp0SGpkVDkzY2ZkRGxQaXFHNnNMa1Rsdm9DaGNK?=
 =?utf-8?B?b2o0NW1iTkxTclFIWHppVWllY2JDUW1JR3hjT1F3OHlNWVpTMTVyT2NtRWZQ?=
 =?utf-8?B?OFBSNmZNNTNKZEh5K2pWY3Nna1dJdW1tbFZRVWZ1ZzhEeTY0Y1FRRXRFK0NY?=
 =?utf-8?B?SW9rWDMyZW42bnBsWXVJMWUxM0syZDB3c2ZVVDlqQ21maVkveDJwWE9EVVVB?=
 =?utf-8?B?QUUva2hsTSswQTZtOG1HZERxak5wKzVscjQyRFJSY3NTU0JTaXUvRFM1SnZK?=
 =?utf-8?B?SURTMHhWalNiV1hxUTF6ZnNNY1N0cTlMME5ZK0J0anpnam5lbWtqUkRTbDk5?=
 =?utf-8?B?UHc5elJDTjk5SmdJbUJZZXU3ekVhUmdsczVjUmJVc3VtR0lOQ0o4Q0wyd2kx?=
 =?utf-8?B?bzdSZjczS1doNVEzbFFSck5zK1ZSSTBHRzNCVkN2ZGV1TDZ6QUdIbmpScWhz?=
 =?utf-8?B?d3drc3RTbWlNOHYzNjhZay93QWx4aEhKVDg4SitWWjZwa1hLbks1WjNWaDNW?=
 =?utf-8?B?RDc3N2ZNRy95N1ZQZkw2TUd3ZUZsL2JOSlFqZVZGb0pMOVpwLzRHQVlFVEpV?=
 =?utf-8?B?RVFtc09FcVRTRjFENWVsQmgrajBBdlBOWkI2Y2llVXRucnl1U2V3Qjk3MWRJ?=
 =?utf-8?B?NkdtdnVpYUY0UHJvOVg3ZTY3c2FFdDFIMG1zemZVN3VIak5iVjlaZ2dRcnNk?=
 =?utf-8?B?UVVQUC80SmZDSHBJR0lDTVZ1aDFIWnNQeFpMMkJvbFhhVWtTOHptWmlCR0h1?=
 =?utf-8?B?Y0M5cERDR3g5Z21hejRnRXBPSUNOUVdWbTZndURZQ3daM2JaT01raUNYVUZD?=
 =?utf-8?B?eCs1ckNDT1ZTWGpTWGlBVERDeWhhM3VNNU9JWFpqc1d0TkJkTmtIZnc4ZHB0?=
 =?utf-8?B?WlNpSXcycVFpMmJwQXlCV3JaMWNEWWIzTUhGb05yQ1FJR1BPTnVSNHdHcWEw?=
 =?utf-8?B?OU83SzJDTzhBNW5mUnFyUUlrZUJxL0hiVTBqVEhiWU9yY1ZtV0lyenBZSTRP?=
 =?utf-8?B?RGgxaHc3WHJnOVdwUUhzQXcxM2ZueTI1dDdRbnpqcndMZXIxTFlLZXROOFl5?=
 =?utf-8?B?YU15YUVuUk5aVDVZU0h5bEViNnRLSDBscDFTYTRoVnRQTFFRVTR0VGllTGln?=
 =?utf-8?B?RzdJQXhkbWFTMTZTakRubU81TXVLTTNJWS9rZTFJUVRoOG5nZFNTNmxmb1N6?=
 =?utf-8?B?WVEvVkU3b1daV1NxdzBTaHB3Zm1PSVZLa0JQZm1HWTNhVUtTYkRjTSsrWDlJ?=
 =?utf-8?B?OWY4ODMvRE9LQWhRZU5oN1ljTEFhaXpPR3JiaEZXNEhOZG9LWHpaczlJSElX?=
 =?utf-8?B?eHhQeklSeDd0U21zalpBM1JsOGhpQUxZeU5mdWI3UjBvVlZPUXR0MXpEblNx?=
 =?utf-8?B?VDNkNkt5SGhZdk1lMVRtRm1SQzZENnF0QlljQzdmNjc4MXNOdy9BRG5xWXVF?=
 =?utf-8?B?T0lLenpOYWM5eWd0RmoyaEtJM2tXMGhuSnJMUm1hMkd1VVc5SzltN0R5ZVkx?=
 =?utf-8?Q?1A8PFprAR+RdtklhJiV1p+h27?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4213fa-07f6-4bd7-e093-08dac3ac289f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 06:15:40.9079 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QP09a8xI2AHXPRtGDZLUXw4QmfgrTPrx6aklP0aZXgYAb5m3PQmJphkxiyCjHF81uQAg2TlS0WxuTTqXBp7YkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666
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
Cc: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE1pY2hlbCwNCg0KSXQgaXMg
dHJ1ZSB0aGF0IHdlIGRvbuKAmXQgZ2V0IG9idmlvdXMgaW1wcm92ZW1lbnQgb24gcGVyZm9ybWFu
Y2Ugd2l0aCB0aGVzZSBwYXRjaGVzLg0KVGhlIG9yaWdpbmFsIHJlcXVpcmVtZW50IG9mIHVzaW5n
IG1jYnAgaXMgdGhhdCB3aGVuIHRoZXJlIGlzIGEgdmVyeSBsb25nIGliIHBhY2thZ2Ugd2l0aCBt
YW55IGRyYXcgY21kcyBvbiBsb3cgcHJpb3JpdHkgd2hpY2ggdXNlcyB1cCBncHUgdXRpbGl6YXRp
b24sIHdlIGdpdmUgYSBjaGFuY2UgdG8gaGlnaCBwcmlvcml0eSBpYnMgZXhlY3V0ZWQgYnkgZ3B1
Lg0KVGhlIHRvdGFsIHBlcmZvcm1hbmNlIGNvdWxkIGJlIGRyb3BwZWQgYXMgbWNicCBkcmFpbnMg
dGhlIHBpcGUgYW5kIHRoZSBsb3cgcHJpb3JpdHkgaWJzIHdvdWxkIGJlIHJlc3VibWl0dGVkIGFn
YWluIGFmdGVyIHRoYXQuDQoNClRoaXMgc2V0IG9mIHBhdGNoZXMgaXMgbWFpbmx5IHRvIGltcGxl
bWVudCBwcmlvcml0eSBxdWV1ZXMgYnkgc29mdHdhcmUgcmluZ3MuIFdlIG1heSB1c2Ugb3RoZXIg
bWV0aG9kIGluc3RlYWQgb2YgbWNicCB0byBpbXByb3ZlIGl0IGxhdGVyLg0KDQpUaGFua3MsDQpK
aWFkb25nDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbGV4IERldWNoZXIg
PGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NClNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMTEsIDIwMjIg
MTo1NCBBTQ0KVG86IE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+DQpDYzogWmh1
LCBKaWFkb25nIDxKaWFkb25nLlpodUBhbWQuY29tPjsgVHVpa292LCBMdWJlbiA8THViZW4uVHVp
a292QGFtZC5jb20+OyBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47IEtvZW5pZywgQ2hy
aXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCA0LzVdIGRybS9hbWRncHU6IE1DQlAgYmFzZWQg
b24gRFJNIHNjaGVkdWxlciAodjgpDQoNCk9uIFRodSwgTm92IDEwLCAyMDIyIGF0IDEyOjAwIFBN
IE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+IHdyb3RlOg0KPg0KPiBPbiAyMDIy
LTExLTA4IDA5OjAxLCBaaHUsIEppYWRvbmcgd3JvdGU6PiBGcm9tOiBNaWNoZWwgRMOkbnplcg0K
PiA8bWljaGVsQGRhZW56ZXIubmV0Pg0KPiA+DQo+ID4+Pj4gVGhlIGJhZCBuZXdzIGlzIHRoYXQg
dGhpcyBzZXJpZXMgc3RpbGwgbWFrZXMgc29tZSB0aGluZ3MgdmVyeSBzbG93LiBUaGUgbW9zdCBl
eHRyZW1lIGV4YW1wbGVzIHNvIGZhciBhcmUgZ2x4Z2VhcnMgKHJ1bnMgYXQgfjQwMCBmcHMgbm93
LCB+NzAwMCBmcHMgYmVmb3JlLCBpLmUuIGFsbW9zdCAyMHggc2xvd2Rvd24pIGFuZCBoZXhjaGF0
IChzY3JvbGxpbmcgb25lIHBhZ2Ugbm93IHRha2VzIH4xIHNlY29uZCwgSSBjYW4gc2VlIGl0IGRy
YXdpbmcgbGluZSBieSBsaW5lOyBiZWZvcmUgaXQgd2FzIGFsbW9zdCBpbnN0YW50YW5lb3VzKS4g
SSBzdXNwZWN0IHRoaXMgc2VyaWVzIG1ha2VzIHRoZSBvdmVyaGVhZCBvZiBydW5uaW5nIGEgc2lu
Z2xlIEdQVSBqb2IgbXVjaCBiaWdnZXIuIE9uIHRoZSBicmlnaHQgc2lkZSwgSSdtIG5vdCBub3Rp
Y2luZyBhbnkgc2lnbmlmaWNhbnQgaW50ZXJtaXR0ZW50IGZyZWV6ZXMgYW55bW9yZS4NCj4gPj4+
DQo+ID4+PiBIaSBNaWNoZWwsDQo+ID4+Pg0KPiA+Pj4gVGhhbmtzIGZvciB0aGUgdHJ5aW5nLg0K
PiA+Pj4gSXMgdGhlcmUgaGlnaCBwcmlvcml0eSBqb2JzIHJ1bm5pbmcgd2hpbGUgZXhlY3V0aW5n
IGdseGdlYXJzPw0KPiA+Pg0KPiA+PiBZZXMsIG11dHRlciBpcyBzdWJtaXR0aW5nIGhpZ2ggcHJp
b3JpdHkgam9icy4gSG93ZXZlciwgSSBkb24ndCB0aGluayB0aGF0IGNhbiBleHBsYWluIHRoZSBw
cm9ibGVtIGJ5IGl0c2VsZjoNCj4gPj4NCj4gPj4gbXV0dGVyIG9ubHkgZHJhd3Mgb25jZSBwZXIg
ZGlzcGxheSByZWZyZXNoIGN5Y2xlLiBMZXQncyBhc3N1bWUgbXV0dGVyJ3MgR1BVIHdvcmsgdGFr
ZXMgfjYtN21zIChjb25zZXJ2YXRpdmUgZXhhbXBsZSwgc2hvdWxkIGJlIGxlc3MgdGhhbiB0aGF0
IHVzdWFsbHkpLiBUaGF0IGxlYXZlcyB+MTBtcyBwZXIgZGlzcGxheSByZWZyZXNoIGN5Y2xlIChh
dCA2MCBIeiByZWZyZXNoIHJhdGUpIHdoZXJlIEdQVSB3b3JrIGZyb20gZ2x4Z2VhcnMgJiBYd2F5
bGFuZCBjYW4gcnVuIHdpdGhvdXQgZ2V0dGluZyBwcmVlbXB0ZWQuIFNpbmNlIGdseGdlYXJzIHJ1
bnMgYXQgfjcwMDAgZnBzIHdpdGhvdXQgdGhpcyBzZXJpZXMsIGl0IHNob3VsZCBiZSBhYmxlIHRv
IGRyYXcgYXQgbGVhc3QgfjcwIGZyYW1lcyBpbiAxMG1zWzBdLCB3aGljaCBjb3JyZXNwb25kcyB0
byBvdmVyIDQwMDAgZnBzLiBZZXQgaXQgbWFuYWdlcyBvbmx5IDEvMTAgb2YgdGhhdC4NCj4gPj4N
Cj4gPj4gWzBdIFdvcnN0IGNhc2UgY29uc2lkZXJhdGlvbiwgaWdub3JpbmcgdGhlIGZhY3QgdGhh
dCB3aXRob3V0IHRoaXMgc2VyaWVzLCBnbHhnZWFycyBydW5zIGF0IH43MDAwIGZwcyB3aGlsZSBt
dXR0ZXIgc3VzdGFpbnMgNjAgZnBzLg0KPiA+DQo+ID4gSSByZXByb2R1Y2VkIHRoZSBnbHhnZWFy
cyA0MDBmcHMgc2NlbmFyaW8gbG9jYWxseS4gVGhlIGlzc3VlIGlzIGNhdXNlZCBieSB0aGUgcGF0
Y2g1ICJkcm0vYW1kZ3B1OiBJbXByb3ZlIHRoZSBzb2Z0d2FyZSByaW5ncyBwcmlvcml0eSBzY2hl
ZHVsZXIiIHdoaWNoIHNsb3dzIGRvd24gdGhlIGxvdyBwcmlvcml0eSBzY2hlZHVsZXIgdGhyZWFk
IGlmIGhpZ2ggcHJpb3JpdHkgaWIgaXMgdW5kZXIgZXhlY3V0aW5nLiBJJ2xsIGRyb3AgdGhpcyBw
YXRjaCBhcyB3ZSBjYW5ub3QgaWRlbnRpZnkgZ3B1IGJvdW5kIGFjY29yZGluZyB0byB0aGUgdW5z
aWduYWxlZCBmZW5jZSwgZXRjLg0KPg0KPiBPa2F5LCBJJ20gdGVzdGluZyB3aXRoIHBhdGNoZXMg
MS00IG9ubHkgbm93Lg0KPg0KPiBTbyBmYXIgSSBoYXZlbid0IG5vdGljZWQgYW55IG5lZ2F0aXZl
IGVmZmVjdHMsIG5vIHNsb3dkb3ducyBvciBpbnRlcm1pdHRlbnQgZnJlZXplcy4NCj4NCj4gVGhl
IG9ubHkgaXNzdWUgaXMgdGhhdCB0aGVyZSdzIGhhcmRseSBhbnkgcG9zaXRpdmUgZWZmZWN0IGVp
dGhlci4gV2hpbGUgY29uc3RhbnRseSBtb3ZpbmcgdGhlIHdpbmRvdyBvZiBhIEdQVS1saW1pdGVk
IEdwdVRlc3QgYmVuY2htYXJrIGluIGNpcmNsZXMsIG1vc3Qgb2YgdGhlIHRpbWUgaXQgbG9va3Mg
ZXhhY3RseSB0aGUgc2FtZSBhcyB3aXRob3V0IHRoZXNlIHBhdGNoZXMuIE9ubHkgb2NjYXNpb25h
bGx5LCBhdCBtb3N0IGV2ZXJ5IGZldyBzZWNvbmRzLCBJIG5vdGljZSB0aGF0IHRoZSB3aW5kb3cg
bW92ZW1lbnQgYmVjb21lcyBzbW9vdGhlciBmb3IgYW4gaW5zdGFudC4NCj4NCg0KSSB0aGluayBp
dCB3aWxsIGxhcmdlbHkgZGVwZW5kIG9uIHRoZSB3b3JrbG9hZC4gIFRoZSBnZnggcGlwZSBjYW4g
b25seSBiZSBwcmVlbXB0ZWQgb24gZHJhdyBib3VuZGFyaWVzIHNvIGlmIG1vc3Qgb3BlcmF0aW9u
cyBhcmUgYSBzaW5nbGUgZHJhdywgeW91IHByb2JhYmx5IHdvbid0IHNlZSBtdWNoIGRpZmZlcmVu
Y2UuDQoNCkFsZXgNCg==
