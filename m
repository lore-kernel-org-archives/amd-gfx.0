Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6825CC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 10:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93EED2A2A1;
	Tue, 26 Jul 2022 10:01:51 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2050.outbound.protection.outlook.com [40.107.212.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFFCE2A2A1
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 10:01:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaVYMTbgq4F56sG3CuvkaS1090JrcWfaCeKuY21o3+tiXneaR/Y7QFTGPW6Oz7vFNgYf098ns1It4xVKC3HmmkFN0MsI5+pMtP+awMQHs9YkkG9SCSDPCVPRLXFqdMltSfzSuuLKVUXueQD+/hpAcdEjSs/gsASGwRVUiQnQshKyYZlAdeV62vOYcYZYEcgxV0+6PwHuB1p5R0+0LWfH+OLfn8YTdFD1kmGn+X8JR763Z6V/vzMNupFCA0i3UVzHlg2Svd8UN7anfk2Y6VHBBrXVpprksJiCpNSWXVCGO75qqv9r2GJfxND4sLIir+8+ZVc4KBTujnHP0rhEjoBqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiC5BRd9doDeZF1C/3dFNib60gxlmB8DeIDTWhZJQXI=;
 b=RTwuGjyPo51EYyytbQNuk5DRW6HeRJ5BnJFX4CzKwFb1Jc1GwfK9N4sb3j58rJK4Tv1suJoQyoCLyUFeAra4xRJsefb3/WGiIAx2qmFSKqreMXdjcsJwRL5ln3hqThy5Gijjdm8iiX2yDejJ206PvS3fSPcoUCoZNAl4qtVAg4VP1uxqDXCvYTbianFbmjD/zyhYlJGm058a1PGRlgrpsZcpTj9krnvG0Ag8dvI9Nvo0mOA2hPPkEmDbeA7ix2lSq7yoDY/0MiNJpMyJkzmQ6IA9NuLBt5Rt57R650NrpIuRNwfwiNNMUeYtQ9ma3qbCLaJOP9PbKDpnBAAIVVLvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiC5BRd9doDeZF1C/3dFNib60gxlmB8DeIDTWhZJQXI=;
 b=VTb6Md5NkNE6T9U6J7QyH5XykmMzgBs/AB+Ty+ycMj/5/gbKIw4L8bvUHU0RNx78rb4WTwSYpKFuiOYzV851VjncrSSpLuUYQW5VgQQHWPd+8g+TOhr6txB8j9G6WAjMp0jnfAuM796YUfJ/SobBTQEjMp8FJlZjZ0a9/1MOcOk=
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM4PR12MB5166.namprd12.prod.outlook.com (2603:10b6:5:395::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.18; Tue, 26 Jul 2022 10:01:48 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::e4db:dd4e:4fe1:d32c]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::e4db:dd4e:4fe1:d32c%9]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 10:01:48 +0000
From: "Zhao, Victor" <Victor.Zhao@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/5] drm/amdgpu: revert context to stop engine before
 mode2 reset
Thread-Topic: [PATCH 4/5] drm/amdgpu: revert context to stop engine before
 mode2 reset
Thread-Index: AQHYnZ2V1EJIMKdkoEm3ZdHAPS29ca2PnTsAgADPYoA=
Date: Tue, 26 Jul 2022 10:01:48 +0000
Message-ID: <DM6PR12MB434019849BC0BBE9A76A792FFA949@DM6PR12MB4340.namprd12.prod.outlook.com>
References: <20220722073403.5171-1-Victor.Zhao@amd.com>
 <20220722073403.5171-4-Victor.Zhao@amd.com>
 <fbc20b21-8653-b162-fae1-76b8ba5cc3c4@amd.com>
In-Reply-To: <fbc20b21-8653-b162-fae1-76b8ba5cc3c4@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-26T09:41:46Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=36d70a46-0d47-4c2c-b1d9-398f60bffc41;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-26T10:01:45Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 68838b83-4250-4ea2-b678-4e988f95d1b8
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b0d0946-914c-41bf-00d1-08da6eeddaa7
x-ms-traffictypediagnostic: DM4PR12MB5166:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FoU6WPg+e65Mgfoe9TiCIkuR03pkGK1gxpG1+eunl9PqY/NJhIuXqFm/POvlf2VrqMPbQk/iILm+fGNsIGumQPHjf8VZukVwAO16fGMTWy3OLm1jWNDf086m2klqQYFl0hpyHmnqRCkaU3meYNOUf38jqHs+XAnQ0OYOAdyu4WNPoqme5cfSeQvBr6BoneEMFmnsN6rCTOIA1zEPRy3fyfQfp9lG8HeTKhx6GUEJLxKf8DVO/Cad0n5SdUcf0ivukhxnPSup52b2VInlCq7s2klfDuyM6O+J6Z7u7zt4ode6SgIW17HVmOoJmt+PVNiRKN2nijeJwLoSA8RqHxyftoX1B4+GjlaLAHrZ31o2HB02/+Vi7VwjQysd/kHzFAtLn2Xe8hFLQ6JQVUMK53ACTT1zK3qD+ptEFFp4Vs1Q4i7jA+nxeiS91BFR1FmhEuHCLfNwpGCVj4TJvOapFEn1cbkLeHnaglwidkzwlG1gUo+YZQQP6BGOR23cu9MO4gtOEt3YqP46plBuVE6x6yp+Z+v2MX8eatAZyNS70RxOeBKlFm6iwfCwiJE1q6gPGcUq4C7iTwEU/k4V5tA2SbdcvWJv4u9dLC/JPouabn8RKMfq7EnMYMVEByfZB7H+fyS2k0c2rtWVTqCKN1oS0Ai9OQqzHJINAs4Z4KEFenOj7xOrGUz0RYWtSrhGiy5/8zHSRqjRKbuq3eZnADRg4WhNAldnTBiKDPiXYAh4fL09HjAFZh8+2iAsNJoxHh7ra5xZYZmYylQ/SvSDvCtlBrXCiIJahoGie1sJLrstdU4UVulZ5ocqfguTLhEw4snRdNqA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(66556008)(66476007)(66446008)(71200400001)(66946007)(76116006)(53546011)(186003)(2906002)(41300700001)(64756008)(4326008)(8676002)(5660300002)(38070700005)(8936002)(55016003)(83380400001)(52536014)(478600001)(33656002)(122000001)(110136005)(86362001)(54906003)(316002)(38100700002)(9686003)(7696005)(6506007)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2NaMU5iUEErU1JDd0RiRFpuTmw4Vkk5RVZjTmJkcjRKblg1MjhFbG5OeTJq?=
 =?utf-8?B?eTl5MmV6YWsrQVlIRE9aVmdqb3BRc2t3RCtjVnFSMWtUTlI4VUFkRFdGV3pC?=
 =?utf-8?B?R0RzNzcrdlkwa1FGRUxtRlUyWUlReVRzcnkwVlMybkFDVW1HT2pLM05VYXB0?=
 =?utf-8?B?S3NiUHRvcmdtMU1JK1J4Z3pyME5Ud1VOcGJSQ25YTFQ4MnVuZWsydmxWa3p0?=
 =?utf-8?B?VlFlc3gwU0VBREZKbjcrQ1hJZFd0SDY0L2NIL25TQmF6TVBaTlhodWtXNXEy?=
 =?utf-8?B?Tjk4NXNZSEpHWnVlaS9wNzljVWVEWUtIVmE1SUVYTk1VT1lhd2lHck02aUdk?=
 =?utf-8?B?SHUzYmlYc1ZZMEFKeVJpTXVnWDhDcUloYi9Gd2ZMeEQySC9xc1BZQzBPZWhH?=
 =?utf-8?B?Y24raG5DZk1UVHpRcXdBQnBrV0hoSjVuOGZuTVlqT2RtdFhCS3dpSU9CRmt3?=
 =?utf-8?B?TWJTc0hEQWVabzlrSHdsMldodmVXVXIwVWVkWWU3RnllYzZFZ3J0bEtBT1U0?=
 =?utf-8?B?NGNUeldxOERlL1J6S0YzMXo3Y0xQUHo5bWZDSzF4ZWp0bVJOd3QrUkltWWxt?=
 =?utf-8?B?bkpkUUZYNDZMWDZ4WWRRS3RqMmFvR1NvQlpDRDlOVUFqTkJUKzRLRGh3U2R2?=
 =?utf-8?B?NVViU1Njd2hRUnpwMzlmZXJreTRXeXhLek1Yc1lRVlM5QmZuNURrMXRDS0pl?=
 =?utf-8?B?MTdnZjBRY2gyNlFLTGtIUDlFc3J4eFY4Y1VMZC9sbllCVVdYNHhyUzA1Smh3?=
 =?utf-8?B?WkNvczFyWnBsRXhTMHRzWVVNRGF5dGd3V2hZK090YUx5TW16TU9UTEkzaDh5?=
 =?utf-8?B?OE1pMVRmRk13WmoyUlZET0NPam9uUEo2MUNrUy85RXNYUzYzQnNscm1xY0RW?=
 =?utf-8?B?UUhNU09XRkpFUVV6WWdzWklaNERmaEFjak5uN0dTejBWbzJ4aVRPclVZOXRR?=
 =?utf-8?B?MmxHQVNXRllSYjFaclNjcFppaVFINUU2WWZtak5Vb2tNT2hSU0dUWUtkN2FO?=
 =?utf-8?B?Y2NvaTg2VStVL0JDSDVoTkhhdnYxdUM5UHRDaUsrVTkxLzRsWmI0QWFLSEo0?=
 =?utf-8?B?VVpvcnVrSWFnSlVpQXQreE1NZnZvVXdHNERNa1MzSTVrWlRpcDNlNElJM0x0?=
 =?utf-8?B?V3p1M2pHMlN0ZWtvdUhNanJ5enpMVjVTTW1JNXp0SllmQTE4eENtbVd0NXBK?=
 =?utf-8?B?TSsvek40cGdzWkJVQVBndGZpWklkRGxyS3dwV3o0RVZYZlJsa3Y3VHgvT2p4?=
 =?utf-8?B?TjluejBXTGFtTC9ybDE4cVJBdktra2RnWGFLdFJuK3UvZ0kwbXlUamU2SC9R?=
 =?utf-8?B?aHYzbHUvTm5mdVVCdlp4aHhScUEraFlCRU1jNHVJbWlWNGVGZUlNZUN4czdt?=
 =?utf-8?B?T1ljaUpvaTlrK21WNDhhTkFNRVpNNVpIYUVzTXZjMzdBdUxRUG9mRVVGZlpl?=
 =?utf-8?B?UHVGUTJ6L2h4Y2UydXR4eU9DMktMK2cvNlBrT3hVcU9PWGNPa3k0dXpzWU8v?=
 =?utf-8?B?cEdKQ0lwamh5MTlSQzlPVVBhOWs2Wm1aLytGamFReHA4MG9YVVlDSzAvWCtW?=
 =?utf-8?B?dkVjaHhDVWp6WGwrMy91aGhxZ2ozdXNGQUVNUDJCaHBzZUlqcllnN3d2eGNr?=
 =?utf-8?B?eDI3SzZrM3ZlQ1dXaWN6OVZ5ZlorT3BjTmNaZWwvVHJPc3A0aUpuZ0dHc0Ji?=
 =?utf-8?B?S05DZG92ZDdsaDhGVTZQOFovRzZuaGdoRlR4OWFGSEpNcU5QdXVQc3Q2UElF?=
 =?utf-8?B?b21ySERSdVd6cjBrcEVZVEN5RmFZNExmbmdLWU5hUFNlUE1wU2hUVE4zSFpH?=
 =?utf-8?B?QlZaNXEvSExtS0hXN0taTlc4Mm9FdlVPcVpxOURrZ25HWVJFaG4wQkpCRG83?=
 =?utf-8?B?amFKY3AxWlFVSzk2L0paa0ZoVUxyRmZyVStxTjhtTGZHcUVkZ2p1dWd1SmZX?=
 =?utf-8?B?OUFqNG5ScDVHc2VnUFVUWncvWXBKcUhHeHJvRTluRjhzRFpNM3hXeHVxQVZ6?=
 =?utf-8?B?UWpqamR2TWlLRHduU252dW5UQmlacUwxYkRwZkQ0SE5IdTQ5T3o2eTR5MnJ6?=
 =?utf-8?B?UDBTd1oxUHFXT1RrZ3p4bnNoclUvNndIUFFRdWVuaTZUY3ErTW1hTENvd042?=
 =?utf-8?Q?usdM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0d0946-914c-41bf-00d1-08da6eeddaa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 10:01:48.0716 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l1diPn2rMvA7Lal9mfJbn8lyfKQOcdh8oi9l0IdtyrZtKzM4BBKJPAOvG2BT0y27
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5166
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEFuZHJleSwNCg0KRm9yIHNs
b3cgdGVzdHMgSSBtZWFuIHRoZSBzbG93IGhhbmcgdGVzdHMgYnkgcXVhcmsgdG9vbC4NCkFuIGV4
YW1wbGUgaGVyZToNCmhhbmdfdm1fZ2Z4X2Rpc3BhdGNoX3Nsb3cubHVhIC0gVGhpcyBzY3JpcHQg
cnVucyBvbiBhIGdyYXBoaWNzIGVuZ2luZSB1c2luZyBjb21wdXRlIGVuZ2luZSBhbmQgaGFzIGEg
aGFja2VkIENTIHByb2dyYW0gd2hpY2ggaXMgbWFzc2l2ZSBhbmQgZHVwbGljYXRlcyBzdGFuZGFy
ZCBDUyBwcm9ncmFtIG1vdmUgY29kZSBodW5kcmVkcyBvZiB0aG91c2FuZHMgb2YgdGltZXMuIFRo
ZSBlZmZlY3QgaXMgYSB2ZXJ5IHNsb3dseSBleGVjdXRpbmcgQ1MgcHJvZ3JhbS4NCg0KSXQncyBu
b3QgYSBiYWQgam9iIGJ1dCBqdXN0IG5lZWQgYSB2ZXJ5IGxvbmcgdGltZSB0byBmaW5pc2guIEkg
c3VwcG9zZSB3ZSBkb27igJl0IGhhdmUgYSB3YXkgdG8gc3RvcCBzaGFkZXIgaGVyZS4gQW5kIHRo
ZSBydW5uaW5nIGFwcHMgd2lsbCBiZSBhZmZlY3RlZCB3aGVuIHJlc2V0IGlzIGRvbmUuDQoNCg0K
VGhhbmtzLA0KVmljdG9yDQoNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTog
R3JvZHpvdnNreSwgQW5kcmV5IDxBbmRyZXkuR3JvZHpvdnNreUBhbWQuY29tPiANClNlbnQ6IFR1
ZXNkYXksIEp1bHkgMjYsIDIwMjIgNToyMCBBTQ0KVG86IFpoYW8sIFZpY3RvciA8VmljdG9yLlpo
YW9AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hlciwg
QWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgRGVuZywgRW1pbHkgPEVtaWx5
LkRlbmdAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5j
b20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDQvNV0gZHJtL2FtZGdwdTogcmV2ZXJ0IGNvbnRleHQg
dG8gc3RvcCBlbmdpbmUgYmVmb3JlIG1vZGUyIHJlc2V0DQoNCk9uIDIwMjItMDctMjIgMDM6MzQs
IFZpY3RvciBaaGFvIHdyb3RlOg0KDQo+IEZvciBzb21lIGhhbmcgY2F1c2VkIGJ5IHNsb3cgdGVz
dHMsIGVuZ2luZSBjYW5ub3QgYmUgc3RvcHBlZCB3aGljaCBtYXkgDQo+IGNhdXNlIHJlc3VtZSBm
YWlsdXJlIGFmdGVyIHJlc2V0LiBJbiB0aGlzIGNhc2UsIGZvcmNlIGhhbHQgZW5naW5lIGJ5IA0K
PiByZXZlcnRpbmcgY29udGV4dCBhZGRyZXNzZXMNCg0KDQpDYW4geW91IG1heWJlIGV4cGxhaW4g
YSBiaXQgbW9yZSB3aGF0IGV4YWN0bHkgeW91IG1lYW4gYnkgc2xvdyB0ZXN0IGFuZCB3aHkgZW5n
aW5lIGNhbm5vdCBiZSBzdG9wcGVkIGluIHRoaXMgY2FzZSA/DQoNCkFuZHJleQ0KDQoNCj4NCj4g
U2lnbmVkLW9mZi1ieTogVmljdG9yIFpoYW8gPFZpY3Rvci5aaGFvQGFtZC5jb20+DQo+IC0tLQ0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyAgfCAgMSArDQo+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeGh1Yi5oICB8ICAxICsNCj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhodWJfdjJfMS5jICAgIHwgMzYgKysrKysr
KysrKysrKysrKysrKysrDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2llbm5hX2Np
Y2hsaWQuYyB8ICAyICsrDQo+ICAgNCBmaWxlcyBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspDQo+
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNl
LmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IGlu
ZGV4IDU0OThmZGE4NjE3Zi4uODMzZGM1ZTIyNGQzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IEBAIC01MDM3LDYgKzUwMzcsNyBAQCBzdGF0
aWMgdm9pZCBhbWRncHVfZGV2aWNlX3JlY2hlY2tfZ3VpbHR5X2pvYnMoDQo+ICAgDQo+ICAgCQkJ
Lyogc2V0IGd1aWx0eSAqLw0KPiAgIAkJCWRybV9zY2hlZF9pbmNyZWFzZV9rYXJtYShzX2pvYik7
DQo+ICsJCQlhbWRncHVfcmVzZXRfcHJlcGFyZV9od2NvbnRleHQoYWRldiwgcmVzZXRfY29udGV4
dCk7DQo+ICAgcmV0cnk6DQo+ICAgCQkJLyogZG8gaHcgcmVzZXQgKi8NCj4gICAJCQlpZiAoYW1k
Z3B1X3NyaW92X3ZmKGFkZXYpKSB7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZ2Z4aHViLmggDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dmeGh1Yi5oDQo+IGluZGV4IGY4MDM2ZjJiMTAwZS4uYzdiNDRhZWI2NzFiIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4aHViLmgNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeGh1Yi5oDQo+IEBAIC0z
Nyw2ICszNyw3IEBAIHN0cnVjdCBhbWRncHVfZ2Z4aHViX2Z1bmNzIHsNCj4gICAJdm9pZCAoKnV0
Y2wyX2hhcnZlc3QpKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsNCj4gICAJdm9pZCAoKm1v
ZGUyX3NhdmVfcmVncykoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOw0KPiAgIAl2b2lkICgq
bW9kZTJfcmVzdG9yZV9yZWdzKShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7DQo+ICsJdm9p
ZCAoKmhhbHQpKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsNCj4gICB9Ow0KPiAgIA0KPiAg
IHN0cnVjdCBhbWRncHVfZ2Z4aHViIHsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeGh1Yl92Ml8xLmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4aHViX3YyXzEuYw0KPiBpbmRleCA1MWNmOGFjZDJkNzkuLjhjZjUzZTAzOWMxMSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4aHViX3YyXzEuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhodWJfdjJfMS5jDQo+IEBAIC02NDYsNiAr
NjQ2LDQxIEBAIHN0YXRpYyB2b2lkIGdmeGh1Yl92Ml8xX3Jlc3RvcmVfcmVncyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikNCj4gICAJV1JFRzMyX1NPQzE1KEdDLCAwLCBtbUdDTUNfVk1fTVhf
TDFfVExCX0NOVEwsIGFkZXYtPmdtYy5NQ19WTV9NWF9MMV9UTEJfQ05UTCk7DQo+ICAgfQ0KPiAg
IA0KPiArc3RhdGljIHZvaWQgZ2Z4aHViX3YyXzFfaGFsdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikgew0KPiArCXN0cnVjdCBhbWRncHVfdm1odWIgKmh1YiA9ICZhZGV2LT52bWh1YltBTURH
UFVfR0ZYSFVCXzBdOw0KPiArCWludCBpOw0KPiArCXVpbnQzMl90IHRtcDsNCj4gKwlpbnQgdGlt
ZSA9IDEwMDA7DQo+ICsNCj4gKwlnZnhodWJfdjJfMV9zZXRfZmF1bHRfZW5hYmxlX2RlZmF1bHQo
YWRldiwgZmFsc2UpOw0KPiArDQo+ICsJZm9yIChpID0gMDsgaSA8PSAxNDsgaSsrKSB7DQo+ICsJ
CVdSRUczMl9TT0MxNV9PRkZTRVQoR0MsIDAsIG1tR0NWTV9DT05URVhUMV9QQUdFX1RBQkxFX1NU
QVJUX0FERFJfTE8zMiwNCj4gKwkJCQkgICAgaSAqIGh1Yi0+Y3R4X2FkZHJfZGlzdGFuY2UsIH4w
KTsNCj4gKwkJV1JFRzMyX1NPQzE1X09GRlNFVChHQywgMCwgbW1HQ1ZNX0NPTlRFWFQxX1BBR0Vf
VEFCTEVfU1RBUlRfQUREUl9ISTMyLA0KPiArCQkJCSAgICBpICogaHViLT5jdHhfYWRkcl9kaXN0
YW5jZSwgfjApOw0KPiArCQlXUkVHMzJfU09DMTVfT0ZGU0VUKEdDLCAwLCBtbUdDVk1fQ09OVEVY
VDFfUEFHRV9UQUJMRV9FTkRfQUREUl9MTzMyLA0KPiArCQkJCSAgICBpICogaHViLT5jdHhfYWRk
cl9kaXN0YW5jZSwNCj4gKwkJCQkgICAgMCk7DQo+ICsJCVdSRUczMl9TT0MxNV9PRkZTRVQoR0Ms
IDAsIG1tR0NWTV9DT05URVhUMV9QQUdFX1RBQkxFX0VORF9BRERSX0hJMzIsDQo+ICsJCQkJICAg
IGkgKiBodWItPmN0eF9hZGRyX2Rpc3RhbmNlLA0KPiArCQkJCSAgICAwKTsNCj4gKwl9DQo+ICsJ
dG1wID0gUlJFRzMyX1NPQzE1KEdDLCAwLCBtbUdSQk1fU1RBVFVTMik7DQo+ICsJd2hpbGUgKCh0
bXAgJiAoR1JCTV9TVEFUVVMyX19FQV9CVVNZX01BU0sgfA0KPiArCQkgICAgICBHUkJNX1NUQVRV
UzJfX0VBX0xJTktfQlVTWV9NQVNLKSkgIT0gMCAmJg0KPiArCSAgICAgICB0aW1lKSB7DQo+ICsJ
CXVkZWxheSgxMDApOw0KPiArCQl0aW1lLS07DQo+ICsJCXRtcCA9IFJSRUczMl9TT0MxNShHQywg
MCwgbW1HUkJNX1NUQVRVUzIpOw0KPiArCX0NCj4gKw0KPiArCWlmICghdGltZSkgew0KPiArCQlE
Uk1fV0FSTigiZmFpbGVkIHRvIHdhaXQgZm9yIEdSQk0oRUEpIGlkbGVcbiIpOw0KPiArCX0NCj4g
K30NCj4gKw0KPiAgIGNvbnN0IHN0cnVjdCBhbWRncHVfZ2Z4aHViX2Z1bmNzIGdmeGh1Yl92Ml8x
X2Z1bmNzID0gew0KPiAgIAkuZ2V0X2ZiX2xvY2F0aW9uID0gZ2Z4aHViX3YyXzFfZ2V0X2ZiX2xv
Y2F0aW9uLA0KPiAgIAkuZ2V0X21jX2ZiX29mZnNldCA9IGdmeGh1Yl92Ml8xX2dldF9tY19mYl9v
ZmZzZXQsIEBAIC02NTgsNCArNjkzLDUgDQo+IEBAIGNvbnN0IHN0cnVjdCBhbWRncHVfZ2Z4aHVi
X2Z1bmNzIGdmeGh1Yl92Ml8xX2Z1bmNzID0gew0KPiAgIAkudXRjbDJfaGFydmVzdCA9IGdmeGh1
Yl92Ml8xX3V0Y2wyX2hhcnZlc3QsDQo+ICAgCS5tb2RlMl9zYXZlX3JlZ3MgPSBnZnhodWJfdjJf
MV9zYXZlX3JlZ3MsDQo+ICAgCS5tb2RlMl9yZXN0b3JlX3JlZ3MgPSBnZnhodWJfdjJfMV9yZXN0
b3JlX3JlZ3MsDQo+ICsJLmhhbHQgPSBnZnhodWJfdjJfMV9oYWx0LA0KPiAgIH07DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaWVubmFfY2ljaGxpZC5jIA0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpZW5uYV9jaWNobGlkLmMNCj4gaW5kZXggNTFh
NWI2OGY3N2QzLi5mZWFkNzI1MTI5MmYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NpZW5uYV9jaWNobGlkLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc2llbm5hX2NpY2hsaWQuYw0KPiBAQCAtOTcsNiArOTcsOCBAQCBzaWVubmFfY2ljaGxp
ZF9tb2RlMl9wcmVwYXJlX2h3Y29udGV4dChzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2NvbnRyb2wgKnJl
c2V0X2N0bCwNCj4gICAJaWYgKCFhbWRncHVfc3Jpb3ZfdmYoYWRldikpIHsNCj4gICAJCWlmIChh
ZGV2LT5nZnhodWIuZnVuY3MtPm1vZGUyX3NhdmVfcmVncykNCj4gICAJCQlhZGV2LT5nZnhodWIu
ZnVuY3MtPm1vZGUyX3NhdmVfcmVncyhhZGV2KTsNCj4gKwkJaWYgKGFkZXYtPmdmeGh1Yi5mdW5j
cy0+aGFsdCkNCj4gKwkJCWFkZXYtPmdmeGh1Yi5mdW5jcy0+aGFsdChhZGV2KTsNCj4gICAJCXIg
PSBzaWVubmFfY2ljaGxpZF9tb2RlMl9zdXNwZW5kX2lwKGFkZXYpOw0KPiAgIAl9DQo+ICAgDQo=
