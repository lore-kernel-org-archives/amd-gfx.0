Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB92EE01FB
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 02:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21AB910E57B;
	Wed, 11 Sep 2024 02:10:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xQsaaIc5";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2838C10E57B
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 02:10:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQoCKOKr6Txnd2jtH80kAUIisBG1d/Sfm9eQUeCtt2MTPtK1nCn/VEEnlxejEXNEM6RJE5YFNA6yS2JxMY1vmjAlDqkKrASeNcJHWbyEVWNo71UDZS3euIiHTIL0w+MaT9BjZZyU6w771YZaDVyI3NI7fphZVCjA1q290o2+AaNHUQK4h1BL+YPMZfk9W37r/xjO11Z9mGUpzHDKLqG8pMBL9ZGgpvFAxnoOs5ZzFH1Qy/9CDHuHCzQXtwZ0YczYrk+gkqnQ4jKLjNuKHDwcIXFS53vV+0VZaOrFKdh9hz+jdtMGC7USSpQqF0kEcCyr+rGukGdpJ1Woy30DAc5EJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6clE9eDlQ0giUSEl5Ua/eYkMILtOtipTLF0FAAYa3M=;
 b=ReczpQoVTPYO7njNP14EeX8pBWN/as/TjB4dNSFBDgHJcMgeFvAdVL6JlMAjmeJ6fpjXaGXwp0McxHXssUc6xkyOAG7sH5I2R0yiizuC15wl0G+Uk2esnsh3zAGx1bVs1hX5j9mdWfutQ5Y0Etq62Vcf9isOW8rkexlz5cy1lA3hWrhI4V7Tf5OO9jT3kAbfOmRlaU7m1q6uwHgbewhrR+vSSOcBlJ4qGhJB8TE8+04tc6/xFtLTXsWWBLQODPFDHoTqPIZ8Gh8UWmAM5BzjILQGKeH9zsc+1fKpH5kyFkkCkDN6kQBUwSc0EG/BxR9PiusZDwnja6Suu1WwhSQw0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6clE9eDlQ0giUSEl5Ua/eYkMILtOtipTLF0FAAYa3M=;
 b=xQsaaIc5vCjSPmeENchtDNkjYixlwQFRZAsWYgmi7o63GxGOf/tvqLZx52BUX4cUkGU8ZuNFWr5eJbElm2yCCh/kbIVbdZmkXWNhP6JsWk9fBMztxY/xsnyPUoFoh3qtEGYn3XaUF5HhQb0sSgcVaQ7/REU1PwJYr2ycXjfZ49E=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 02:10:21 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 02:10:20 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable GPU RAS bad page feature for specific
 ASIC
Thread-Topic: [PATCH] drm/amdgpu: disable GPU RAS bad page feature for
 specific ASIC
Thread-Index: AQHbA1yxHpABRIza9EOENl2rJw0QebJRC1OAgAAA7ICAAMu0YA==
Date: Wed, 11 Sep 2024 02:10:20 +0000
Message-ID: <PH7PR12MB879649334ADDC650C766E5ADB09B2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240910083739.20813-1-tao.zhou1@amd.com>
 <dd38b339-06d5-40d5-8013-523bf4ea9c48@amd.com>
 <62c226ab-8006-406d-94ce-31df183e435e@amd.com>
In-Reply-To: <62c226ab-8006-406d-94ce-31df183e435e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5bdb051f-b9cc-4bfd-8ff6-3869d92a0606;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-11T02:07:21Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DM4PR12MB6470:EE_
x-ms-office365-filtering-correlation-id: df6ee248-d9da-4376-7761-08dcd206e363
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aGVmMU9oVzVETDdKSitIYnRWazJQVnJiblBBTit0ZWVPTmVoVHdSZVVrblRK?=
 =?utf-8?B?VHo4SVBlclprTmVRbjcrL2pSSHgvaG1kNlNubXdoV2hjTVU5NU5LYmxWN01q?=
 =?utf-8?B?SjhvYlNpWmYrSG5PVkkwa3VWWlQyWE11c081SzVtRDByTC9tLzY0aXBOOXZw?=
 =?utf-8?B?OENZbnRDMjZNYUIreVd0eTVVL2R1TmdDWmtEVkxBak4rT3lOa0JwbTdFbWN3?=
 =?utf-8?B?N3p0dTg3VHNpcVNjWE5RNWYvMjQ0NWFHek9iRHJEMmV5MDJHV2NTdGhFZTND?=
 =?utf-8?B?K0c1RHdOVzdrcGNtaVlpU2FtdDB2dXRMR2VaSExaNWg4NkRBamlSOGpCRmRm?=
 =?utf-8?B?cWM4elpyeHlPVW5pUU5sSGxuS1BscXVHaXlVTkNQVFFKbzRSR21MTW05WlY3?=
 =?utf-8?B?MFhlT3BVMmFCcFBZZ2dPZjlGcEdDdlY1aFJBMC9ZK1BuYnd3WHk1aHpzV1FS?=
 =?utf-8?B?TXZvbHlGcXJ0UjRWUzZEZVFsRnUxNmdYaDF0RzdOWkJHS2lvMGVQVmNqcG9z?=
 =?utf-8?B?R3N0WjhWOTliNlBGQUU2cVA2WmM3SjdnaXkzdGM1WmpobDZPSEVCbk11V2Rz?=
 =?utf-8?B?L0tnSmc4dTRUNTQ4NUZxZll1djRKUkR2TTlSVmhLZWtVL0MzYXhiazRQMmJE?=
 =?utf-8?B?K09XQlVCWUhZMDJXUW9zMXhDRGxRU01PaHh0U050a2Mzd1IvVzdSVlMrNXVO?=
 =?utf-8?B?b0ZESHJQakhkenpxU2ZyUVR5S1VJQWdiaTdyVGF5SHVGOUtVYU1FaU9mN09H?=
 =?utf-8?B?SHFPcndIV2FZK0x2bFJPNXhMN3JkY0cxU1Myb3FWa1gydTRMZWlDL3UwQXJy?=
 =?utf-8?B?S3VvRnJFYU5JMXlNMHBNTFE0dk5VMzZPMzMrZVR4UGlCQndmbGxyNWwrN2pq?=
 =?utf-8?B?dElwakZYVFBVUTRodmdKM0ZvZFJxQ1J6T1VBSVZXQ2ZQSURvWjhrSkp4RUhj?=
 =?utf-8?B?Si80bytvSGJvWGtqZHJxYkQwbVFVTHMvZjZTb1pzd25mQzRmMER2bk11Vyt1?=
 =?utf-8?B?aUozNitoNFhraFl1a0pzNXZkdy9lSUovODZ1L0Y0ZTlncWxpbUloWWZ2SnRM?=
 =?utf-8?B?S2hqU09DVkt5TWpOYk5Za3RZTm1aeUhENUFhajdoWjlxUkVWeThuYU5vdlVZ?=
 =?utf-8?B?bW9xeENKcGNBZ3RabCttRWh6NTJnMFRiaG9PVHVrOXU0RS9mZXgyYVU5NXFo?=
 =?utf-8?B?WkF1bWNqNmk3aG9YRlptVytsV0ttVE83ZEJqa3AwSVRNVFIxZE8yWmtSTFQx?=
 =?utf-8?B?Yjl1eWdSaXNzR1JLRHRrS01VVFZ2a21ZaEFURVRDU3cvSkEzME9EQmRGN0NX?=
 =?utf-8?B?aGJhRWhqOSsybW8ySndVaFpRd1N0L29SbGRYbTdpKzBwR1R5OVVoSERCeDIx?=
 =?utf-8?B?RFdzVSt1SEpBSzAyTnY5ZDhNVmV4SElWYjNiZmxEQzVOaktSTVkyeUJWMzlQ?=
 =?utf-8?B?R2tTS04yVnpGdWxEWTBZOWxYNzgyOVhlVWo5ZVQzOGhYbDlaRmNyZVBvNWJP?=
 =?utf-8?B?MFZra0tFUXc1Z3h1b0lxOHBIOHFPUkJONTdIM0hOejBlWFZESnc4TlB6ZDFJ?=
 =?utf-8?B?STZOU2RmZm5NMndqcjBoN2dqZi9QcE1UNFk1R1laUW5DeTBQdmM3NExXVnBl?=
 =?utf-8?B?YU9Jc2tBVHp1a01idDFQWFQvL0JVRWZTZjhLRjMrclpIbXZTMndLWXhUdHlu?=
 =?utf-8?B?RGlWT2RFVnlVbHhHLzV3Vzg0WkNsQVkvV3BZV1pweTRvNWlrM1V1YUdJajRN?=
 =?utf-8?B?UEwyRVRidHQ4Nk5LOGlhLzBKSERCWjVrbzR5cHBzVkNkUTZOQ0tzUEg0Umds?=
 =?utf-8?B?b0Y0V29DK211dnkwRU9NY2I4SnhLZnRkdG8zVUhITnVLR0hReXhtai9yK3JD?=
 =?utf-8?B?YVltMXJGMmpvTXZmNCs1c1dZMnNxQWZyS1ZlblRNc01TaUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ry9sWFBTdmlKS0hMdDhkb1lOVnBqbzIvNlI4a2NJRXRabFpSRXNqWjBFeGFr?=
 =?utf-8?B?SXI0ZUYxZ3R6dk9lSkNYVVJzVkJ4a05seTlhV1JlMGl3RFdhR2N5N0hMQUk5?=
 =?utf-8?B?N1BHcnhZZU13cXIxR25JSVd6VlRPcVZKOSs1YTlmMUZLeGNsWW1xWHdWMTBz?=
 =?utf-8?B?NlVibGdRdTdkbHJXSDhmU0Jqd0U3WTRVa0ZyZjV5WFFieHhZYzlaenI0V2Nt?=
 =?utf-8?B?ckcxRklCaGpSK2tucXpuWjF6YUVJSlBKclJuOUZUK3QxcUdnSDFDRGNOMStT?=
 =?utf-8?B?VmlOSEVyckphTkhwL2FDcElxRU1VTHpzNHAvYTJCL2c5RUQ4TlMxQldYdlI5?=
 =?utf-8?B?RHhodXdQT3JLMU8yQnRSbHlMaG5tYXhCZDREK01HQzIvaGpud1BVNFBORVhn?=
 =?utf-8?B?NTlDNDNjNmpsYno4QUVxbXVUTTFzL3ZpSWh5c3ZjbmxZczZhR3VvQWp3VmYw?=
 =?utf-8?B?d003ai8veHFEZHI1REJORmdPeW9RbStLNkpwQTRWZW8vSVN1OXovZVRsUFlV?=
 =?utf-8?B?UGZVb0xzeURqOG1mMFUzMVBtWVBpdWFweEFaRWZsMm5Gais0Ky9HajNKOWlF?=
 =?utf-8?B?NlE5M3p3NlhPbGVVNlRVVk1IdXIyeXoyaXgza3hadVM3ZnlGb1hSNzlHaVB4?=
 =?utf-8?B?T0E0TE1LdGJoTGI2a24zYUhJcHFrZFhrc2hPZUc0eEswNmZzbGlrOWpTY2NK?=
 =?utf-8?B?NmpxREdPT1JSYlVLYVFUY1dHRmhObDhabngyY2pjcXl4cHFHcEMybE5DY3Zk?=
 =?utf-8?B?WkRCTFpxWitIU1NkUUJvMDBpbUpTTnlZSXRnMDVvZlJyaG1QUC92anM1dWtG?=
 =?utf-8?B?TXFPVjRmN0o0cy9nU1J5SE1VYm5ONFFWVUhiTzJMcEgxdFZCU2pUeHB6Lytw?=
 =?utf-8?B?YXdpUGt5dCt2bGJDT1JRZGZHckZkUlA0QWovWk9ySk9MQ0JZZHRLV0Q1K2pS?=
 =?utf-8?B?SnU0T2gvb0wzL1JuRE5DZWNOS1F2Ykp5ZlVCcDVLVXFZcnNRT1ViU3JLRldx?=
 =?utf-8?B?TFN4R2Y5K0dnU24ybDkyNmdFY09sL1JzaEFsWUJKUGdXQStHc0J5VW13cUE3?=
 =?utf-8?B?WEJ0SmJsT0MrV0hWYlNHODU4aXcwRkxKVXZkN1l0eTRoZjZIKzJON0Z5cUhh?=
 =?utf-8?B?OFh6azdRNHcwRUEweS9YT3daWUhnNDN0Q3ZIQUxEekdQcytrUlBLVTRDeEE5?=
 =?utf-8?B?RElzbGJTcVZTTDdrZGUxR0JlZTFkeVRTaWhFcy83bTZUVEtNNGJGbGkxNEpn?=
 =?utf-8?B?bnhRdEtndVZjU2Y4MDVwTFk4TGhoWXFIWnRKOWtDakxVSjZQQzBWSTFIN1Ex?=
 =?utf-8?B?S0Mvb2E3SUlxYU05aVFYUHB0VkJDTEV2WCt6L2JwTkZxeDhzRnhrdGJreC85?=
 =?utf-8?B?ZmZ6aGNaTVhLeTI5TkdvWFNGUnJKUFJvMWJnUTBmMkVSeHR6eUdYUXlJd3hz?=
 =?utf-8?B?aHBLRUVpVlBRalk0Z2Rienc3RW1yQmRoOVhlc2lieFB4Ris3blNMTlhNeGEx?=
 =?utf-8?B?OW9QRGJhWjEwZHhlQVYvMCtKVzdzbVpCQ1BVVUo5Y05kZmdmOEkwLzdNVE16?=
 =?utf-8?B?MVEwOWRIRlVFdk00SENjVEEveEJLODh4QUlCUGZiS1ZlQSt6Z0pGOVg1NE51?=
 =?utf-8?B?Qm5PbU92Q20zV0NvcG4vK3hxbXV1ejlaM0xaUDBuMGNBODdTQzRtYkpYZ2hH?=
 =?utf-8?B?QW1BYXpvUWFFK1BaN29CNnNYQWJHSEg5VllORzV6SmMwMmVmOU04N050RHVx?=
 =?utf-8?B?eTQwckRjR1Z0azhheXBwaHlJZUpaRElHWklJVFdrMmQrVzg2SVZ0RnJwVnNP?=
 =?utf-8?B?WE1ldHRaWG81UzQydEpsOEcvQkJWOEJRNWRrdXdEdWJvSlF2blpwQ2J3aHhr?=
 =?utf-8?B?Q2tuU1AxRHpraWRpN2g2SmtseXkwb3VLKzU5ckU2c0dkckx4djZOdFIySmV6?=
 =?utf-8?B?U2x5TDJ6WlRKdm00Umx1aWJlcXE3cElDMllRbktMbkx6SVFLaGxneklkUjUr?=
 =?utf-8?B?UUp1ei9BdHJqRXRibVgvR1ZJenJwSXl4NGtvVXhMamRXZ21wZFZ5MXVHSXVq?=
 =?utf-8?B?Z0xDSWRLSmlDZWYzM0ZWWjJsN1hyVTJIdHBTNDBNNE1RVGFVUzNBS0wyR1ND?=
 =?utf-8?Q?uoJg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6ee248-d9da-4376-7761-08dcd206e363
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 02:10:20.6029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +hDN0ezf1xS6AuzIi2PI56ifzL1sHTJHY9KDq81NnUThZpjcYE0mVeErCCIdN72R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470
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
Cg0KSXQncyBub3QgdHJ1ZSwgdGhlIGZlYXR1cmUgb24gZ3B1IHNpZGUgaXMgQVNJQyBzcGVjaWZp
YyBldmVuIGZvciBBUFUuDQoNClJlZ2FyZHMsDQpUYW8NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50
OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTAsIDIwMjQgOTo1OCBQTQ0KPiBUbzogWmhvdTEsIFRhbyA8
VGFvLlpob3UxQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzog
WmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gZHJtL2FtZGdwdTogZGlzYWJsZSBHUFUgUkFTIGJhZCBwYWdlIGZlYXR1cmUgZm9yIHNw
ZWNpZmljDQo+IEFTSUMNCj4NCj4NCj4gT24gYSBzZWNvbmQgdGhvdWdodCwgdGhpcyBtYXkgYmUg
bWFkZSBtb3JlIGdlbmVyaWMgYnkganVzdCBjaGVja2luZyBBUFUgZmxhZyAtDQo+IGhvbGRzIHRy
dWUgZm9yIGFueSBBUFUgaW4gZ2VuZXJhbC4NCj4NCj4gVGhhbmtzLA0KPiBMaWpvDQo+DQo+IE9u
IDkvMTAvMjAyNCA3OjI0IFBNLCBMYXphciwgTGlqbyB3cm90ZToNCj4gPg0KPiA+DQo+ID4gT24g
OS8xMC8yMDI0IDI6MDcgUE0sIFRhbyBaaG91IHdyb3RlOg0KPiA+PiBUaGUgZmVhdHVyZSBpcyBu
b3QgYXBwbGljYWJsZSB0byBzcGVjaWZpYyBhcHAgcGxhdGZvcm0uDQo+ID4+DQo+ID4+IHYyOiB1
cGRhdGUgdGhlIGRpc2FibGVtZW50IGNvbmRpdGlvbiBhbmQgY29tbWl0IGRlc2NyaXB0aW9uDQo+
ID4+IHYzOiBtb3ZlIHRoZSBzZXR0aW5nIHRvIGFtZGdwdV9yYXNfY2hlY2tfc3VwcG9ydGVkDQo+
ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFRhbyBaaG91IDx0YW8uemhvdTFAYW1kLmNvbT4NCj4g
Pj4gUmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4g
Pg0KPiA+IFJldmlld2VkLWJ5OiBMaWpvIExhemFyIDxsaWpvLmxhemFyQGFtZC5jb20+DQo+ID4N
Cj4gPiBUaGFua3MsDQo+ID4gTGlqbw0KPiA+DQo+ID4+IC0tLQ0KPiA+PiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwgNSArKysrKw0KPiA+PiAgMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+ID4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Jhcy5jDQo+ID4+IGluZGV4IGRiZmM0MWRkYzNjNy4uZWJlM2U4ZjAxZmUy
IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFz
LmMNCj4gPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+
ID4+IEBAIC0zNDgzLDYgKzM0ODMsMTEgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3Jhc19jaGVja19z
dXBwb3J0ZWQoc3RydWN0DQo+ID4+IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4+DQo+ID4+ICAg
IC8qIGFjYSBpcyBkaXNhYmxlZCBieSBkZWZhdWx0ICovDQo+ID4+ICAgIGFkZXYtPmFjYS5pc19l
bmFibGVkID0gZmFsc2U7DQo+ID4+ICsNCj4gPj4gKyAgLyogYmFkIHBhZ2UgZmVhdHVyZSBpcyBu
b3QgYXBwbGljYWJsZSB0byBzcGVjaWZpYyBhcHAgcGxhdGZvcm0gKi8NCj4gPj4gKyAgaWYgKGFk
ZXYtPmdtYy5pc19hcHBfYXB1ICYmDQo+ID4+ICsgICAgICBhbWRncHVfaXBfdmVyc2lvbihhZGV2
LCBVTUNfSFdJUCwgMCkgPT0gSVBfVkVSU0lPTigxMiwgMCwgMCkpDQo+ID4+ICsgICAgICAgICAg
YW1kZ3B1X2JhZF9wYWdlX3RocmVzaG9sZCA9IDA7DQo+ID4+ICB9DQo+ID4+DQo+ID4+ICBzdGF0
aWMgdm9pZCBhbWRncHVfcmFzX2NvdW50ZV9kdyhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo=
