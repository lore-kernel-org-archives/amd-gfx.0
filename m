Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D382CC25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 13:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 134F5113AE6;
	Wed, 29 May 2024 13:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MyXBt6Wa";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FB0C11229B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 13:45:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1fzXdegUBBB+nUdYMtVP5PO09XtUJ19T95xHDVVW3eDsexYdYV4vYQcwyxoCADXnNgt2K6Rba57I3NWcKToqA6g5CNs2tLNu4TKl/+LOLvy5GwCc194Hd+iQmngCKbK258SYcNwnA37fHbjRX9k4IobtxoHcsKcL1UEA6av4U4MTOQMC5KDqpJhyfXk1BFs7EOUHzPFdAH/TdNzhwfhiiLKZXJ7Z8BNlnIdBP/qGUv0dW2+nqFSAhyfyusi4Gz9ALuRe+GefEbCGjfc6SDEJ6AsiEd+whQuPGAzqyjnD9FgMvys1Cfo6rj8Pio2uxMUJ0ieKm6Mi+5jui2TQ5xsKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmBKIhgwqXOWnnJNwTm45r9ZU7yDhr3iF/8fz/Z81CI=;
 b=bjYSIHx4yGLxgKt7OdQXSTByJBg7TGL6qcUFv+gcuO+/eru7bXzIrOnj1DwnzZtdsuORyhQdNuGBqM8hMEpF/ZJmynclD4jn4AzXy3u0AfPamaY5oqzIIcxI70NGGrzSLu8lutjIMYK5hbX/f9SfS7B3Q1J2UVDajJTr1lNfiZgQVBsviTnEYguGlkfpJFevuXpf0ku+lLFQSVyl7OB2k6nZ6nmBKHFCzGN/uVOLTt3okpbl7cGLi4dzez/Zou5PUJFagwHovwwZjvNSeNmN3LMFSFMZTBWBHU+PUKkN/96ZX4QQVZYnhG1lLLbm5b91V3BvRfbBJOa4y4s9fwcOqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmBKIhgwqXOWnnJNwTm45r9ZU7yDhr3iF/8fz/Z81CI=;
 b=MyXBt6WauGORnlC6mWdlLA+dFXdPd0V0ApPV53ydEXusfzJ5mkv2DUmqERk+VBgKBELYdgsgoLNfPgcyV6bABRYX2rTq2PxU0bJEARiJJRLD8QJk6sOKvQqDeEdo1KaTRAzpxEry21j01vjqp5WGhUvVSrUg8a0hwjK/M1cteRA=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by DS0PR12MB9323.namprd12.prod.outlook.com (2603:10b6:8:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 29 May
 2024 13:44:54 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%4]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 13:44:54 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 03/10] drm/amdgpu: abort fence poll if reset is started
Thread-Topic: [PATCH v2 03/10] drm/amdgpu: abort fence poll if reset is started
Thread-Index: AQHasSPj5dWiHd7YP06y4F37f071D7Gtw2cAgABr2bCAAAeagIAAAj7A
Date: Wed, 29 May 2024 13:44:54 +0000
Message-ID: <SA1PR12MB85996538350B30F80330C0EAEDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-4-Yunxiang.Li@amd.com>
 <32ab9756-ca28-4ec0-919a-1d1df950aee7@amd.com>
 <SA1PR12MB8599F850C7BD44B5F66D80E8EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <a1e40066-f980-4490-a0b9-d8f3be34ad8f@amd.com>
In-Reply-To: <a1e40066-f980-4490-a0b9-d8f3be34ad8f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=22da0570-b42b-401a-8314-3fde82147db1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-29T13:39:53Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|DS0PR12MB9323:EE_
x-ms-office365-filtering-correlation-id: 4979c9d0-67fd-4573-e326-08dc7fe5859b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?aTZWN1VjWUZuOXlrWi9qNEFEMWpxdU51bTVTcmtncHlGWHVGNytWSlp3NU5V?=
 =?utf-8?B?ay9yTmdFYXd5eUFtT1dIMkRqbjBPOG5qQnRTTmg3QUN6OStVWm1OTFdyWnlH?=
 =?utf-8?B?d2h0TEoraUpCa2JWQnAxTm02VFBCWDdBamtSTkpCd0E5R3U2ajdiOHRKZGJm?=
 =?utf-8?B?bXNERXc2ME4yaThvWG1vdjhwMi9FWks0bCtkeWJEYkwwVU1wMENXbUsrcENZ?=
 =?utf-8?B?M1pYQlZEVE1KajI4KzNJQlVqWEFYRytacUhaOXNEYitlejlXZE9xS0l5Rysr?=
 =?utf-8?B?MmtURUlWSytET21SUlFGV1cvYnR5Z1dqRUZvc3YvdzF3ZkRoV0VGK0N0aVZs?=
 =?utf-8?B?c29FWUNVMitPNlZYMGZGMmt1aE5ZUm9pNWNTRzZwU1EveTZSSmloUFM0SXo1?=
 =?utf-8?B?b0xKWFM5UkRRazc2TFlob0lERU5zSERTMWpzaXVQVTBOcjZtYkx3VXYvdUxG?=
 =?utf-8?B?Yjh5blFHaWdaQjhmV2NQQk53Y1prVGE0YzNVbVlHd2lpQTFtbWRMVVpPWDE5?=
 =?utf-8?B?NkZ3akNoTTBEVHRmb3l5ZUsyOXE4N2c5Sithajg3R3R5eWZDSHYzUlpjQklS?=
 =?utf-8?B?R1lmcE50SnUzOTZ2Vk5UK0tTS0t6SEYzZ25NWEcydUJscmpkWkV3ZGU0MktN?=
 =?utf-8?B?dVJUU3poTk9jTGZLbnM4ZWlWcE9ZOTdEbFFMMzZ1QUJTZXFkZkYwOE1IYTBE?=
 =?utf-8?B?K2poUDFiZTZqTGFLLzlWazRaczZ4NDF6T0lGMnVoaFkxSUVxUVUrekFjUVhj?=
 =?utf-8?B?YmZvR0xGeVRPK0ZXTzk2d2ExeUUyczR0L2I4SnpoWmcyVEpXMGVYNEZ5SXdQ?=
 =?utf-8?B?YUY5aCtZREcrSE5xUllpcWg2L2pSb29DT21tVjNNcGR1RVRJVUxjTkNRUDBM?=
 =?utf-8?B?SCtNaE12ZzBhVVdvQVc0TkJxRzJLMFJzczlYWUpCekVHQXQ0SFVvYnBJMmNh?=
 =?utf-8?B?RTdSaktaczRzaVJqUWhJUjdqenFxWEVTcXIzRXI0WkFicHl5VURWUXI2N0FR?=
 =?utf-8?B?OEFWUk1mMFVtTmhPWjgySkNudlVZQmx2U3RYdDN3clV5bDZ2NVdKdldmdUVE?=
 =?utf-8?B?VE90N25mRzZRL3FFVy8vU3lWOStVcktvTHpXVGh2Lzh0czZxMUozVy93Q3Yr?=
 =?utf-8?B?OFoyV2RQSXZDZG45Z0cyeTdkWVJTTjlHWldzV1VyNUdLWitlcDRLSndqN25S?=
 =?utf-8?B?L1BORlRXenNIakxHVEVzQW96aTYvTnBVc1VMOVV4ODdaUi9kSFU2UERxaXcv?=
 =?utf-8?B?a3Izc3A1UDhJS1N4ZzQ5K05INWdRYnFxTjJmUVlyY3BtK2YyUC9tYU9uSmJ5?=
 =?utf-8?B?WTBNenFJb2xrU29jWFE4bUFSK1RDdDIyeGtqZGwybEtCbTVvRUN1cWFBRm42?=
 =?utf-8?B?Ly9pL1p4dGx1S2ZYdThRc1g4Q2JmdmlvWXZFOVhjZEhLQ1V5MHRRY0czWDJr?=
 =?utf-8?B?bHhjakpWOVV3UFBHUklldG1jZ0FralNFOERMclNsMW9VUENtRVJLOXlXWEcy?=
 =?utf-8?B?WHo1K0FNZWI3dldpZ2pCVzRsWlZVSE9aUGgxN1lqMVNESksxWnl2Yk5WZzRG?=
 =?utf-8?B?eXJTeENtbEVLd2JZM1hUT2pSbzVDRXFEaHB1bW5YWC9PSzg5RTVYMDhFaGFw?=
 =?utf-8?B?cEpkUGxVWFhyQkpmQUFoL0t6REZhRVpvL2FLRTlYN2s5Qzk2UjdkTUEyOHRC?=
 =?utf-8?B?NHpuMmY0M1NOeTZpY0NLQlh2MTl3UEF6dHlVdE5HYVZSbnNKL3FpVWVFY0Jt?=
 =?utf-8?B?OGcxS1RmSWxYdE5hMnZHR0R6N3o3S2x5RURuZGtma1dnMG5hSVcwbUZhMFFS?=
 =?utf-8?B?bnMzYk1BQmFzMGI0REdOZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWNIQzZ6SE5jbFpBbE5BQi91ajduNEhHNzlhdnMwNmFsTmQwcXNSZHVKMG1R?=
 =?utf-8?B?Y1JHWEt3b0Nma2pzdFk2NDJKK2ZBd21NSzIzaTA2eVVQSEVSSDJUeEpsb3hM?=
 =?utf-8?B?dVZQczJtSDd1NDJSUWtwZ0FNMHd3VUpCZXZINzBlcWVjd1owVVFiNnlaaFJJ?=
 =?utf-8?B?UElXUEU0S2xNRHEwNGRvZE1ObWhvTDZxblgwL2t1MTFwYU9vdnE3NHplRzdy?=
 =?utf-8?B?NXVSMjZCSUZVbDR4SXhuVmNJRCt4MFhQL1FFaHpPKzFQWW1ybnp0c2tyMC9w?=
 =?utf-8?B?L3NVM3ZibWQyVFU2dk1TcUhoN1lsVnFvdjUwSUxMTng1L3hxMTkrOGRyT1p3?=
 =?utf-8?B?U0tVbVJFN25JdWpJNWhoM3cxZHBFU0N4Y1pSUWl6ZE9IR01VTlZEOFYwbE1G?=
 =?utf-8?B?YzdNNENETFRYNUhLSGR6OXlQK3d3NkMrT3dSOWVHZnZudFdqcWN1THpKZ1pK?=
 =?utf-8?B?MTAwZFRETitxWklHWjBIbm5Dd3h6eXhFbWRhUkNkTExmWkw1azBhaFh1NUdh?=
 =?utf-8?B?ei9OOFZ3YWQ5QnY0RTdqRzJTYnp4NHZIV3RndWlCTC9wYlMwQ2E4dFVNN2Mx?=
 =?utf-8?B?R1ptWllZek9aR1Z4ODhNeG93bS8zcHFLMyt3UXloV1VOa2ZsaklXb2o0SWRB?=
 =?utf-8?B?ZExzWjJhMmxML0hSQXcwUjlzMVZHaGRQbmdBVWd1UGtmNlJwajMxN1FZSlRC?=
 =?utf-8?B?L2RTTjc4cjBVcVYwNkh2bCsweFpiK1RMdzdONWsvMFViM2MvQzFMWnVFYmVt?=
 =?utf-8?B?dnpsVkViKzl5OHFKNVdTWmRKRTNPekkwSld0RzJSQUJEWW4xVVhIV1UvcVpR?=
 =?utf-8?B?VlBqODQwYStPWFM3b01qVFMzUXZzWDBtYkZCd0hzNGd3R0RQdnMyZjFKL1F1?=
 =?utf-8?B?ay9pWGlwNitGYlh5ZDVEQk1nVGNPRTY3aWFIZGxCODFZR2hZL1k1SVhlbmdq?=
 =?utf-8?B?NVhQYk5qdlB3Rm51M3RYQXhVcGZkbThXNFFoYUpOa1NkclRXeVhpQThUbXls?=
 =?utf-8?B?dHlUM3ZEeHMvRWhpWXl4QzdqTy9IdkRuUnhPRS9laEk3MGg5c1V2aG05QXlQ?=
 =?utf-8?B?aFdSalM1RStOQTFXNUZyZHlvUDVlSkg3WWp4dTF6cGpSRmhhb0JwNlluREx6?=
 =?utf-8?B?VGdmQjB2STRpT2trV0YxeVhmRGlLM3c0TUJyOURsZ2ZZVGFrUFFkeFNqY0x4?=
 =?utf-8?B?b2Q0M2VsTlcxZXFOMDFqbU9vSWNqZ0RnTHhMamtCN3ZTaXZxQ3FqdHc3bGFp?=
 =?utf-8?B?aUhGc2gzVk9qR3RDbXRIbjZLTFZFTE04S2VDM1Uyb1hOYzVjUUZpeFRsVTlS?=
 =?utf-8?B?Mis1UmtCS1BkUXNsNy9WSFdwb1FSQ1lLcjRUOVVjKzAwaDJzakQ5dHZvaUpp?=
 =?utf-8?B?YkF1TVVDa2pFU0x4a1lFRXhueWJ1SVlyYWM2by8wSXFkQkxSVU9DVHNGdXVo?=
 =?utf-8?B?M1FzZk9uOXVCWk9nM2NnVW05TllCaU8vS0dyVDlDWXRoR25mQ2c0Z3ZqV2ht?=
 =?utf-8?B?WVZxZStQenlIOElPMVNpZ2NYNURZYndpMGpnTEZIckUyYTRBTDZDVElxYWRw?=
 =?utf-8?B?d2lJeUV6cXMyN042bWMzcy9YMDg0NURiK2ZKQmV4S0E2TnpEYnZ1TXlpbjUw?=
 =?utf-8?B?K0dCKzJrWjQwb1FsQm5KK2JiMmlWUlVKRTVJR0t2SFdnWXNWZElmUHlpcUxm?=
 =?utf-8?B?WHZ2cGVCcWJkS3VSZUVVQlljdHdEMHlXbm5raUFEOCsya1ZsWXp6aktaWWJ3?=
 =?utf-8?B?c3VMQ1hXTENZN0txalBhS0QvbUhBZkwzUWdWVnBTMHZ6ZkJDcll2V2FnNGxs?=
 =?utf-8?B?WGcyRVJMK0phT0IvS1VIaFloUE5SSXhNUDJ1cVgxTkRGV3ZuYmxTeWU2elZn?=
 =?utf-8?B?L1dVbnFvcXFDWW8yS1hjOFJic0k5eUhsbTFsbDFiaWRqVmdTNGk4cnpUYVVL?=
 =?utf-8?B?NEsvS3dvV2lFRWdhdFhaKytHcEl2S0NXWml1eWlEcDBaR2RCYytKVjZzeU01?=
 =?utf-8?B?V2RXNFZpaTM3aFVDNUd5VWMrTEZ1Wmx0djhnV0pPdWo2eWdTRjdsS3U1dFA1?=
 =?utf-8?B?UllzeVZLZ2dOeVlMdW5vVXlKdU40Mk93WjZ3TTlPdGd5RUdGeThrcFZxMjRT?=
 =?utf-8?Q?UpSs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4979c9d0-67fd-4573-e326-08dc7fe5859b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 13:44:54.4914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FMnm17jOWwzkd1tL4krZ9CZkLMpxrFbBsYgUbsCoykVSqc2p0jUL0cVH+E2kdb1AF4fcNJfgym84oZxHpEiB/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9323
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
Cg0KPiBJIGRvbid0IHRoaW5rIHRyeWluZyB0byBhZGQgc29tZSByZXNldCBoYW5kbGluZyBoZXJl
IG1ha2VzIHNlbnNlIGluIHRoZSBmaXJzdCBwbGFjZS4NCj4gUGFydCBvZiB0aGUgcmVzZXQvcmVj
b3ZlcnkgcHJvY2VkdXJlIGlzIHRvIHNpZ25hbCBhbGwgZmVuY2UgYW5kIHRoYXQgaW5jbHVkZXMg
dGhlIG9uZSB3ZSBhcmUgd2FpdGluZyBmb3IgaGVyZS4NCj4gU28gdGhpcyB3YWl0IHNob3VsZCBy
ZXR1cm4gaW1tZWRpYXRlbHkgaW4gYSByZXNldCBhbnl3YXkuDQoNCkFzIGZhciBhcyBJIGNhbiB0
ZWxsLCB0aGVzZSBmZW5jZV9wdHIgcyB0aGF0IGdldCBwb2xsZWQgYXJlIG5vdCBwYWNrYWdlZCBp
bnRvIGEgZmVuY2Ugb2JqLCBhbmQgaW4gcHJhY3RpY2UgSSBzZWUgMTBzIG9mIHNlY29uZHMgd2Fp
dCBiZWZvcmUgdGhlc2UgdGltZW91dCBhbmQgcmVzZXQgY2FuIGJlZ2luLiBBbHNvIGFmdGVyIHJl
c2V0IHRoZXJlIGlzIG9mdGVuIGEgbG9uZyB3YWl0LCB1cCB0byAyIG1pbnV0ZXMsIGZvciBhbGwg
dGhlIHRsYl9mZW5jZV93b3JrIHRvIHRpbWVvdXQgKG5vdCBhZGRyZXNzZWQgYnkgdGhpcyBwYXRj
aCwgc3RpbGwgaGF2ZW4ndCBmaWd1cmUgb3V0IHdoYXQncyBnb2luZyBvbiB0aGVyZSkNCg0KVGVk
ZHkNCg==
