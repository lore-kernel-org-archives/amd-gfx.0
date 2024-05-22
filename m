Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6683C25B74
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 02:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0826B10E0DD;
	Wed, 22 May 2024 02:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0a5xfPgf";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8635B10E0DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 02:19:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMEIfIEh/tBxxheBBRBJLE2OSLiNWktjHf9bhA2uZdp2wHQsre85VIjSukTOlL3HwjcClSNQa5d/wKd8EqtBK6CRzcLbnPtzaMcCPSVxirTCAEALWPdcsbNkgLl0Y5jCMoJFmviefQMwC16gTE/mwG5Gp6yheftHYD+0iC8MVc1mPcAweYtjVaqo4S4R9voejrt2m1mvJw7gR72PN7drbUyloIXcZ5ELmcqjZ2XNbuZigUmmqTrRpd/rX2Q1RjjPz7zPWv/sj40m7CzSg5A+Ri0doPZ7iJjMI4bm/Fd3oS+eIBKbftHzFbFewUVarBsSqSXQOlTTZizaWLML19Bz/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fkw+ri9I/OnWl4fjPjx1D1mpjCr23CUyzPa1ShUIfI8=;
 b=klL+wOAnUwPBxia+m9v8Cs4CJPho3jSLPo3lW+542jjcAn/UT91fuqRuljb2z6oP1y4Q3Hm2ZiNl7T6TF0M2moacPe3dStqBtpU/qBO2OWG9hxaX9+Zt/zXyM7mr1pYIiN7wiDbjff57fASm+HoM79TILy0k3RLF4cdqoZ3hfyM/h7th9g2RXAVWO0H2qIF0oAIDRctde9o8DkY1+bV56azNL1EVJQQR2fQyIP02o0S1Lx2WxqsyQHNaMw+KaBuqwp0bHAM8sxemiezwoSgQCTcoMfT0LlyuPcHYbdTJ6KX/Nd9gV7cW4ptAUaB+fVimcNx5yd3HDq2Wc/JwzPfDgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fkw+ri9I/OnWl4fjPjx1D1mpjCr23CUyzPa1ShUIfI8=;
 b=0a5xfPgfG5YmIl2M1e/WJYwI1Y/6KWSoGm/bbUi0VEDDFgq6ttnv/kjR5hgG1KCjOC5oIgOqZjbQcD4tAMMjD19IK06w03h3FrR46CEGeMT2p5pl6wUyuhFdtQlpCbu9Bm8fhrvnDbRklUcSMRAYy6p0QUp7fIaJJcroKL5VGUU=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 02:19:46 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%3]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 02:19:46 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>, "Yu, Lang"
 <Lang.Yu@amd.com>
Subject: RE: [PATCH 1/4 V2] drm/amdgpu: fix invadate operation for umsch
Thread-Topic: [PATCH 1/4 V2] drm/amdgpu: fix invadate operation for umsch
Thread-Index: AQHaq07Lb24SFgqbAkaWcPgII0ChSbGhWM0AgAEtOhA=
Date: Wed, 22 May 2024 02:19:46 +0000
Message-ID: <DM4PR12MB515252901B1002704C2B56F5E3EB2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240521071615.371277-1-jesse.zhang@amd.com>
 <1d4223d3-b4e5-4c02-8da7-ab87406d5cc3@amd.com>
In-Reply-To: <1d4223d3-b4e5-4c02-8da7-ab87406d5cc3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d6af3bb9-9b51-4a6a-b106-86254bc5b766;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-22T02:18:23Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SN7PR12MB6863:EE_
x-ms-office365-filtering-correlation-id: e3b42604-1509-477a-551c-08dc7a05a66d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RGZSUkJPSHJtRHlmVUU3cUpxdFBEOEdXQm9veTFFbG9SWkRvd1kxUGJaeVE5?=
 =?utf-8?B?a3VWdWVUZElXUTF4TWgyYUY4QWFJSWl1UGhkQVh5d04xQlRjTkNzOXRzS2hL?=
 =?utf-8?B?a3BBbU95TVZtUjM0SmdhTDVvcHkwTUtLWFpveWNXTmxxWUdMMkVpWDlSUjNF?=
 =?utf-8?B?VmNFcGx5VGNLTW5oc0IyT2tiV1YwYjZMaFlDVER0TFp1L0hJL3NZUmtMUWx6?=
 =?utf-8?B?U3k3N3JmZGdqL2ZyMzBaTmNpOWorTUVpK2crTXhEYWo0VTM5VG15ZzF1dENt?=
 =?utf-8?B?ZkQzaFhvQ1JTWG1xUUxlU0ErcndCbXovZHlGK2RpWm5kQU5nZ2duOGpJVHVj?=
 =?utf-8?B?VzRmaHIvL3I4QzdRSmhRa1J6dFIrS08vWnNEQ1BrY2ZFYzZLcnBSeDlwejl0?=
 =?utf-8?B?eFdUR0FLanVoUWw0Wm5zc3B4YmpRTVYyZmtIZ0U2MmJHMkFGeCt0Wi85YVVl?=
 =?utf-8?B?WDNESEJjT2o3RmxWYXgyd1FubVBzSjFtTlNEWVgzM0RjOS83Mk9Ea1AzWTV6?=
 =?utf-8?B?RXhWU2VsY2xsaXpzSHEyN3pEU2hwOXp2bXhITWhCWTJNRzVkL0J5ZDRETCs0?=
 =?utf-8?B?WDVNSWliTE1Ha3lXQThCdmI2YU1NbXQ2NEhZYmpadGFzTkxhLzZUV05OM3FO?=
 =?utf-8?B?eXFRcEwvdHkwUEZtb0pmZFpSbUJEa3Bvb1p1QVFNVG1xdk5qSDhUSTVyQmRX?=
 =?utf-8?B?Y3lxVzBVYW56YmpoWmZUeGx5aXNJMzRDWWVDd0RMWVN2VmhSVURpc294a01w?=
 =?utf-8?B?Z0hHeUlJSkNoaVdSVDV6UERpaUZYelF4Sy8wTjU2NkdtQWVydEhTU2VNOVd4?=
 =?utf-8?B?M0svM3RNc0FzSk5oekZ2bjZPdjhpbnI4amJGblFTOEhwUG01bTg4dFNTQVlz?=
 =?utf-8?B?NlFBUm9ZdjdnNTBnQTA1MzlkVklZZ0RhNnR4Q2xiSWdWdk1ndCtZN2dFVHFK?=
 =?utf-8?B?aWtvT1VFNkNIQ1Q1NHpNa0Izazl6VzU3VXBCWExJRlAyNWJrNHpScURhUzU5?=
 =?utf-8?B?Z2t5bkFjVXpWakhHVGltMHJ6M0djbjFzTFBuTGFPVDRpYXM5Ti9LRUVCWW1J?=
 =?utf-8?B?YXlCcnliaktFd3ZRa2VZdUc0bnlWdEp1Tm05V2daclYzTDJnV2h4TkxWbUI1?=
 =?utf-8?B?RGY0eGxFNndsT2Y2c05xaG1NWnUxL0F3MXpyQXJiOHVqeGlPYTRVRGxON21a?=
 =?utf-8?B?RUR6VDJpeU1jL0YyY05GMjV4d1dVQ01nQ3lFaCs3VTYvTVplUWNqQUR3cUtU?=
 =?utf-8?B?dnFabU94dE9BNFpJK1Bad3UyZWxiQVl6T05mYVFuc1BLeU4valdiWkt3NXdi?=
 =?utf-8?B?ckUwZVdocWlodDRxd3JHL1hrSzJ0MUl5YU9lSUphT3htRTVkZ2E1OXRhRTJ6?=
 =?utf-8?B?OHpZRHhacjR4RzV1dUhKYUdIcWFqSDIxazJRQVhVRHN4VjA0N1k2Q2NSditY?=
 =?utf-8?B?NHVZS2xQdTFKRWZPVWpVOXNtdjFES3lHOEw4Um0xWE05cThGUkJsOWVkMzZ6?=
 =?utf-8?B?WkVTVk91RmR1TmtHVjVVOVFEWE52Z21QMWpsamxpVEF2KyttaS84NDE3Tk15?=
 =?utf-8?B?REpOM0dJWE4vK0JFdGcrNVlUdVNqSnBlbUdBWWN1T0xmM1hCWmxFaG5rMWti?=
 =?utf-8?B?L2VBckdzMGRLSWtPcXZKaTJ6NElJSGM1ZFFKT0JpZG8rNTRxblYxT29tSVFI?=
 =?utf-8?B?UDZsZlArcjgrVXN6U2M4UXhnNWVUOUhGNUJKRmhObmIyWldPMDdIb01ZZXJX?=
 =?utf-8?B?akFaREM4QzJwZWpzaVFTZnZ2QzJHY1lOTGxDenpvbVdBWXJnM0xTaktYTlp6?=
 =?utf-8?B?MHZDdmhvWHR0TG9Yek11QT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFB3MGFJc3hENVhITHRyZDdpK1ZXNzM2NW9FNDVFV3p1V2tWOVBnZ3RVakQz?=
 =?utf-8?B?MkFEa0N5T2cwM3hvSzh4em9ySVp5UG9JV0ZpVWlUaG5OR0hKOTdSc2lFRzZu?=
 =?utf-8?B?b1FBNGl6c1VORHh3TnBGV2F5NjRHazRmQkdoTEtlaDd6a1FSOEVIZlFvZ0o4?=
 =?utf-8?B?RkhQeUo2bzc2S1dYRTlXOXpielFrYS9BdnRsZnk2d0x3V1hPNmtlVVhsTmJu?=
 =?utf-8?B?clNCa21rd05MUnVnOWwzeUJ2bXR4TmQ5Y0hWY3N4eTkrbEMxN09TUU8yWjdC?=
 =?utf-8?B?b1A1dTE0QWNBNWlJSGhQOS8yQXZTa2V3WXlpdlAyWENPWmZGayttV3h1T3hK?=
 =?utf-8?B?UmoyK0JsQklVMWFEdklPNHpZNXBuTzg4UDhIcC9yc1E1VXJlVVBPWU84NDV0?=
 =?utf-8?B?SStqZmtUbGU3Vm5sUnRNZ3ozSU5kQStPTFRVN2Q2b0t5SzhsSHI1ZCs0VW1J?=
 =?utf-8?B?NzRWQ3lSakZUSXQvRmV6UGZRWGwrMHJ2d0VVMVdQcmVIeXhXUTNQNldSREdB?=
 =?utf-8?B?aTNmWklUSHVmTUZYaCtZc2Rqc0oxandYQmlvZFlYaHQ4cTBRbkJzcnRsVTEy?=
 =?utf-8?B?RlhXVkpvZUxwaHhKdURjekpuaTZvRHBCSXE4YStPdjUyQzF3aWFNVUNINWpE?=
 =?utf-8?B?YmkrOE1pMG9lcW1jL3JPUlRGNy9aR216ZFNROUF4K2pId0VwWGxwNWhqcEFx?=
 =?utf-8?B?U0VySmRrdFdXby96QU5Dc1hQQkgrNGtNeVlhRk4zbm9JVXRoeGY2YkdkNFpl?=
 =?utf-8?B?ZEV0YXptT0wzZWMwSDByYTBmWWhBODlTcTNNOVZPaVZGTEo4YVlYcW8rT2VB?=
 =?utf-8?B?T3NVdFpuQ0dkVUZDL2pxM3JucThNT1ZBc1ZoNTlpRld5TVBKMnE5RnZLb0dE?=
 =?utf-8?B?YTJMTGNLMUEwRG5xb2RpN0hBdFFBQStYQTkvU1BIMkM5ZVM0aGxYNVJRTUtt?=
 =?utf-8?B?a0VibW5YaGJzV25oWEdxOHJzYktzT2lObWxreXJZUTlwWU04a1MzKzBEbXBY?=
 =?utf-8?B?YjQ0cjVkQ1BHdGkrODFHSTAveUN1bGRNRUxZWWpjWXJ1VWxXUmh1ZS9mMlRP?=
 =?utf-8?B?VVVYbEplUXVzWDY5anF4ZWdrSGlia2VrdW1BcWFoSWhlVXBmK0tZM0NieGhq?=
 =?utf-8?B?enBrQVpyL3FSYkpWbzdNaVBsVlM3bWRleWdWdnNQVnZqVlk1a3dTVnJabWpJ?=
 =?utf-8?B?ZzMwUE9VTFk4OTIyaUphV0VXMmVhb0FZaTVIYVlUZittWjJXSkJ0YmtrUlRa?=
 =?utf-8?B?dGdFai8yZ0VmUGhMZ2NZL1E1N1E4UHZnV0NFUy9LY3FRK3QwbXQ2T3NoZDl0?=
 =?utf-8?B?MmlpU0g1TVl2UEkzMndmMHZmcktBN3JCQ0txNHluUGlZUEQ0OHhsdkVqK0Ny?=
 =?utf-8?B?SHYyRFhJekdHYjFDUUkxc2xMbVZPRWdWRG55eEpFRWg5eUVKeWtCWEFTYXEv?=
 =?utf-8?B?TGVnblhVaU9JWUREbWRJWTJrUk9mTFRhSXhGL2hVNVd4dWpzdU8yK0VDWm9W?=
 =?utf-8?B?M0lJMm5id1FqNTgxSURiZ3NRa1NaOFZ6alFlbEJqenVpUXlQT01uM2I0UXIr?=
 =?utf-8?B?TnlqTGJZcEtMdm0vcXBnZlVsUm5CVVQ1c2htdHpsZlV2ZXRRWHBRY1ZWcnVB?=
 =?utf-8?B?RFpJRE1YU3JtVW1UQUovbXMwZUorcWszUzNoWFkrUFJVYklDNkk5WFVMTUdh?=
 =?utf-8?B?cDA4Z0prVUxmZmNVWHVsdW1ZMnJEc0RVNERHS3JTOTNVUjRYcjhCaWdhaTYr?=
 =?utf-8?B?NjVBWERQMTk0UFNWYm5idnZXbWJKbGR6SFA1N2Q5RGJxOER2OHQzdVA1bEph?=
 =?utf-8?B?UHBPaWtBVm95UXl5U1ZOWkJiT0lVSUNNemtBMlhwbkFvSTNnVGM2QStYL3Na?=
 =?utf-8?B?bkR4Ym04Tm1aSW1yTFJnMUJtT2VlemxQd2RoTFJuRWZ2b3RBTFRHSHVTd1lk?=
 =?utf-8?B?RFd5QUlvT0w0azVNRnVPYzRyWmtlb2NyeVNwWE5XeEo1Z1djNUgreDdPOXlm?=
 =?utf-8?B?MC9IK0l0TUVlVnlPakJzbHoyZG1qamV6a1NUN3FKeGNyTGpCT2Y4eUlwczRJ?=
 =?utf-8?B?OVNwOEJPVlNrcEJ5ZGhsUHRaOFEvd3F4TXdRMDNuS0twSXVWUThNZE5iRjly?=
 =?utf-8?Q?3IpI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b42604-1509-477a-551c-08dc7a05a66d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 02:19:46.5098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wipAqFzozl1ju0NOQn1wRA2ydmi1Q55mV+rCQvhA2OcfHI+umXJfV3mTdRuKtw6RKLQVv//hZ3Xr/Z86zGw+ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863
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
Cg0KSGkgTGlqbw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGF6YXIsIExp
am8gPExpam8uTGF6YXJAYW1kLmNvbT4NClNlbnQ6IFR1ZXNkYXksIE1heSAyMSwgMjAyNCA0OjIw
IFBNDQpUbzogWmhhbmcsIEplc3NlKEppZSkgPEplc3NlLlpoYW5nQGFtZC5jb20+OyBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVy
LkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFt
ZC5jb20+OyBIdWFuZywgVGltIDxUaW0uSHVhbmdAYW1kLmNvbT47IFl1LCBMYW5nIDxMYW5nLll1
QGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDEvNCBWMl0gZHJtL2FtZGdwdTogZml4IGlu
dmFkYXRlIG9wZXJhdGlvbiBmb3IgdW1zY2gNCg0KDQoNCk9uIDUvMjEvMjAyNCAxMjo0NiBQTSwg
SmVzc2UgWmhhbmcgd3JvdGU6DQo+IFNpbmNlIHRoZSB0eXBlIG9mIGRhdGFfc2l6ZSBpcyB1aW50
MzJfdCwgYWRldi0+dW1zY2hfbW0uZGF0YV9zaXplIC0gMQ0KPiA+PiAxNiA+PiAxNiBpcyAwIHJl
Z2FyZGxlc3Mgb2YgdGhlIHZhbHVlcyBvZiBpdHMgb3BlcmFuZHMNCj4NCj4gU28gcmVtb3Zpbmcg
dGhlIG9wZXJhdGlvbnMgdXBwZXJfMzJfYml0cyBhbmQgbG93ZXJfMzJfYml0cy4NCj4NCj4gU2ln
bmVkLW9mZi1ieTogSmVzc2UgWmhhbmcgPEplc3NlLlpoYW5nQGFtZC5jb20+DQo+IFN1Z2dlc3Rl
ZC1ieTogVGltIEh1YW5nIDxUaW0uSHVhbmdAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS91bXNjaF9tbV92NF8wLmMgfCA1ICsrLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdW1zY2hfbW1fdjRfMC5jDQo+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvdW1zY2hfbW1fdjRfMC5jDQo+IGluZGV4IDJjNWU3YjBhNzNmOS4u
Y2UzYmIxMmUzNTcyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91
bXNjaF9tbV92NF8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdW1zY2hf
bW1fdjRfMC5jDQo+IEBAIC0xMTYsOSArMTE2LDggQEAgc3RhdGljIGludCB1bXNjaF9tbV92NF8w
X2xvYWRfbWljcm9jb2RlKHN0cnVjdCBhbWRncHVfdW1zY2hfbW0gKnVtc2NoKQ0KPiAgICAgICAg
ICAgICAgIHVwcGVyXzMyX2JpdHMoYWRldi0+dW1zY2hfbW0uZGF0YV9zdGFydF9hZGRyKSk7DQo+
DQo+ICAgICAgIFdSRUczMl9TT0MxNV9VTVNDSChyZWdWQ05fTUVTX0xPQ0FMX01BU0swX0xPLA0K
PiAtICAgICAgICAgICAgIGxvd2VyXzMyX2JpdHMoYWRldi0+dW1zY2hfbW0uZGF0YV9zaXplIC0g
MSkpOw0KPiAtICAgICBXUkVHMzJfU09DMTVfVU1TQ0gocmVnVkNOX01FU19MT0NBTF9NQVNLMF9I
SSwNCj4gLSAgICAgICAgICAgICB1cHBlcl8zMl9iaXRzKGFkZXYtPnVtc2NoX21tLmRhdGFfc2l6
ZSAtIDEpKTsNCj4gKyAgICAgICAgICAgICBhZGV2LT51bXNjaF9tbS5kYXRhX3NpemUgLSAxKTsN
Cj4gKyAgICAgV1JFRzMyX1NPQzE1X1VNU0NIKHJlZ1ZDTl9NRVNfTE9DQUxfTUFTSzBfSEksIDAp
Ow0KDQpjYzogTGFuZw0KDQpUaGUgb3JpZ2luYWwgcHJvZ3JhbW1pbmcgYW5kIHRoZSBuZXcgb25l
IGRvZXNuJ3QgbG9vayBjb3JyZWN0Lg0KDQpJIHNlZSB0aGUgYmVsb3cgZmllbGQgZGVmaW5pdGlv
bnMgYXMgcGVyIHRoZSBoZWFkZXIuIEFzIHBlciB0aGlzLCBib3RoIExPL0hJIGFyZSAxNi1iaXQg
ZmllbGRzLg0KDQp2Y24vdmNuXzRfMF81X3NoX21hc2suaDojZGVmaW5lIFZDTl9NRVNfTE9DQUxf
TUFTSzBfSElfX01BU0swX0hJX19TSElGVA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4MCB2Y24vdmNuXzRfMF81X3NoX21hc2su
aDojZGVmaW5lIFZDTl9NRVNfTE9DQUxfTUFTSzBfSElfX01BU0swX0hJX01BU0sNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAweDAw
MDBGRkZGTA0KDQp2Y24vdmNuXzRfMF81X3NoX21hc2suaDojZGVmaW5lIFZDTl9NRVNfTE9DQUxf
TUFTSzBfTE9fX01BU0swX0xPX19TSElGVA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4MTAgdmNuL3Zjbl80XzBfNV9zaF9tYXNr
Lmg6I2RlZmluZSBWQ05fTUVTX0xPQ0FMX01BU0swX0xPX19NQVNLMF9MT19NQVNLDQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHhG
RkZGMDAwMEwNCg0KW1poYW5nLCBKZXNzZShKaWUpXQ0KDQpUaGUgY29kZSBzZWVtIHRvIGFsaWdp
biB3aXRoIFdpbmRvd3Mgc2lkZSB0aGF0IGhhdmUgc2FtZSBpc3N1ZS4gSGVyZSBpcyB0aGUgd2lu
ZG93cyB1bXNjaF80XzAgd3JpdGUgcmVnaXN0ZXIgcmVnVkNOX01FU19MT0NBTF9NQVNLMF9MTy9y
ZWdWQ05fTUVTX0xPQ0FMX01BU0swX0hJDQoNCmVudW0gdW1zY2hfbW1fc3RhdHVzIHVtc2NoX21t
X2VuZ2luZV9pbml0X3Vuc2VjdXJlXzRfMChzdHJ1Y3QgdW1zY2hfbW1fY29udGV4dCogdW1zY2hf
bW1faXApIHsNCiAgICAgICAgICAgICAgICAuLi4NCiAgICAgICAgdGVtcF9kYXRhID0gKHVpbnQz
Ml90KXVtc2NoX21tX2lwLT51bXNjaF9tbV9mdy51Y29kZV9pbmZvW2Z3XS0+ZGF0YV9zeXN0ZW1f
c2l6ZSAtIDE7DQogICAgICAgIGRhdGEgPSB0ZW1wX2RhdGE7DQogICAgICAgIHVtc2NoX21tX2Nn
c193cml0ZV9yZWdpc3Rlcih1bXNjaF9tbV9pcCwgdW1zY2hfbW1fcmVnX29mZnNldChod2lwX2lu
Zm8sIHJlZ1ZDTl9NRVNfTE9DQUxfTUFTSzBfTE8sIHJlZ1ZDTl9NRVNfTE9DQUxfTUFTSzBfTE9f
QkFTRV9JRFgpLCBkYXRhLCBIV0JMT0NLX1ZDTik7DQoNCiAgICAgICAgZGF0YSA9IHRlbXBfZGF0
YSA+PiAzMjsNCiAgICAgICAgdW1zY2hfbW1fY2dzX3dyaXRlX3JlZ2lzdGVyKHVtc2NoX21tX2lw
LCB1bXNjaF9tbV9yZWdfb2Zmc2V0KGh3aXBfaW5mbywgcmVnVkNOX01FU19MT0NBTF9NQVNLMF9I
SSwgcmVnVkNOX01FU19MT0NBTF9NQVNLMF9ISV9CQVNFX0lEWCksIGRhdGEsIEhXQkxPQ0tfVkNO
KTsNCiAgICAgICAgICAgICAgICAuLi4NCn0NCg0Kc3RydWN0IHVtc2NoX21tX3Vjb2RlX2NvbnN0
cw0Kew0KICAgICAuLi4NCiAgICB1aW50MzJfdCBkYXRhX3N5c3RlbV9zaXplOw0KICAgIC4uLg0K
fQ0KDQpUaGFua3MNCkplc3NlDQoNCg0KVGhhbmtzLA0KTGlqbw0KDQo+DQo+ICAgICAgIGRhdGEg
PSBhZGV2LT5maXJtd2FyZS5sb2FkX3R5cGUgPT0gQU1ER1BVX0ZXX0xPQURfUFNQID8NCj4gICAg
ICAgICAgICAgIDAgOiBhZGV2LT51bXNjaF9tbS5kYXRhX2Z3X2dwdV9hZGRyOw0K
